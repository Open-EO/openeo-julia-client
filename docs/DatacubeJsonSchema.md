# DatacubeJsonSchema


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**subtype** | **String** |  | [optional] [default to nothing]
**dimensions** | [**Vector{OneOf}**](OneOf.md) | Allows to specify requirements the data cube has to fulfill. Right now, it only allows to specify the dimension types and  adds for specific dimension types: * axes for &#x60;spatial&#x60; dimensions in raster datacubes * geometry types for &#x60;geometry&#x60; dimensions in vector datacubes | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


