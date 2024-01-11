using JSON3

"""
Lists all predefined processes and returns detailed process descriptions, including parameters and return values.
"""
function list_processes(connection::AbstractCredentials)
    response = fetchApi(connection, "processes"; output_type=ProcessesRoot)
    response isa Exception ? throw(response) : true
    return response.processes
end

"""
Lists all batch jobs submitted by a user.
"""
function list_jobs(connection::AuthorizedCredentials)
    response = fetchApi(connection, "jobs")
    response isa Exception ? throw(response) : true
    jobs = response["jobs"]
    return jobs
end

"""
Lists available collections with at least the required information.
"""
function list_collections(connection::AbstractCredentials)
    response = fetchApi(connection, "collections"; output_type=CollectionsRoot)
    response isa Exception ? throw(response) : true
    collections = response.collections
    return collections
end

"""
Lists all information about a specific collection specified by the identifier 
"""
function describe_collection(connection::AbstractCredentials, id::String)
    # TODO: parse to collection type
    response = fetchApi(connection, "collections/$(id)")
    response isa Exception ? throw(response) : true
    return response
end

Base.@kwdef struct BoundingBox{T<:Real}
    west::T
    south::T
    east::T
    north::T
end
StructTypes.StructType(::Type{BoundingBox}) = StructTypes.Struct()

function json(x)
    x |> JSON3.write |> JSON3.read
end