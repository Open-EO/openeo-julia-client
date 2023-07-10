# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.



@doc raw"""json_schema_items
Specifies schemas for the items in an array.

    JsonSchemaItems(; value=nothing)
"""
mutable struct JsonSchemaItems <: OpenAPI.AnyOfAPIModel
    value::Any # Union{ JsonSchema, Vector{JsonSchema} }
    JsonSchemaItems() = new()
    JsonSchemaItems(value) = new(value)
end # type JsonSchemaItems

function OpenAPI.property_type(::Type{ JsonSchemaItems }, name::Symbol, json::Dict{String,Any})
    
    # no discriminator specified, can't determine the exact type
    return fieldtype(JsonSchemaItems, name)
end
