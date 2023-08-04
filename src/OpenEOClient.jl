module OpenEOClient

include("Connections.jl")
include("Processes.jl")
include("ProcessGraph.jl")
include("Collections.jl")
include("API.jl")

export
    connect,
    list_collections,
    describe_collection,
    list_jobs,
    list_processes,
    register_processes,
    ProcessNode,
    Processes,
    ProcessGraph,
    ProcessGraph,
    BoundingBox,
    compute_result
end
