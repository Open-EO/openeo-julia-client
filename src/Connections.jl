import SHA
import Random
import Base64
import HTTP
import JSON3

"OpenID Connect device flow + PKCE"
function get_acces_token(discovery_url::String, client_id::String, scopes::AbstractVector)
    oidc_config = HTTP.get(discovery_url).body |> JSON3.read

    code_verifier = Random.randstring(128)
    hash = SHA.sha256(code_verifier)
    # see https://datatracker.ietf.org/doc/html/rfc7636#appendix-B
    code_challenge = hash |> Base64.base64encode |> x -> strip(x, '=') |> x -> replace(x, "+" => "-", "/" => "_")

    headers = ["content-type" => "application/x-www-form-urlencoded"]
    args = Dict(
        "client_id" => client_id,
        "grant_type" => "urn:ietf:params:oauth:grant-type:device_code",
        "code_challenge_method" => "S256",
        "code_challenge" => code_challenge,
        "scope" => join(scopes, " ") # EDIT: Use space instead of ','
    )
    body = HTTP.URIs.escapeuri(args)
    device_code_request = HTTP.post(oidc_config.device_authorization_endpoint, headers, body) |> x -> x.body |> String |> JSON3.read

    @info "Please log in using any device at:\n" *
          device_code_request.verification_uri_complete *
          "\nWaiting until log in succeeded..."

    while true
        headers = ["content-type" => "application/x-www-form-urlencoded"]
        args = Dict(
            "grant_type" => "urn:ietf:params:oauth:grant-type:device_code",
            "device_code" => device_code_request.device_code,
            "client_id" => client_id,
            "code_verifier" => code_verifier
        )
        body = HTTP.URIs.escapeuri(args)

        try
            access_token = HTTP.post(oidc_config.token_endpoint, headers, body) |>
                           x -> x.body |> String |> JSON3.read |> x -> x.access_token
            return access_token
        catch e
            sleep(device_code_request.interval)
        end
    end
end

abstract type AbstractConnection end

struct UnAuthorizedConnection <: AbstractConnection
    host::String
    version::String
end

Base.show(io::IO, c::UnAuthorizedConnection) = print(io, "unauthorized openEO connection to https://$(c.host)/$(c.version)")

struct AuthorizedConnection <: AbstractConnection
    host::String
    version::String
    authorization::String
end

Base.show(io::IO, c::AuthorizedConnection) = print(io, "authorized openEO connection to https://$(c.host)/$(c.version)")

"HTTP basic authentification"
function AuthorizedConnection(host, version, username, password)
    access_response = fetchApi("https://$(username):$(password)@$(host)/$(version)/credentials/basic")
    access_token = access_response.access_token
    access_token = get_access_token(host, version, username, password)
    authorization = "Bearer basic//$access_token"
    AuthorizedConnection(host, version, authorization)
end

"OpenID Connect device flow + PKCE authentification"
function AuthorizedConnection(host, version)
    provider = fetchApi("https://$(host)/$(version)/credentials/oidc").providers[1]
    if endswith(provider.issuer, "/")
        discovery_url = "$(provider.issuer).well-known/openid-configuration"
    else
        discovery_url = "$(provider.issuer)/.well-known/openid-configuration"
    end
    client_id = provider.default_clients[1].id
    scopes = provider.scopes
    access_token = get_acces_token(discovery_url, client_id, scopes)
    authorization = "Bearer oidc/$(provider.id)/$access_token"
    AuthorizedConnection(host, version, authorization)
end

@enum AuthMethod no_auth basic_auth oidc_auth

const default_headers = [
    "Accept" => "application/json",
    "Content-Type" => "application/json"
]

n_existing_connections = 0

function fetchApi(url; method="GET", headers=deepcopy(default_headers), output_type::Type=Any, body::String="", kw...)
    try
        response = HTTP.request(method, url, headers, body; kw...)
        response_type = Dict(response.headers)["Content-Type"]
        if response_type == "application/json"
            response_string = String(response.body)
            response_converted = output_type == Any ? JSON3.read(response_string) : JSON3.read(response_string, output_type)
            return response_converted
        else
            return response
        end
    catch e
        @error e
    end
end

function fetchApi(connection::AbstractConnection, path::String; kw...)
    url = "https://$(connection.host)/$(connection.version)/$(path)"
    response = fetchApi(url; kw...)
    return response
end

function fetchApi(connection::AuthorizedConnection, path::String; headers=deepcopy(default_headers), kw...)
    url = "https://$(connection.host)/$(connection.version)/$(path)"
    append!(headers, ["Authorization" => connection.authorization])
    response = fetchApi(url; headers=headers, kw...)
    return response
end

struct ConnectionInstance
    connection::AbstractConnection
    collections::Vector
    processes::Dict{Symbol}
end
Base.Docs.Binding(x::ConnectionInstance, s::Symbol) = getproperty(x, s)
Base.propertynames(i::ConnectionInstance, _::Bool=false) = [collect(keys(getfield(i, :processes))); :compute_result]
function Base.getproperty(i::ConnectionInstance, k::Symbol)
    if k in (:connection, :collections, :processes)
        getfield(i, k)
    elseif k == :compute_result
        Base.Fix1(compute_result, getfield(i, :connection))
    else
        getfield(i, :processes)[k]
    end
end


function connect(host, version, auth_method::AuthMethod=no_auth)
    connection = if auth_method == no_auth
        OpenEOClient.UnAuthorizedConnection("$host", "$version")
    elseif auth_method == oidc_auth
        OpenEOClient.AuthorizedConnection("$host", "$version")
    end
    connect(connection)
end

function connect(host, version::String, username::String, password::String)
    access_response = fetchApi("https://$(username):$(password)@$(host)/$(version)/credentials/basic")
    access_token = access_response["access_token"]
    connection = OpenEOClient.AuthorizedConnection("$host", "$version", "Bearer basic//$access_token")
    connect(connection)
end

function connect(connection::AbstractConnection)
    collections = OpenEOClient.list_collections(connection)
    processes = OpenEOClient.list_processes(connection)
    processesdict = Dict(Symbol(p.id) => p for p in processes)
    ConnectionInstance(connection, collections, processesdict)
end
