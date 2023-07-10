# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""Secondary_Web_Services

    SecondaryWebServices(;
        services=nothing,
        links=nothing,
    )

    - services::Vector{Service}
    - links::Vector{Link} : Links related to this list of resources, for example links for pagination or alternative formats such as a human-readable HTML version. The links array MUST NOT be paginated.  If pagination is implemented, the following &#x60;rel&#x60; (relation) types apply:  1. &#x60;next&#x60; (REQUIRED): A link to the next page, except on the last page.  2. &#x60;prev&#x60; (OPTIONAL): A link to the previous page, except on the first page.  3. &#x60;first&#x60; (OPTIONAL): A link to the first page, except on the first page.  4. &#x60;last&#x60; (OPTIONAL): A link to the last page, except on the last page.  For additional relation types see also the lists of [common relation types in openEO](#section/API-Principles/Web-Linking).
"""
Base.@kwdef mutable struct SecondaryWebServices <: OpenAPI.APIModel
    services::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{Service} }
    links::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{Link} }

    function SecondaryWebServices(services, links, )
        OpenAPI.validate_property(SecondaryWebServices, Symbol("services"), services)
        OpenAPI.validate_property(SecondaryWebServices, Symbol("links"), links)
        return new(services, links, )
    end
end # type SecondaryWebServices

const _property_types_SecondaryWebServices = Dict{Symbol,String}(Symbol("services")=>"Vector{Service}", Symbol("links")=>"Vector{Link}", )
OpenAPI.property_type(::Type{ SecondaryWebServices }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_SecondaryWebServices[name]))}

function check_required(o::SecondaryWebServices)
    o.services === nothing && (return false)
    o.links === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ SecondaryWebServices }, name::Symbol, val)
end