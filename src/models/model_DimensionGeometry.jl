# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""dimension_geometry

    DimensionGeometry(;
        type=nothing,
        description=nothing,
        axes=nothing,
        bbox=nothing,
        values=nothing,
        geometry_types=nothing,
        reference_system=nothing,
    )

    - type::String : Type of the dimension.
    - description::String : Detailed description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation.
    - axes::Vector{DimensionAxisXyz} : Axes of the vector dimension as an ordered set of &#x60;x&#x60;, &#x60;y&#x60; and &#x60;z&#x60;. Defaults to &#x60;x&#x60; and &#x60;y&#x60;.
    - bbox::Vector{Float64} : Each bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth):  * West (lower left corner, coordinate axis 1) * South (lower left corner, coordinate axis 2) * Base (optional, minimum value, coordinate axis 3) * East (upper right corner, coordinate axis 1) * North (upper right corner, coordinate axis 2) * Height (optional, maximum value, coordinate axis 3)  The coordinate reference system of the values is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84).  For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude.  However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge).  If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box.
    - values::Vector{String} : Optionally, a representation of the vectors. This can be a list of WKT string or other free-form identifiers.
    - geometry_types::Vector{GeometryType} : A set of all geometry types included in this dimension. If not present, mixed geometry types must be assumed.
    - reference_system::CollectionDimensionSrs
"""
Base.@kwdef mutable struct DimensionGeometry <: OpenAPI.APIModel
    type::Union{Nothing, String} = nothing
    description::Union{Nothing, String} = nothing
    axes::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{DimensionAxisXyz} }
    bbox::Union{Nothing, Vector{Float64}} = nothing
    values::Union{Nothing, Vector{String}} = nothing
    geometry_types::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{GeometryType} }
    reference_system = nothing # spec type: Union{ Nothing, CollectionDimensionSrs }

    function DimensionGeometry(type, description, axes, bbox, values, geometry_types, reference_system, )
        OpenAPI.validate_property(DimensionGeometry, Symbol("type"), type)
        OpenAPI.validate_property(DimensionGeometry, Symbol("description"), description)
        OpenAPI.validate_property(DimensionGeometry, Symbol("axes"), axes)
        OpenAPI.validate_property(DimensionGeometry, Symbol("bbox"), bbox)
        OpenAPI.validate_property(DimensionGeometry, Symbol("values"), values)
        OpenAPI.validate_property(DimensionGeometry, Symbol("geometry_types"), geometry_types)
        OpenAPI.validate_property(DimensionGeometry, Symbol("reference_system"), reference_system)
        return new(type, description, axes, bbox, values, geometry_types, reference_system, )
    end
end # type DimensionGeometry

const _property_types_DimensionGeometry = Dict{Symbol,String}(Symbol("type")=>"String", Symbol("description")=>"String", Symbol("axes")=>"Vector{DimensionAxisXyz}", Symbol("bbox")=>"Vector{Float64}", Symbol("values")=>"Vector{String}", Symbol("geometry_types")=>"Vector{GeometryType}", Symbol("reference_system")=>"CollectionDimensionSrs", )
OpenAPI.property_type(::Type{ DimensionGeometry }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_DimensionGeometry[name]))}

function check_required(o::DimensionGeometry)
    o.type === nothing && (return false)
    o.bbox === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ DimensionGeometry }, name::Symbol, val)
    if name === Symbol("type")
        OpenAPI.validate_param(name, "DimensionGeometry", :enum, val, ["spatial", "temporal", "bands", "geometry", "other"])
    end
    if name === Symbol("description")
        OpenAPI.validate_param(name, "DimensionGeometry", :format, val, "commonmark")
    end
    if name === Symbol("axes")
        OpenAPI.validate_param(name, "DimensionGeometry", :uniqueItems, val, true)
    end
    if name === Symbol("geometry_types")
        OpenAPI.validate_param(name, "DimensionGeometry", :uniqueItems, val, true)
    end
end
