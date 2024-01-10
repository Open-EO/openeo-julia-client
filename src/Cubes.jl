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
    connection
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

    println(io, "openEO DataCube")
    println(io, "   collection: $(c.collection.id)")
    println(io, "   bands: $bands_str")
    println(io, "   spatial extent: $(c.spatial_extent)")
    println(io, "   temporal extent: $(c.temporal_extent)")
    println(io, "   license: $(c.license)")
    print(io, "   connection: https://$(c.connection.connection.host)/$(c.connection.connection.version)")
end

function DataCube(connection::ConnectionInstance, collection_id::String, spatial_extent::BoundingBox, temporal_extent::Tuple{String,String}, bands::Vector{String})
    collection = describe_collection(connection.connection, collection_id)

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

function DataCube(connection::ConnectionInstance, collection_id)
    collection = describe_collection(connection.connection, collection_id)

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
            :data => Dict(:from_parameter => "data"),
            :index => findfirst(x -> x == band, cube.bands) - 1
        )) |> ProcessGraph
    )
    call = ProcessCall("reduce_dimension", args)
    return DataCube(cube.connection, call, nothing, cube.spatial_extent, cube.temporal_extent, cube.description, cube.license, cube.collection)
end

Base.getindex(cube::DataCube, band_name) = get_band(cube, band_name)

compute_result(cube::DataCube) = cube.call |> ProcessGraph |> cube.connection.compute_result
ProcessGraph(cube::DataCube) = ProcessGraph(cube.call)

function +(x::DataCube, y::Real)
    call = ProcessCall("apply", Dict(
        :data => x.call,
        :process => ProcessCall("add", Dict(
                :x => ProcessCallParameter("x"),
                :y => y
            ); result=true) |> ProcessGraph
    ))

    return DataCube(
        x.connection, call, nothing,
        x.spatial_extent, x.temporal_extent,
        x.collection.description,
        x.collection.license,
        x.collection
    )
end