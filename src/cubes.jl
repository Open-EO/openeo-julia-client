#
# julia types and functions representing openeEO functionality
#   - meant to be used directly by the user
#   - convertsion chain: DataCube -> ProcessCall -> openEO JSON
#

import Base: convert, promote, promote_rule
import Base: +, -, *, /, cos, sqrt, abs

struct DataCube
    op
    children::Vector
end

DataCube(x::DataCube) = x
DataCube(x) = DataCube("create", [x])
"Create Placeholder node e.g. for user defined functions in reducers and apply functions"
DataCube() = DataCube("create", [nothing])

function DataCube(con::ConnectionInstance, collection_id::String, spatial_extent::BoundingBox, temporal_extent, bands::Vector{String})
    DataCube("openeo_call", [con.load_collection(collection_id, spatial_extent, temporal_extent, bands)])
end

isleaf(n::DataCube) = n.children |> typeof |> eltype != DataCube

# band() = 
# filter_space() =
# filter_time() = 

convert(::Type{DataCube}, x) = DataCube(x)
convert(::Type{DataCube}, x::DataCube) = DataCube(x)
promote_rule(::Type{DataCube}, ::Type{T}) where {T<:Real} = DataCube

# TODO: Can we just put ProcessCall here instead?
abs(x::DataCube) = DataCube("absolute", [x])
sin(x::DataCube) = DataCube("sin", [x])
cos(x::DataCube) = DataCube("cos", [x])
sqrt(x::DataCube) = DataCube("sqrt", [x])

+(x::DataCube, y::DataCube) = DataCube("add", [x, y])
-(x::DataCube, y::DataCube) = DataCube("subtract", [x, y])
*(x::DataCube, y::DataCube) = DataCube("multiply", [x, y])
/(x::DataCube, y::DataCube) = DataCube("divide", [x, y])

+(x::DataCube, y) = +(promote(x, y)...)
-(x::DataCube, y) = -(promote(x, y)...)
*(x::DataCube, y) = *(promote(x, y)...)
/(x::DataCube, y) = /(promote(x, y)...)

+(x, y::DataCube) = +(promote(x, y)...)
-(x, y::DataCube) = -(promote(x, y)...)
*(x, y::DataCube) = *(promote(x, y)...)
/(x, y::DataCube) = /(promote(x, y)...)


function band(cube::ProcessCall, band_name::String)
    cube.process_id == "load_collection" || error("Cube must be a load_collection process")
    band_name in cube.arguments[:bands] || error("Band $band must be one of $(cube.arguments[:bands])")

    args = Dict(
        :data => cube,
        :dimension => "bands",
        :reducer => ProcessCall("array_element", Dict(
            :data => Dict(:from_parameter => "data"),
            :index => findfirst(x -> x == band_name, cube.arguments[:bands]) - 1
        )) |> ProcessGraph
    )
    c = ProcessCall("reduce_dimension", args)
    return c
end