# Asset


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**href** | **String** | URL to the downloadable asset. The URLs SHOULD be available without authentication so that external clients can download them easily. If the data is confidential, signed URLs SHOULD be used to protect against unauthorized access from third parties. | [default to nothing]
**title** | **String** | The displayed title for clients and users. | [optional] [default to nothing]
**description** | **String** | Multi-line description to explain the asset.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. | [optional] [default to nothing]
**type** | **String** | Media type of the asset. | [optional] [default to nothing]
**roles** | **Vector{String}** | Purposes of the asset. Can be any value, but commonly used values are:  * &#x60;thumbnail&#x60;: A visualization of the data, usually a lower-resolution true color image in JPEG or PNG format. * &#x60;reproducibility&#x60;: Information how the data was produced and/or can be reproduced, e.g. the process graph used to compute the data in JSON format. * &#x60;data&#x60;: The computed data in the format specified by the user in the process graph (applicable in &#x60;GET /jobs/{job_id}/results&#x60; only). * &#x60;metadata&#x60;: Additional metadata available for the computed data. | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


