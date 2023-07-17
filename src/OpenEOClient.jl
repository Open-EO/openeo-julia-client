module OpenEOClient

include("Connection.jl")
include("API.jl")

export
    connect,
    list_collections,
    describe_collection,
    list_jobs,
    list_processes,
    save_result
end
