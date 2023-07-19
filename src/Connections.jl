using HTTP
using JSON3

abstract type AbstractConnection end
abstract type AuthorizedConnection <: AbstractConnection end

struct UnAuthorizedConnection <: AbstractConnection
    host::String
    version::String
end

struct BasicAuthConnection <: AuthorizedConnection
    host::String
    version::String
    access_token::Union{String,Nothing}
end

struct OpenIDConnection <: AuthorizedConnection
end

const default_headers = [
    "Accept" => "application/json",
    "Content-Type" => "application/json"
]

n_existing_connections = 0

function fetchApi(url, method="GET", headers=deepcopy(default_headers), kw...)
    response = HTTP.request(method, url, headers, kw...)
    response_type = Dict(response.headers)["Content-Type"]
    if response_type == "application/json"
        response_string = String(response.body)
        response_dict = JSON3.read(response_string)
        return response_dict
    else
        return response
    end
end

function fetchApi(connection::AbstractConnection, path::String, method="GET", headers=deepcopy(default_headers), kw...)
    url = "https://$(connection.host)/$(connection.version)/$(path)"
    response = fetchApi(url, method, headers, kw...)
    return response
end

function fetchApi(connection::AuthorizedConnection, path::String, method="GET", headers=deepcopy(default_headers), kw...)
    url = "https://$(connection.host)/$(connection.version)/$(path)"
    append!(headers, ["Authorization" => "Bearer basic//$(connection.access_token)"])
    response = fetchApi(url, method, headers, kw...)
    return response
end

function connect(host, version)
    processes_code = get_processes_code(host, version)
    global n_existing_connections += 1
    module_str = """
    module Connection$(n_existing_connections)
        using OpenEOClient
        const connection = OpenEOClient.UnAuthorizedConnection("$host", "$version")
        const collections = OpenEOClient.list_collections(connection)

        $processes_code
    end
    """

    eval(Meta.parse(module_str))
end

function connect(host, version::String, username::String, password::String)
    access_response = fetchApi("https://$(username):$(password)@$(host)/$(version)/credentials/basic")
    access_token = access_response["access_token"]

    processes_code = get_processes_code(host, version)
    global n_existing_connections += 1
    module_str = """
    module Connection$(n_existing_connections)
        using OpenEOClient
        const connection = OpenEOClient.BasicAuthConnection("$host", "$version", "$access_token")
        const collections = OpenEOClient.list_collections(connection)

        $processes_code
    end
    """
    eval(Meta.parse(module_str))
end