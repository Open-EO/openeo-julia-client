# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""Item_Properties
MAY contain additional properties other than the required property &#x60;datetime&#x60;, e.g. custom properties or properties from the STAC specification or STAC extensions.

    ItemProperties(;
        datetime=nothing,
        start_datetime=nothing,
        end_datetime=nothing,
        title=nothing,
        description=nothing,
        license=nothing,
        providers=nothing,
        created=nothing,
        updated=nothing,
        expires=nothing,
        var"openeo:status"=nothing,
    )

    - datetime::ZonedDateTime : The searchable date/time of the data, in UTC. Formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time.  If this field is set to &#x60;null&#x60; (usually for larger time ranges), it is STRONGLY RECOMMENDED to specify both &#x60;start_datetime&#x60; and &#x60;end_datetime&#x60; for STAC compliance.
    - start_datetime::ZonedDateTime : For time series: The first or start date and time for the data, in UTC. Formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time.
    - end_datetime::ZonedDateTime : For time series: The last or end date and time for the data, in UTC. Formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time.
    - title::String : A short description to easily distinguish entities.
    - description::String : Detailed multi-line description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation.
    - license::String : License(s) of the data as a SPDX [License identifier](https://spdx.org/licenses/). Alternatively, use &#x60;proprietary&#x60; if the license is not on the SPDX license list or &#x60;various&#x60; if multiple licenses apply. In these two cases links to the license texts SHOULD be added, see the &#x60;license&#x60; link relation type.  Non-SPDX licenses SHOULD add a link to the license text with the &#x60;license&#x60; relation in the links section. The license text MUST NOT be provided as a value of this field. If there is no public license URL available, it is RECOMMENDED to host the license text and link to it.
    - providers::Vector{Provider} : A list of providers, which MAY include all organizations capturing or processing the data or the hosting provider. Providers SHOULD be listed in chronological order with the most recent provider being the last element of the list.
    - created::ZonedDateTime : Date and time of creation, formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time.
    - updated::ZonedDateTime : Date and time of the last status change, formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time.
    - expires::ZonedDateTime : Time until which the assets are accessible, in UTC. Formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time.
    - var"openeo:status"::ResultStatus
"""
Base.@kwdef mutable struct ItemProperties <: OpenAPI.APIModel
    datetime::Union{Nothing, ZonedDateTime} = nothing
    start_datetime::Union{Nothing, ZonedDateTime} = nothing
    end_datetime::Union{Nothing, ZonedDateTime} = nothing
    title::Union{Nothing, String} = nothing
    description::Union{Nothing, String} = nothing
    license::Union{Nothing, String} = nothing
    providers::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{Provider} }
    created::Union{Nothing, ZonedDateTime} = nothing
    updated::Union{Nothing, ZonedDateTime} = nothing
    expires::Union{Nothing, ZonedDateTime} = nothing
    var"openeo:status" = nothing # spec type: Union{ Nothing, ResultStatus }

    function ItemProperties(datetime, start_datetime, end_datetime, title, description, license, providers, created, updated, expires, var"openeo:status", )
        OpenAPI.validate_property(ItemProperties, Symbol("datetime"), datetime)
        OpenAPI.validate_property(ItemProperties, Symbol("start_datetime"), start_datetime)
        OpenAPI.validate_property(ItemProperties, Symbol("end_datetime"), end_datetime)
        OpenAPI.validate_property(ItemProperties, Symbol("title"), title)
        OpenAPI.validate_property(ItemProperties, Symbol("description"), description)
        OpenAPI.validate_property(ItemProperties, Symbol("license"), license)
        OpenAPI.validate_property(ItemProperties, Symbol("providers"), providers)
        OpenAPI.validate_property(ItemProperties, Symbol("created"), created)
        OpenAPI.validate_property(ItemProperties, Symbol("updated"), updated)
        OpenAPI.validate_property(ItemProperties, Symbol("expires"), expires)
        OpenAPI.validate_property(ItemProperties, Symbol("openeo:status"), var"openeo:status")
        return new(datetime, start_datetime, end_datetime, title, description, license, providers, created, updated, expires, var"openeo:status", )
    end
end # type ItemProperties

const _property_types_ItemProperties = Dict{Symbol,String}(Symbol("datetime")=>"ZonedDateTime", Symbol("start_datetime")=>"ZonedDateTime", Symbol("end_datetime")=>"ZonedDateTime", Symbol("title")=>"String", Symbol("description")=>"String", Symbol("license")=>"String", Symbol("providers")=>"Vector{Provider}", Symbol("created")=>"ZonedDateTime", Symbol("updated")=>"ZonedDateTime", Symbol("expires")=>"ZonedDateTime", Symbol("openeo:status")=>"ResultStatus", )
OpenAPI.property_type(::Type{ ItemProperties }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_ItemProperties[name]))}

function check_required(o::ItemProperties)
    o.datetime === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ ItemProperties }, name::Symbol, val)
    if name === Symbol("datetime")
        OpenAPI.validate_param(name, "ItemProperties", :format, val, "date-time")
    end
    if name === Symbol("start_datetime")
        OpenAPI.validate_param(name, "ItemProperties", :format, val, "date-time")
    end
    if name === Symbol("end_datetime")
        OpenAPI.validate_param(name, "ItemProperties", :format, val, "date-time")
    end
    if name === Symbol("description")
        OpenAPI.validate_param(name, "ItemProperties", :format, val, "commonmark")
    end
    if name === Symbol("created")
        OpenAPI.validate_param(name, "ItemProperties", :format, val, "date-time")
    end
    if name === Symbol("updated")
        OpenAPI.validate_param(name, "ItemProperties", :format, val, "date-time")
    end
    if name === Symbol("expires")
        OpenAPI.validate_param(name, "ItemProperties", :format, val, "date-time")
    end
end
