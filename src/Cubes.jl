#
# julia types and functions representing openeEO functionality
#   - meant to be used directly by the user
#   - convertsion chain: DataCube -> ProcessCall -> openEO JSON
#

import Base: convert, promote, promote_rule
import Base: +, -, *, /, cos, sqrt, abs

"""
openEO n-dimensional array of ratser data
represented by the process graph with root node `call` to create it.
This process graph can be grown iterativeley by applying functions and operators to `DataCube` instances.
"""
struct DataCube
    connection::Connection
    call::ProcessCall

    bands
    spatial_extent
    temporal_extent
    description
    license
    collection
end

function Base.show(io::IO, ::MIME"text/plain", c::DataCube)
    bands_str = if isnothing(c.bands)
        "Single band"
    elseif length(c.bands) == 1
        c.bands[1]
    elseif length(c.bands) <= 5
        c.bands
    else
        c.bands[1:min(length(c.bands), 5)] |> x -> vcat(x, ["..."]) |> x -> join(x, ", ")
    end

    collection_str = isnothing(c.collection) ? "Unknown" : c.collection["id"]

    println(io, "openEO DataCube")
    println(io, "   collection: $collection_str")
    println(io, "   bands: $bands_str")
    println(io, "   spatial extent: $(c.spatial_extent)")
    println(io, "   temporal extent: $(c.temporal_extent)")
    println(io, "   license: $(c.license)")
    print(io, "   connection: https://$(c.connection.credentials.host)/$(c.connection.credentials.version)")
end

function DataCube(connection::Connection, collection_id::String, spatial_extent::BoundingBox, temporal_extent::Tuple{String,String}, bands::Vector{String})
    collection = describe_collection(connection.credentials, collection_id)

    call = ProcessCall("load_collection", Dict(
        :id => collection_id,
        :spatial_extent => spatial_extent,
        :temporal_extent => temporal_extent,
        :bands => bands
    ))

    return DataCube(
        connection, call, bands,
        spatial_extent, temporal_extent,
        collection.description,
        collection.license,
        collection
    )
end

function DataCube(connection::Connection, collection_id)
    collection = describe_collection(connection.credentials, collection_id)

    bands = try
        collection["cube:dimensions"].bands.values |> Vector{String}
    catch nothing
    end

    spatial_extent = try
        west = collection["cube:dimensions"].x.extent[1]
        east = collection["cube:dimensions"].x.extent[2]
        south = collection["cube:dimensions"].y.extent[1]
        north = collection["cube:dimensions"].y.extent[2]
        BoundingBox(west, south, east, north)
    catch
        nothing
    end

    temporal_extent = try
        collection["cube:dimensions"].t.extent |> Tuple
    catch nothing
    end

    call = ProcessCall("load_collection", Dict(
        :id => collection_id,
        :spatial_extent => spatial_extent,
        :temporal_extent => temporal_extent,
        :bands => bands
    ))

    return DataCube(
        connection, call, bands,
        spatial_extent, temporal_extent,
        collection.description,
        collection.license,
        collection
    )
end

function get_band(cube::DataCube, band::String)
    band in cube.bands || error("Band $get_band must be one of $(cube.arguments[:bands])")

    args = Dict(
        :data => cube.call,
        :dimension => "bands",
        :reducer => ProcessCall("array_element", Dict(
            :data => ProcessCallParameter("data"),
            :index => findfirst(x -> x == band, cube.bands) - 1
        )) |> ProcessGraph
    )
    call = ProcessCall("reduce_dimension", args)
    return DataCube(cube.connection, call, nothing, cube.spatial_extent, cube.temporal_extent, cube.description, cube.license, cube.collection)
end

Base.getindex(cube::DataCube, band_name) = get_band(cube, band_name)

compute_result(cube::DataCube) = cube.call |> ProcessGraph |> cube.connection.compute_result
ProcessGraph(cube::DataCube) = ProcessGraph(cube.call)

function binary_operator(cube::DataCube, number::Real, openeo_process::String, reverse=false)
    #TODO: use band math with reduce_dimension if no band dimensions available
    #TODO: merge sucessive operators by appending op to previous process call 

    args = if reverse
        Dict(
            :x => number,
            :y => ProcessCallParameter("y")
        )
    else
        Dict(
            :x => ProcessCallParameter("x"),
            :y => number
        )
    end

    call = ProcessCall("apply", Dict(
        :data => cube.call,
        :process => ProcessCall(openeo_process, args; result=true) |> ProcessGraph
    ))

    return DataCube(
        cube.connection, call, nothing,
        cube.spatial_extent, cube.temporal_extent,
        cube.collection.description,
        cube.collection.license,
        cube.collection
    )
end

merge(a, b) = a == b ? a : nothing

function binary_operator(cube1::DataCube, cube2::DataCube, openeo_process::String)
    #TODO: use band math with reduce_dimension if no band dimensions available
    #TODO: merge sucessive operators by appending op to previous process call 

    cube1.connection == cube2.connection || error("Cubes must use the same connection")
    cube1.collection == cube2.collection || @warn "Cubes originate from different collections"
    cube1.spatial_extent == cube2.spatial_extent || @warn "Cubes have different spatial extents"
    cube1.temporal_extent == cube2.temporal_extent || @warn "Cubes have different temporal extents"

    call = ProcessCall("merge_cubes", Dict(
        :cube1 => cube1.call,
        :cube2 => cube2.call,
        :overlap_resolver => ProcessCall(openeo_process, Dict(
                :x => ProcessCallParameter("x"),
                :y => ProcessCallParameter("y")
            ); result=true) |> ProcessGraph
    ))

    return DataCube(
        cube1.connection, call, nothing,
        merge(cube1.spatial_extent, cube2.spatial_extent),
        merge(cube1.temporal_extent, cube2.temporal_extent),
        merge(cube1.description, cube2.description),
        merge(cube1.license, cube2.license),
        merge(cube1.collection, cube2.collection)
    )
end

+(cube::DataCube, number::Real) = binary_operator(cube, number, "add")
+(number::Real, cube::DataCube) = binary_operator(cube, number, "add", true)
-(cube::DataCube, number::Real) = binary_operator(cube, number, "subtract")
-(number::Real, cube::DataCube) = binary_operator(cube, number, "subtract", true)
*(cube::DataCube, number::Real) = binary_operator(cube, number, "multiply")
*(number::Real, cube::DataCube) = binary_operator(cube, number, "multiply", true)
/(cube::DataCube, number::Real) = binary_operator(cube, number, "divide")
/(number::Real, cube::DataCube) = binary_operator(cube, number, "divide", true)

# element wise operations of two data cubes
+(cube1::DataCube, cube2::DataCube) = binary_operator(cube1, cube2, "add")
-(cube1::DataCube, cube2::DataCube) = binary_operator(cube1, cube2, "subtract")
*(cube1::DataCube, cube2::DataCube) = binary_operator(cube1, cube2, "multiply")
/(cube1::DataCube, cube2::DataCube) = binary_operator(cube1, cube2, "divide")