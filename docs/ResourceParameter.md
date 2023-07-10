# ResourceParameter


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**description** | **String** | A brief description of the parameter according to [JSON Schema draft-07](https://json-schema.org/draft-07/json-schema-validation.html#rfc.section.10.1). | [default to nothing]
**required** | **Bool** | Determines whether this parameter is mandatory. | [optional] [default to false]
**experimental** | **Bool** | Declares that the specified entity is experimental, which means that it is likely to change or may produce unpredictable behaviour. Users should refrain from using it in production, but still feel encouraged to try it out and give feedback. | [optional] [default to false]
**default** | **Any** | The default value represents what would be assumed by the consumer of the input as the value of the parameter if none is provided. The value MUST conform to the defined type for the parameter defined at the same level. For example, if type is string, then default can be \&quot;foo\&quot; but cannot be 1. See [JSON Schema draft-07](https://json-schema.org/draft-07/json-schema-validation.html#rfc.section.10.2). | [optional] [default to nothing]
**var&quot;$schema&quot;** | **String** | The JSON Schema version. If not given in the context of openEO, defaults to &#x60;draft-07&#x60;.  You may need to add the default value for &#x60;$schema&#x60; property explicitly to the JSON Schema object before passing it to a JSON Schema validator. | [optional] [default to "http://json-schema.org/draft-07/schema#"]
**var&quot;$id&quot;** | **String** | ID of your JSON Schema. | [optional] [default to nothing]
**type** | [***JsonSchemaType1**](JsonSchemaType1.md) |  | [optional] [default to nothing]
**pattern** | **String** | The regular expression a string value must match against. | [optional] [default to nothing]
**enum** | **Vector{Any}** | An exclusive list of allowed values. | [optional] [default to nothing]
**minimum** | **Float64** | The minimum value (inclusive) allowed for a numerical value. | [optional] [default to nothing]
**maximum** | **Float64** | The maximum value (inclusive) allowed for a numerical value. | [optional] [default to nothing]
**minItems** | **Float64** | The minimum number of items required in an array. | [optional] [default to 0]
**maxItems** | **Float64** | The maximum number of items required in an array. | [optional] [default to nothing]
**items** | [***JsonSchemaItems**](JsonSchemaItems.md) |  | [optional] [default to nothing]
**subtype** | **String** |  | [optional] [default to nothing]
**parameters** | [**Vector{Parameter}**](Parameter.md) | A list of parameters passed to the child process graph.  The order in the array corresponds to the parameter order to be used in clients that don&#39;t support named parameters. | [optional] [default to nothing]
**returns** | [***ProcessGraphReturnValue**](ProcessGraphReturnValue.md) |  | [optional] [default to nothing]
**dimensions** | [**Vector{OneOf}**](OneOf.md) | Allows to specify requirements the data cube has to fulfill. Right now, it only allows to specify the dimension types and  adds for specific dimension types: * axes for &#x60;spatial&#x60; dimensions in raster datacubes * geometry types for &#x60;geometry&#x60; dimensions in vector datacubes | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


