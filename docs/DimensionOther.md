# DimensionOther


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** | Type of the dimension. | [default to nothing]
**description** | **String** | Detailed description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. | [optional] [default to nothing]
**extent** | **Vector{Float64}** | If the dimension consists of [ordinal](https://en.wikipedia.org/wiki/Level_of_measurement#Ordinal_scale) values, the extent (lower and upper bounds) of the values as two-dimensional array. Use &#x60;null&#x60; for open intervals. | [optional] [default to nothing]
**values** | [**Vector{CollectionDimensionValuesInner}**](CollectionDimensionValuesInner.md) | A set of all potential values, especially useful for [nominal](https://en.wikipedia.org/wiki/Level_of_measurement#Nominal_level) values.  **Important:** The order of the values MUST be exactly how the dimension values are also ordered in the data (cube). If the values specify band names, the values MUST be in the same order as they are in the corresponding band fields (i.e. &#x60;eo:bands&#x60; or &#x60;sar:bands&#x60;). | [optional] [default to nothing]
**step** | **Float64** | If the dimension consists of [interval](https://en.wikipedia.org/wiki/Level_of_measurement#Interval_scale) values, the space between the values. Use &#x60;null&#x60; for irregularly spaced steps. | [optional] [default to nothing]
**unit** | **String** | The unit of measurement for the data, preferably compliant to [UDUNITS-2](https://ncics.org/portfolio/other-resources/udunits2/) units (singular). | [optional] [default to nothing]
**reference_system** | **String** | The reference system for the dimension. | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


