# CollectionSpatialExtent


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**bbox** | **Vector{Vector}** | One or more bounding boxes that describe the spatial extent of the dataset.  The first bounding box describes the overall spatial extent of the data. All subsequent bounding boxes describe more precise bounding boxes, e.g. to identify clusters of data. Clients only interested in the overall spatial extent will only need to access the first item in each array. | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


