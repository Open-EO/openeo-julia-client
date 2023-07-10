# JsonSchema


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
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


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


