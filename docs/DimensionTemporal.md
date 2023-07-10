# DimensionTemporal


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** | Type of the dimension. | [default to nothing]
**description** | **String** | Detailed description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. | [optional] [default to nothing]
**values** | **Vector{String}** | If the dimension consists of set of specific values they can be listed here. The dates and/or times MUST be strings compliant to [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601). | [optional] [default to nothing]
**extent** | **Vector{String}** | Extent (lower and upper bounds) of the dimension as two-dimensional array. The dates and/or times MUST be strings compliant to [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601). &#x60;null&#x60; is allowed for open date ranges. | [default to nothing]
**step** | **String** | The space between the temporal instances as [ISO 8601 duration](https://en.wikipedia.org/wiki/ISO_8601#Durations), e.g. &#x60;P1D&#x60;. Use &#x60;null&#x60; for irregularly spaced steps. | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


