module OpenEOClient

include("Connection.jl")
include("API.jl")

export
    connect,
    list_collections,
    list_jobs,
    list_processes
end
