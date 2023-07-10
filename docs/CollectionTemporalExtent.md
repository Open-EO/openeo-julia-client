# CollectionTemporalExtent


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**interval** | **Vector{Vector{ZonedDateTime}}** | One or more time intervals that describe the temporal extent of the dataset.  The first time interval describes the overall temporal extent of the data. All subsequent time intervals describe more precise time intervals, e.g. to identify clusters of data. Clients only interested in the overall extent will only need to access the first item in each array. | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


