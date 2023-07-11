using DataFrames

"""
Lists all predefined processes and returns detailed process descriptions, including parameters and return values.
"""
function list_processes(connection::AbstractConnection)
    response = fetch(connection, "processes")
    ids = [x["id"] for x in response["processes"]]
    processes = DataFrame(id=ids)
    return processes
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
    jobs = DataFrame(response["collections"])
    return jobs
end