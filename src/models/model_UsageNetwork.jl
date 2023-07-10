# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""usage_network
Specifies the network transfer usage (incoming and outgoing), usually in a unit such as &#x60;b&#x60; (bytes), &#x60;kb&#x60; (kilobytes), &#x60;mb&#x60; (megabytes) or &#x60;gb&#x60; (gigabytes).

    UsageNetwork(;
        value=nothing,
        unit=nothing,
    )

    - value::Float64
    - unit::String
"""
Base.@kwdef mutable struct UsageNetwork <: OpenAPI.APIModel
    value::Union{Nothing, Float64} = nothing
    unit::Union{Nothing, String} = nothing

    function UsageNetwork(value, unit, )
        OpenAPI.validate_property(UsageNetwork, Symbol("value"), value)
        OpenAPI.validate_property(UsageNetwork, Symbol("unit"), unit)
        return new(value, unit, )
    end
end # type UsageNetwork

const _property_types_UsageNetwork = Dict{Symbol,String}(Symbol("value")=>"Float64", Symbol("unit")=>"String", )
OpenAPI.property_type(::Type{ UsageNetwork }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_UsageNetwork[name]))}

function check_required(o::UsageNetwork)
    o.value === nothing && (return false)
    o.unit === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ UsageNetwork }, name::Symbol, val)
    if name === Symbol("value")
        OpenAPI.validate_param(name, "UsageNetwork", :minimum, val, 0, false)
    end
end
