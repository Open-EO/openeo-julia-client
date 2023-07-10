# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.



@doc raw"""data_type_schema
Either a single data type or a list of data types.

    DataTypeSchema(; value=nothing)
"""
mutable struct DataTypeSchema <: OpenAPI.OneOfAPIModel
    value::Any # Union{ ProcessJsonSchema, Vector{ProcessJsonSchema} }
    DataTypeSchema() = new()
    DataTypeSchema(value) = new(value)
end # type DataTypeSchema

function OpenAPI.property_type(::Type{ DataTypeSchema }, name::Symbol, json::Dict{String,Any})
    
    # no discriminator specified, can't determine the exact type
    return fieldtype(DataTypeSchema, name)
end
