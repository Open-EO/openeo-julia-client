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

function fetch(url, method="GET")
    try
        response = HTTP.request(method, url)
        response_dict = JSON.parse(String(response.body))
        return response_dict
    catch e
        throw(ErrorException(e))
    end
end

function fetch(connection::AbstractConnection, path::String, method="GET")
    url = "https://$(connection.host)/$(connection.version)/$(path)"
    try
        response = HTTP.request(method, url)
        response_dict = JSON.parse(String(response.body))
        return response_dict
    catch e
        throw(ErrorException(e))
    end
end

function fetch(connection::AuthorizedConnection, path::String, method="GET")
    url = "https://$(connection.host)/$(connection.version)/$(path)"
    headers = ["Authorization" => "Bearer basic//$(connection.access_token)"]
    try
        response = HTTP.request(method, url, headers=headers)
        response_dict = JSON.parse(String(response.body))
        return response_dict
    catch e
        throw(ErrorException(e))
    end
end

function Connection(host, version)
    UnAuthorizedConnection(host, version)
end

function Connection(host, username::String, password::String, version::String)
    access_response = fetch("https://$(username):$(password)@$(host)/$(version)/credentials/basic")
    access_token = access_response["access_token"]
    BasicAuthConnection(host, version, access_token)
end