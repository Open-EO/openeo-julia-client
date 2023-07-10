# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""usage_disk
Specifies the amount of input (read) and output (write) operations on the storage such as disks, usually in a unit such as &#x60;b&#x60; (bytes), &#x60;kb&#x60; (kilobytes), &#x60;mb&#x60; (megabytes) or &#x60;gb&#x60; (gigabytes).

    UsageDisk(;
        value=nothing,
        unit=nothing,
    )

    - value::Float64
    - unit::String
"""
Base.@kwdef mutable struct UsageDisk <: OpenAPI.APIModel
    value::Union{Nothing, Float64} = nothing
    unit::Union{Nothing, String} = nothing

    function UsageDisk(value, unit, )
        OpenAPI.validate_property(UsageDisk, Symbol("value"), value)
        OpenAPI.validate_property(UsageDisk, Symbol("unit"), unit)
        return new(value, unit, )
    end
end # type UsageDisk

const _property_types_UsageDisk = Dict{Symbol,String}(Symbol("value")=>"Float64", Symbol("unit")=>"String", )
OpenAPI.property_type(::Type{ UsageDisk }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_UsageDisk[name]))}

function check_required(o::UsageDisk)
    o.value === nothing && (return false)
    o.unit === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ UsageDisk }, name::Symbol, val)
    if name === Symbol("value")
        OpenAPI.validate_param(name, "UsageDisk", :minimum, val, 0, false)
    end
end