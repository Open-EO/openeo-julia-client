# DimensionSpatialVertical


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** | Type of the dimension. | [default to nothing]
**description** | **String** | Detailed description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. | [optional] [default to nothing]
**axis** | [***DimensionAxisXyz**](DimensionAxisXyz.md) |  | [default to nothing]
**extent** | **Vector{Float64}** | Extent (lower and upper bounds) of the dimension as two-dimensional array. Open intervals with &#x60;null&#x60; are not allowed. | [optional] [default to nothing]
**values** | **Vector{Float64}** | A set of all potential values. | [optional] [default to nothing]
**step** | **Float64** | If the dimension consists of [interval](https://en.wikipedia.org/wiki/Level_of_measurement#Interval_scale) values, the space between the values. Use &#x60;null&#x60; for irregularly spaced steps. | [optional] [default to nothing]
**reference_system** | [***CollectionDimensionSrs**](CollectionDimensionSrs.md) |  | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


