# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.



@doc raw"""stac_extensions_inner

    StacExtensionsInner(; value=nothing)
"""
mutable struct StacExtensionsInner <: OpenAPI.AnyOfAPIModel
    value::Any # Union{ String }
    StacExtensionsInner() = new()
    StacExtensionsInner(value) = new(value)
end # type StacExtensionsInner

function OpenAPI.property_type(::Type{ StacExtensionsInner }, name::Symbol, json::Dict{String,Any})
    
    # no discriminator specified, can't determine the exact type
    return fieldtype(StacExtensionsInner, name)
end
