module OpenEOClient

include("Connection.jl")
include("API.jl")

export
    connect,
    list_collections,
    load_collection,
    list_jobs,
    list_processes,
    save_result
end
