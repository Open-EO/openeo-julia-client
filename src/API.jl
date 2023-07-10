using DataFrames

function list_processes(connection::AbstractConnection)
    response = fetch(connection, "processes")
    ids = [x["id"] for x in response["processes"]]
    processes = DataFrame(id=ids)
    return processes
end

function list_jobs(connection::AuthorizedConnection)
    response = fetch(connection, "jobs")
    jobs = DataFrame(response["jobs"])
    return jobs
end