module OpenEOClient

using Infiltrator

include("Connections.jl")
include("Processes.jl")
include("ProcessGraph.jl")
include("Collections.jl")
include("API.jl")
include("Cubes.jl")

export
    connect,
    list_collections,
    describe_collection,
    list_jobs,
    list_processes,
    register_processes,
    ProcessCall,
    Processes,
    ProcessGraph,
    ProcessGraph,
    BoundingBox,
    DataCube,
    compute_result,
    reduce_dimension,
    print_json,
    get_band,
    Band
end
