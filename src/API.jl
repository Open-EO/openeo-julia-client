using JSON3
using DataFrames

"""
Lists all predefined processes and returns detailed process descriptions, including parameters and return values.
"""
function list_processes(connection::AbstractConnection)
    response = fetchApi(connection, "processes"; output_type=ProcessesRoot)
    return response.processes
end

"""
Lists all batch jobs submitted by a user.
"""
function list_jobs(connection::AuthorizedConnection)
    response = fetchApi(connection, "jobs")
    jobs = response["jobs"]
    return jobs
end

"""
Lists available collections with at least the required information.
"""
function list_collections(connection::AbstractConnection)
    response = fetchApi(connection, "collections"; output_type=CollectionsRoot)
    collections = response.collections
    return collections
end

"""
Lists all information about a specific collection specified by the identifier 
"""
function describe_collection(connection::AbstractConnection, id::String)
    response = fetchApi(connection, "collections/$(id)")
    return response
end

"""
Process and download data synchronously
"""
function save_result(connection::AbstractConnection, process_graph::AbstractDict, filepath::String="")
    query = Dict(
        "process" => Dict(
            "process_graph" => Dict(process_graph)
        )
    )

    headers = [
        "Accept" => "*",
        "Content-Type" => "application/json"
    ]
    response = fetchApi(connection, "result"; method="POST", headers=headers, body=JSON3.write(query))

    if isempty(filepath)
        file_extension = split(Dict(response.headers)["Content-Type"], "/")[2]
        filepath = "out." * file_extension
    end

    write(open(filepath, "w"), response.body)
    return filepath
end