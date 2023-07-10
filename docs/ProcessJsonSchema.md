# ProcessJsonSchema



## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**value** | This is a oneOf model. The value must be exactly one of the following types: JsonSchema | Specifies a data type supported by a parameter or return value.  The data types are specified according to the [JSON Schema draft-07](http://json-schema.org/) specification. See the chapter [&#39;Schemas&#39; in &#39;Defining Processes&#39;](#section/Processes/Defining-Processes) for more information.  JSON Schemas SHOULD NOT contain &#x60;default&#x60;, &#x60;anyOf&#x60;, &#x60;oneOf&#x60;, &#x60;allOf&#x60; or &#x60;not&#x60; at the top-level of the schema. Instead specify each data type in a separate array element.  The following more complex JSON Schema keywords SHOULD NOT be used: &#x60;if&#x60;, &#x60;then&#x60;, &#x60;else&#x60;, &#x60;readOnly&#x60;, &#x60;writeOnly&#x60;, &#x60;dependencies&#x60;, &#x60;minProperties&#x60;, &#x60;maxProperties&#x60;, &#x60;patternProperties&#x60;.  JSON Schemas SHOULD always be dereferenced (i.e. all &#x60;$refs&#x60; should be resolved). This allows clients to consume the schemas much better. Clients are not expected to support dereferencing &#x60;$refs&#x60;.  Note: The specified schema is only a common subset of JSON Schema. Additional keywords MAY be used. | [optional] 




[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


