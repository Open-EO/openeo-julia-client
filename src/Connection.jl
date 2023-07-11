using HTTP
using JSON

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

function fetch(url, method="GET", headers=[], kw...)
    append!(headers, ["Accept" => "application/json"])
    try
        response = HTTP.request(method, url, headers, kw...)
        response_string = String(response.body)
        response_dict = JSON.parse(response_string)
        return response_dict
    catch e
        throw(ErrorException(e))
    end
end

function fetch(connection::AbstractConnection, path::String, method="GET")
    url = "https://$(connection.host)/$(connection.version)/$(path)"
    response = fetch(url, method)
    return response
end

function fetch(connection::AuthorizedConnection, path::String, method="GET")
    url = "https://$(connection.host)/$(connection.version)/$(path)"
    headers = ["Authorization" => "Bearer basic//$(connection.access_token)"]
    response = fetch(url, method, headers)
    return response
end

function connect(host, version)
    UnAuthorizedConnection(host, version)
end

function connect(host, username::String, password::String, version::String)
    access_response = fetch("https://$(username):$(password)@$(host)/$(version)/credentials/basic")
    access_token = access_response["access_token"]
    BasicAuthConnection(host, version, access_token)
end