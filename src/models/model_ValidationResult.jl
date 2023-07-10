# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""Validation_Result

    ValidationResult(;
        errors=nothing,
    )

    - errors::Vector{Error} : A list of validation errors.
"""
Base.@kwdef mutable struct ValidationResult <: OpenAPI.APIModel
    errors::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{Error} }

    function ValidationResult(errors, )
        OpenAPI.validate_property(ValidationResult, Symbol("errors"), errors)
        return new(errors, )
    end
end # type ValidationResult

const _property_types_ValidationResult = Dict{Symbol,String}(Symbol("errors")=>"Vector{Error}", )
OpenAPI.property_type(::Type{ ValidationResult }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_ValidationResult[name]))}

function check_required(o::ValidationResult)
    o.errors === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ ValidationResult }, name::Symbol, val)
end
