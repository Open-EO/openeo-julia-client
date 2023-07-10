# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""Collection_Temporal_Extent
The *potential* temporal extents of the features in the collection.

    CollectionTemporalExtent(;
        interval=nothing,
    )

    - interval::Vector{Vector{ZonedDateTime}} : One or more time intervals that describe the temporal extent of the dataset.  The first time interval describes the overall temporal extent of the data. All subsequent time intervals describe more precise time intervals, e.g. to identify clusters of data. Clients only interested in the overall extent will only need to access the first item in each array.
"""
Base.@kwdef mutable struct CollectionTemporalExtent <: OpenAPI.APIModel
    interval::Union{Nothing, Vector{Vector{ZonedDateTime}}} = nothing

    function CollectionTemporalExtent(interval, )
        OpenAPI.validate_property(CollectionTemporalExtent, Symbol("interval"), interval)
        return new(interval, )
    end
end # type CollectionTemporalExtent

const _property_types_CollectionTemporalExtent = Dict{Symbol,String}(Symbol("interval")=>"Vector{Vector{ZonedDateTime}}", )
OpenAPI.property_type(::Type{ CollectionTemporalExtent }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_CollectionTemporalExtent[name]))}

function check_required(o::CollectionTemporalExtent)
    true
end

function OpenAPI.validate_property(::Type{ CollectionTemporalExtent }, name::Symbol, val)
    if name === Symbol("interval")
        OpenAPI.validate_param(name, "CollectionTemporalExtent", :minItems, val, 1)
    end
end