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

function fetch(url, method="GET", headers=deepcopy(default_headers), kw...)
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

function fetch(connection::AbstractConnection, path::String, method="GET", headers=deepcopy(default_headers), kw...)
    url = "https://$(connection.host)/$(connection.version)/$(path)"
    response = fetch(url, method, headers, kw...)
    return response
end

function fetch(connection::AuthorizedConnection, path::String, method="GET", headers=deepcopy(default_headers), kw...)
    url = "https://$(connection.host)/$(connection.version)/$(path)"
    append!(headers, ["Authorization" => "Bearer basic//$(connection.access_token)"])
    response = fetch(url, method, headers, kw...)
    return response
end

function connect(host, version)
    connection = UnAuthorizedConnection(host, version)
    register_processes(connection)
    return connection
end

function connect(host, username::String, password::String, version::String)
    access_response = fetch("https://$(username):$(password)@$(host)/$(version)/credentials/basic")
    access_token = access_response["access_token"]
    connection = BasicAuthConnection(host, version, access_token)
    register_processes(connection)
    return connection
end