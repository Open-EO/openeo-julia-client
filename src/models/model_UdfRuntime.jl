# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""udf_runtime

    UdfRuntime(;
        title=nothing,
        description=nothing,
        type=nothing,
        default=nothing,
        deprecated=false,
        experimental=false,
        links=nothing,
    )

    - title::String : A human-readable short title to be displayed to users **in addition** to the names specified in the keys. This property is only for better user experience so that users can understand the names better. Example titles could be &#x60;GeoTiff&#x60; for the key &#x60;GTiff&#x60; (for file formats) or &#x60;OGC Web Map Service&#x60; for the key &#x60;WMS&#x60; (for service types). The title MUST NOT be used in communication (e.g. in process graphs), although clients MAY translate the titles into the corresponding names.
    - description::String : Detailed description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation.
    - type::String : The type of the UDF runtime.  Predefined types are: * &#x60;language&#x60; for Programming Languages and * &#x60;docker&#x60; for Docker Containers.  The types can potentially be extended by back-ends.
    - default::String
    - deprecated::Bool : Declares that the specified entity is deprecated with the potential to be removed in any of the next versions. It should be transitioned out of usage as soon as possible and users should refrain from using it in new implementations.
    - experimental::Bool : Declares that the specified entity is experimental, which means that it is likely to change or may produce unpredictable behaviour. Users should refrain from using it in production, but still feel encouraged to try it out and give feedback.
    - links::Vector{Link} : Links related to this runtime, e.g. external documentation.  It is highly RECOMMENDED to provide at least links with the following &#x60;rel&#x60; (relation) types:  1. &#x60;about&#x60;: A resource that further explains the runtime, e.g. a user guide or the documentation. It is RECOMMENDED to  add descriptive titles for a better user experience.  For additional relation types see also the lists of [common relation types in openEO](#section/API-Principles/Web-Linking).
"""
Base.@kwdef mutable struct UdfRuntime <: OpenAPI.APIModel
    title::Union{Nothing, String} = nothing
    description::Union{Nothing, String} = nothing
    type::Union{Nothing, String} = nothing
    default::Union{Nothing, String} = nothing
    deprecated::Union{Nothing, Bool} = false
    experimental::Union{Nothing, Bool} = false
    links::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{Link} }

    function UdfRuntime(title, description, type, default, deprecated, experimental, links, )
        OpenAPI.validate_property(UdfRuntime, Symbol("title"), title)
        OpenAPI.validate_property(UdfRuntime, Symbol("description"), description)
        OpenAPI.validate_property(UdfRuntime, Symbol("type"), type)
        OpenAPI.validate_property(UdfRuntime, Symbol("default"), default)
        OpenAPI.validate_property(UdfRuntime, Symbol("deprecated"), deprecated)
        OpenAPI.validate_property(UdfRuntime, Symbol("experimental"), experimental)
        OpenAPI.validate_property(UdfRuntime, Symbol("links"), links)
        return new(title, description, type, default, deprecated, experimental, links, )
    end
end # type UdfRuntime

const _property_types_UdfRuntime = Dict{Symbol,String}(Symbol("title")=>"String", Symbol("description")=>"String", Symbol("type")=>"String", Symbol("default")=>"String", Symbol("deprecated")=>"Bool", Symbol("experimental")=>"Bool", Symbol("links")=>"Vector{Link}", )
OpenAPI.property_type(::Type{ UdfRuntime }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_UdfRuntime[name]))}

function check_required(o::UdfRuntime)
    o.type === nothing && (return false)
    o.default === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ UdfRuntime }, name::Symbol, val)
    if name === Symbol("description")
        OpenAPI.validate_param(name, "UdfRuntime", :format, val, "commonmark")
    end
end
