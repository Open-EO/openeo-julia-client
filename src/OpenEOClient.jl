module OpenEOClient

using Infiltrator

include("Connections.jl")
include("Processes.jl")
include("ProcessGraph.jl")
include("Collections.jl")
include("API.jl")
include("Cubes.jl")

export
    Band,
    BoundingBox,
    compute_result,
    connect,
    DataCube,
    describe_collection,
    to_band,
    list_collections,
    list_jobs,
    list_processes,
    print_json,
    ProcessCall,
    Processes,
    ProcessGraph,
    reduce_dimension,
    register_processes
end
