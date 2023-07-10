# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""resource_parameter
Describes a parameter for various resources (e.g. file formats, service types).  The parameters are specified according to the [JSON Schema draft-07](http://json-schema.org/) specification. See the chapter [&#39;Schemas&#39; in &#39;Defining Processes&#39;](#section/Processes/Defining-Processes) for more information.  The following more complex JSON Schema keywords SHOULD NOT be used: &#x60;if&#x60;, &#x60;then&#x60;, &#x60;else&#x60;, &#x60;readOnly&#x60;, &#x60;writeOnly&#x60;, &#x60;dependencies&#x60;, &#x60;minProperties&#x60;, &#x60;maxProperties&#x60;, &#x60;patternProperties&#x60;.  JSON Schemas SHOULD always be dereferenced (i.e. all &#x60;$refs&#x60; should be resolved). This allows clients to consume the schemas much better. Clients are not expected to support dereferencing &#x60;$refs&#x60;.  Note: The specified schema is only a common subset of JSON Schema. Additional keywords MAY be used.

    ResourceParameter(;
        description=nothing,
        required=false,
        experimental=false,
        default=nothing,
        var"$schema"="http://json-schema.org/draft-07/schema#",
        var"$id"=nothing,
        type=nothing,
        pattern=nothing,
        enum=nothing,
        minimum=nothing,
        maximum=nothing,
        minItems=0,
        maxItems=nothing,
        items=nothing,
        subtype=nothing,
        parameters=nothing,
        returns=nothing,
        dimensions=nothing,
    )

    - description::String : A brief description of the parameter according to [JSON Schema draft-07](https://json-schema.org/draft-07/json-schema-validation.html#rfc.section.10.1).
    - required::Bool : Determines whether this parameter is mandatory.
    - experimental::Bool : Declares that the specified entity is experimental, which means that it is likely to change or may produce unpredictable behaviour. Users should refrain from using it in production, but still feel encouraged to try it out and give feedback.
    - default::Any : The default value represents what would be assumed by the consumer of the input as the value of the parameter if none is provided. The value MUST conform to the defined type for the parameter defined at the same level. For example, if type is string, then default can be \&quot;foo\&quot; but cannot be 1. See [JSON Schema draft-07](https://json-schema.org/draft-07/json-schema-validation.html#rfc.section.10.2).
    - var"$schema"::String : The JSON Schema version. If not given in the context of openEO, defaults to &#x60;draft-07&#x60;.  You may need to add the default value for &#x60;$schema&#x60; property explicitly to the JSON Schema object before passing it to a JSON Schema validator.
    - var"$id"::String : ID of your JSON Schema.
    - type::JsonSchemaType1
    - pattern::String : The regular expression a string value must match against.
    - enum::Vector{Any} : An exclusive list of allowed values.
    - minimum::Float64 : The minimum value (inclusive) allowed for a numerical value.
    - maximum::Float64 : The maximum value (inclusive) allowed for a numerical value.
    - minItems::Float64 : The minimum number of items required in an array.
    - maxItems::Float64 : The maximum number of items required in an array.
    - items::JsonSchemaItems
    - subtype::String
    - parameters::Vector{Parameter} : A list of parameters passed to the child process graph.  The order in the array corresponds to the parameter order to be used in clients that don&#39;t support named parameters.
    - returns::ProcessGraphReturnValue
    - dimensions::Vector{OneOf} : Allows to specify requirements the data cube has to fulfill. Right now, it only allows to specify the dimension types and  adds for specific dimension types: * axes for &#x60;spatial&#x60; dimensions in raster datacubes * geometry types for &#x60;geometry&#x60; dimensions in vector datacubes
"""
Base.@kwdef mutable struct ResourceParameter <: OpenAPI.APIModel
    description::Union{Nothing, String} = nothing
    required::Union{Nothing, Bool} = false
    experimental::Union{Nothing, Bool} = false
    default::Union{Nothing, Any} = nothing
    var"$schema"::Union{Nothing, String} = "http://json-schema.org/draft-07/schema#"
    var"$id"::Union{Nothing, String} = nothing
    type = nothing # spec type: Union{ Nothing, JsonSchemaType1 }
    pattern::Union{Nothing, String} = nothing
    enum::Union{Nothing, Vector{Any}} = nothing
    minimum::Union{Nothing, Float64} = nothing
    maximum::Union{Nothing, Float64} = nothing
    minItems::Union{Nothing, Float64} = 0
    maxItems::Union{Nothing, Float64} = nothing
    items = nothing # spec type: Union{ Nothing, JsonSchemaItems }
    subtype::Union{Nothing, String} = nothing
    parameters::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{Parameter} }
    returns = nothing # spec type: Union{ Nothing, ProcessGraphReturnValue }
    dimensions::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{OneOf} }

    function ResourceParameter(description, required, experimental, default, var"$schema", var"$id", type, pattern, enum, minimum, maximum, minItems, maxItems, items, subtype, parameters, returns, dimensions, )
        OpenAPI.validate_property(ResourceParameter, Symbol("description"), description)
        OpenAPI.validate_property(ResourceParameter, Symbol("required"), required)
        OpenAPI.validate_property(ResourceParameter, Symbol("experimental"), experimental)
        OpenAPI.validate_property(ResourceParameter, Symbol("default"), default)
        OpenAPI.validate_property(ResourceParameter, Symbol("\$schema"), var"$schema")
        OpenAPI.validate_property(ResourceParameter, Symbol("\$id"), var"$id")
        OpenAPI.validate_property(ResourceParameter, Symbol("type"), type)
        OpenAPI.validate_property(ResourceParameter, Symbol("pattern"), pattern)
        OpenAPI.validate_property(ResourceParameter, Symbol("enum"), enum)
        OpenAPI.validate_property(ResourceParameter, Symbol("minimum"), minimum)
        OpenAPI.validate_property(ResourceParameter, Symbol("maximum"), maximum)
        OpenAPI.validate_property(ResourceParameter, Symbol("minItems"), minItems)
        OpenAPI.validate_property(ResourceParameter, Symbol("maxItems"), maxItems)
        OpenAPI.validate_property(ResourceParameter, Symbol("items"), items)
        OpenAPI.validate_property(ResourceParameter, Symbol("subtype"), subtype)
        OpenAPI.validate_property(ResourceParameter, Symbol("parameters"), parameters)
        OpenAPI.validate_property(ResourceParameter, Symbol("returns"), returns)
        OpenAPI.validate_property(ResourceParameter, Symbol("dimensions"), dimensions)
        return new(description, required, experimental, default, var"$schema", var"$id", type, pattern, enum, minimum, maximum, minItems, maxItems, items, subtype, parameters, returns, dimensions, )
    end
end # type ResourceParameter

const _property_types_ResourceParameter = Dict{Symbol,String}(Symbol("description")=>"String", Symbol("required")=>"Bool", Symbol("experimental")=>"Bool", Symbol("default")=>"Any", Symbol("\$schema")=>"String", Symbol("\$id")=>"String", Symbol("type")=>"JsonSchemaType1", Symbol("pattern")=>"String", Symbol("enum")=>"Vector{Any}", Symbol("minimum")=>"Float64", Symbol("maximum")=>"Float64", Symbol("minItems")=>"Float64", Symbol("maxItems")=>"Float64", Symbol("items")=>"JsonSchemaItems", Symbol("subtype")=>"String", Symbol("parameters")=>"Vector{Parameter}", Symbol("returns")=>"ProcessGraphReturnValue", Symbol("dimensions")=>"Vector{OneOf}", )
OpenAPI.property_type(::Type{ ResourceParameter }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_ResourceParameter[name]))}

function check_required(o::ResourceParameter)
    o.description === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ ResourceParameter }, name::Symbol, val)
    if name === Symbol("\$schema")
        OpenAPI.validate_param(name, "ResourceParameter", :format, val, "uri")
    end
    if name === Symbol("\$id")
        OpenAPI.validate_param(name, "ResourceParameter", :format, val, "uri")
    end
    if name === Symbol("pattern")
        OpenAPI.validate_param(name, "ResourceParameter", :format, val, "regex")
    end
    if name === Symbol("minItems")
        OpenAPI.validate_param(name, "ResourceParameter", :minimum, val, 0, false)
    end
    if name === Symbol("maxItems")
        OpenAPI.validate_param(name, "ResourceParameter", :minimum, val, 0, false)
    end
    if name === Symbol("subtype")
        OpenAPI.validate_param(name, "ResourceParameter", :enum, val, ["datacube"])
    end
end
