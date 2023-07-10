# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""Process_Graph_Return_Value
Description of the data that is returned by the child process graph.

    ProcessGraphReturnValue(;
        description=nothing,
        schema=nothing,
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

    - description::String : Detailed description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. In addition to the CommonMark syntax, clients can convert process IDs that are formatted as in the following example into links instead of code blocks: &#x60;&#x60;&#x60; &#x60;&#x60;process_id()&#x60;&#x60; &#x60;&#x60;&#x60;
    - schema::DataTypeSchema
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
Base.@kwdef mutable struct ProcessGraphReturnValue <: OpenAPI.APIModel
    description::Union{Nothing, String} = nothing
    schema = nothing # spec type: Union{ Nothing, DataTypeSchema }
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

    function ProcessGraphReturnValue(description, schema, var"$schema", var"$id", type, pattern, enum, minimum, maximum, minItems, maxItems, items, subtype, parameters, returns, dimensions, )
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("description"), description)
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("schema"), schema)
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("\$schema"), var"$schema")
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("\$id"), var"$id")
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("type"), type)
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("pattern"), pattern)
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("enum"), enum)
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("minimum"), minimum)
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("maximum"), maximum)
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("minItems"), minItems)
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("maxItems"), maxItems)
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("items"), items)
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("subtype"), subtype)
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("parameters"), parameters)
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("returns"), returns)
        OpenAPI.validate_property(ProcessGraphReturnValue, Symbol("dimensions"), dimensions)
        return new(description, schema, var"$schema", var"$id", type, pattern, enum, minimum, maximum, minItems, maxItems, items, subtype, parameters, returns, dimensions, )
    end
end # type ProcessGraphReturnValue

const _property_types_ProcessGraphReturnValue = Dict{Symbol,String}(Symbol("description")=>"String", Symbol("schema")=>"DataTypeSchema", Symbol("\$schema")=>"String", Symbol("\$id")=>"String", Symbol("type")=>"JsonSchemaType1", Symbol("pattern")=>"String", Symbol("enum")=>"Vector{Any}", Symbol("minimum")=>"Float64", Symbol("maximum")=>"Float64", Symbol("minItems")=>"Float64", Symbol("maxItems")=>"Float64", Symbol("items")=>"JsonSchemaItems", Symbol("subtype")=>"String", Symbol("parameters")=>"Vector{Parameter}", Symbol("returns")=>"ProcessGraphReturnValue", Symbol("dimensions")=>"Vector{OneOf}", )
OpenAPI.property_type(::Type{ ProcessGraphReturnValue }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_ProcessGraphReturnValue[name]))}

function check_required(o::ProcessGraphReturnValue)
    o.schema === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ ProcessGraphReturnValue }, name::Symbol, val)
    if name === Symbol("description")
        OpenAPI.validate_param(name, "ProcessGraphReturnValue", :format, val, "commonmark")
    end
    if name === Symbol("\$schema")
        OpenAPI.validate_param(name, "ProcessGraphReturnValue", :format, val, "uri")
    end
    if name === Symbol("\$id")
        OpenAPI.validate_param(name, "ProcessGraphReturnValue", :format, val, "uri")
    end
    if name === Symbol("pattern")
        OpenAPI.validate_param(name, "ProcessGraphReturnValue", :format, val, "regex")
    end
    if name === Symbol("minItems")
        OpenAPI.validate_param(name, "ProcessGraphReturnValue", :minimum, val, 0, false)
    end
    if name === Symbol("maxItems")
        OpenAPI.validate_param(name, "ProcessGraphReturnValue", :minimum, val, 0, false)
    end
    if name === Symbol("subtype")
        OpenAPI.validate_param(name, "ProcessGraphReturnValue", :enum, val, ["datacube"])
    end
end
