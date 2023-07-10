# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""usage_metric

    UsageMetric(;
        value=nothing,
        unit=nothing,
    )

    - value::Float64
    - unit::String
"""
Base.@kwdef mutable struct UsageMetric <: OpenAPI.APIModel
    value::Union{Nothing, Float64} = nothing
    unit::Union{Nothing, String} = nothing

    function UsageMetric(value, unit, )
        OpenAPI.validate_property(UsageMetric, Symbol("value"), value)
        OpenAPI.validate_property(UsageMetric, Symbol("unit"), unit)
        return new(value, unit, )
    end
end # type UsageMetric

const _property_types_UsageMetric = Dict{Symbol,String}(Symbol("value")=>"Float64", Symbol("unit")=>"String", )
OpenAPI.property_type(::Type{ UsageMetric }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_UsageMetric[name]))}

function check_required(o::UsageMetric)
    o.value === nothing && (return false)
    o.unit === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ UsageMetric }, name::Symbol, val)
    if name === Symbol("value")
        OpenAPI.validate_param(name, "UsageMetric", :minimum, val, 0, false)
    end
end