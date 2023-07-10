# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""GeoJsonMultiPoint

    GeoJsonMultiPoint(;
        type=nothing,
        coordinates=nothing,
    )

    - type::GeometryType
    - coordinates::Vector{Vector}
"""
Base.@kwdef mutable struct GeoJsonMultiPoint <: OpenAPI.APIModel
    type = nothing # spec type: Union{ Nothing, GeometryType }
    coordinates::Union{Nothing, Vector{Vector}} = nothing

    function GeoJsonMultiPoint(type, coordinates, )
        OpenAPI.validate_property(GeoJsonMultiPoint, Symbol("type"), type)
        OpenAPI.validate_property(GeoJsonMultiPoint, Symbol("coordinates"), coordinates)
        return new(type, coordinates, )
    end
end # type GeoJsonMultiPoint

const _property_types_GeoJsonMultiPoint = Dict{Symbol,String}(Symbol("type")=>"GeometryType", Symbol("coordinates")=>"Vector{Vector}", )
OpenAPI.property_type(::Type{ GeoJsonMultiPoint }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_GeoJsonMultiPoint[name]))}

function check_required(o::GeoJsonMultiPoint)
    o.type === nothing && (return false)
    o.coordinates === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ GeoJsonMultiPoint }, name::Symbol, val)
end