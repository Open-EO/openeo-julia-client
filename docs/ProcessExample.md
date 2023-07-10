# ProcessExample


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **String** | A title for the example. | [optional] [default to nothing]
**description** | **String** | Detailed description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. In addition to the CommonMark syntax, clients can convert process IDs that are formatted as in the following example into links instead of code blocks: &#x60;&#x60;&#x60; &#x60;&#x60;process_id()&#x60;&#x60; &#x60;&#x60;&#x60; | [optional] [default to nothing]
**arguments** | [**Dict{String, ProcessArgumentValue}**](ProcessArgumentValue.md) |  | [default to nothing]
**returns** | **Any** | The return value which can by of any data type. | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


