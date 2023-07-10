# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.



@doc raw"""process_argument_value
Arguments for a process. See the API documentation for more information.

    ProcessArgumentValue(; value=nothing)
"""
mutable struct ProcessArgumentValue <: OpenAPI.AnyOfAPIModel
    value::Any # Union{ Bool, Float64, ObjectRestricted, ParameterReference, ProcessGraphWithMetadata, ResultReference, String, Vector{ProcessArgumentValue} }
    ProcessArgumentValue() = new()
    ProcessArgumentValue(value) = new(value)
end # type ProcessArgumentValue

function OpenAPI.property_type(::Type{ ProcessArgumentValue }, name::Symbol, json::Dict{String,Any})
    
    # no discriminator specified, can't determine the exact type
    return fieldtype(ProcessArgumentValue, name)
end