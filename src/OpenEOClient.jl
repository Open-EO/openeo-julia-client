module OpenEOClient

include("Connections.jl")
include("Processes.jl")
include("API.jl")

export
    connect,
    list_collections,
    describe_collection,
    list_jobs,
    list_processes,
    register_processes,
    Process,
    Proccesses,
    save_result
end