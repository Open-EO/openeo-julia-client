# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""GeoJsonPolygon

    GeoJsonPolygon(;
        type=nothing,
        coordinates=nothing,
    )

    - type::GeometryType
    - coordinates::Vector{Vector{Vector}}
"""
Base.@kwdef mutable struct GeoJsonPolygon <: OpenAPI.APIModel
    type = nothing # spec type: Union{ Nothing, GeometryType }
    coordinates::Union{Nothing, Vector{Vector{Vector}}} = nothing

    function GeoJsonPolygon(type, coordinates, )
        OpenAPI.validate_property(GeoJsonPolygon, Symbol("type"), type)
        OpenAPI.validate_property(GeoJsonPolygon, Symbol("coordinates"), coordinates)
        return new(type, coordinates, )
    end
end # type GeoJsonPolygon

const _property_types_GeoJsonPolygon = Dict{Symbol,String}(Symbol("type")=>"GeometryType", Symbol("coordinates")=>"Vector{Vector{Vector}}", )
OpenAPI.property_type(::Type{ GeoJsonPolygon }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_GeoJsonPolygon[name]))}

function check_required(o::GeoJsonPolygon)
    o.type === nothing && (return false)
    o.coordinates === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ GeoJsonPolygon }, name::Symbol, val)
end