# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""API_Instance

    APIInstance(;
        url=nothing,
        production=false,
        api_version=nothing,
    )

    - url::String : *Absolute* URLs to the service.
    - production::Bool : Specifies whether the implementation is ready to be used in production use (&#x60;true&#x60;) or not (&#x60;false&#x60;). Clients SHOULD only connect to non-production implementations if the user explicitly confirmed to use a non-production implementation. This flag is part of &#x60;GET /.well-known/openeo&#x60; and &#x60;GET /&#x60;. It MUST be used consistently in both endpoints.
    - api_version::String : Version number of the openEO specification this back-end implements.
"""
Base.@kwdef mutable struct APIInstance <: OpenAPI.APIModel
    url::Union{Nothing, String} = nothing
    production::Union{Nothing, Bool} = false
    api_version::Union{Nothing, String} = nothing

    function APIInstance(url, production, api_version, )
        OpenAPI.validate_property(APIInstance, Symbol("url"), url)
        OpenAPI.validate_property(APIInstance, Symbol("production"), production)
        OpenAPI.validate_property(APIInstance, Symbol("api_version"), api_version)
        return new(url, production, api_version, )
    end
end # type APIInstance

const _property_types_APIInstance = Dict{Symbol,String}(Symbol("url")=>"String", Symbol("production")=>"Bool", Symbol("api_version")=>"String", )
OpenAPI.property_type(::Type{ APIInstance }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_APIInstance[name]))}

function check_required(o::APIInstance)
    o.url === nothing && (return false)
    o.api_version === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ APIInstance }, name::Symbol, val)
    if name === Symbol("url")
        OpenAPI.validate_param(name, "APIInstance", :format, val, "uri")
    end
end