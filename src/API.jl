using JSON3
using DataFrames

"""
Lists all predefined processes and returns detailed process descriptions, including parameters and return values.
"""
function list_processes(connection::AbstractConnection)
    response = fetch(connection, "processes")
    return response.processes
end

"""
Lists all batch jobs submitted by a user.
"""
function list_jobs(connection::AuthorizedConnection)
    response = fetch(connection, "jobs")
    jobs = DataFrame(response["jobs"])
    return jobs
end

"""
Lists available collections with at least the required information.
"""
function list_collections(connection::AbstractConnection)
    response = fetch(connection, "collections")
    collections = DataFrame(response["collections"])
    columns = filter(x -> x in names(collections), ["id", "title", "description", "deprecated"])
    collections = select(collections, columns)
    return collections
end

"""
Lists all information about a specific collection specified by the identifier 
"""
function describe_collection(connection::AbstractConnection, id::String)
    response = fetch(connection, "collections/$(id)")
    return response
end

"""
Process and download data synchronously
"""
function save_result(connection::AbstractConnection, process_graph::Dict{<:Any})
    query = Dict(
        "process" => Dict(
            "process_graph" => process_graph
        )
    )
    headers = [
        "Accept" => "*",
        "Content-Type" => "application/json"
    ]
    response = fetch(connection, "result", "POST", headers, json(query))
    return response
end