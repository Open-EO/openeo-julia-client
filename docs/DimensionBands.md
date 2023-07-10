# DimensionBands


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** | Type of the dimension. | [default to nothing]
**description** | **String** | Detailed description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. | [optional] [default to nothing]
**values** | [**Vector{CollectionDimensionValuesInner}**](CollectionDimensionValuesInner.md) | A set of all potential values, especially useful for [nominal](https://en.wikipedia.org/wiki/Level_of_measurement#Nominal_level) values.  **Important:** The order of the values MUST be exactly how the dimension values are also ordered in the data (cube). If the values specify band names, the values MUST be in the same order as they are in the corresponding band fields (i.e. &#x60;eo:bands&#x60; or &#x60;sar:bands&#x60;). | [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


