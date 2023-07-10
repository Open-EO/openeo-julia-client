# BatchJobEstimate


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**costs** | **Float64** | An amount of money or credits. The value MUST be specified in the currency the back-end is working with. The currency can be retrieved by calling &#x60;GET /&#x60;. If no currency is set, this field MUST be &#x60;null&#x60;. | [optional] [default to nothing]
**duration** | **String** | Estimated duration for the operation. Duration MUST be specified as a ISO 8601 duration. | [optional] [default to nothing]
**size** | **Int64** | Estimated required storage capacity, i.e. the size of the generated files. Size MUST be specified in bytes. | [optional] [default to nothing]
**downloads_included** | **Int64** | Specifies how many full downloads of the processed data are included in the estimate. Set to &#x60;null&#x60; for unlimited downloads, which is also the default value. | [optional] [default to nothing]
**expires** | **ZonedDateTime** | Time until which the estimate is valid, formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time. | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


