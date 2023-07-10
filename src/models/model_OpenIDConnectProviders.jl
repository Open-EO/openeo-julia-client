# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""OpenID_Connect_Providers

    OpenIDConnectProviders(;
        providers=nothing,
    )

    - providers::Vector{OpenIDConnectProvider} : The first provider in this list is the default provider for authentication. Clients can either pre-select or directly use the default provider for authentication if the user doesn&#39;t specify a specific value.
"""
Base.@kwdef mutable struct OpenIDConnectProviders <: OpenAPI.APIModel
    providers::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{OpenIDConnectProvider} }

    function OpenIDConnectProviders(providers, )
        OpenAPI.validate_property(OpenIDConnectProviders, Symbol("providers"), providers)
        return new(providers, )
    end
end # type OpenIDConnectProviders

const _property_types_OpenIDConnectProviders = Dict{Symbol,String}(Symbol("providers")=>"Vector{OpenIDConnectProvider}", )
OpenAPI.property_type(::Type{ OpenIDConnectProviders }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_OpenIDConnectProviders[name]))}

function check_required(o::OpenIDConnectProviders)
    o.providers === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ OpenIDConnectProviders }, name::Symbol, val)
    if name === Symbol("providers")
        OpenAPI.validate_param(name, "OpenIDConnectProviders", :minItems, val, 1)
    end
end
