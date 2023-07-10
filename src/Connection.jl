using HTTP
using JSON

struct Connection
    host::String
    version::String
    access_token::Union{String,Nothing}
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

function Connection(host, username::String, password::String, version::String)
    access_response = fetch("https://$(username):$(password)@$(host)/$(version)/credentials/basic")
    access_token = access_response["access_token"]
    Connection(host, version, access_token)
end