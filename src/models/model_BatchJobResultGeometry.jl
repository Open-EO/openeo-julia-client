# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""batch_job_result_geometry
Defines the full footprint of the asset represented by this item as GeoJSON Geometry.  Results without a known location can set this value to &#x60;null&#x60;.

    BatchJobResultGeometry(;
        type=nothing,
    )

    - type::GeometryType
"""
Base.@kwdef mutable struct BatchJobResultGeometry <: OpenAPI.APIModel
    type = nothing # spec type: Union{ Nothing, GeometryType }

    function BatchJobResultGeometry(type, )
        OpenAPI.validate_property(BatchJobResultGeometry, Symbol("type"), type)
        return new(type, )
    end
end # type BatchJobResultGeometry

const _property_types_BatchJobResultGeometry = Dict{Symbol,String}(Symbol("type")=>"GeometryType", )
OpenAPI.property_type(::Type{ BatchJobResultGeometry }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_BatchJobResultGeometry[name]))}

function check_required(o::BatchJobResultGeometry)
    o.type === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ BatchJobResultGeometry }, name::Symbol, val)
end
