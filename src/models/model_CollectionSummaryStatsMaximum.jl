# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.



@doc raw"""collection_summary_stats_maximum
The maximum value (inclusive).

    CollectionSummaryStatsMaximum(; value=nothing)
"""
mutable struct CollectionSummaryStatsMaximum <: OpenAPI.AnyOfAPIModel
    value::Any # Union{ Float64, String }
    CollectionSummaryStatsMaximum() = new()
    CollectionSummaryStatsMaximum(value) = new(value)
end # type CollectionSummaryStatsMaximum

function OpenAPI.property_type(::Type{ CollectionSummaryStatsMaximum }, name::Symbol, json::Dict{String,Any})
    
    # no discriminator specified, can't determine the exact type
    return fieldtype(CollectionSummaryStatsMaximum, name)
end
