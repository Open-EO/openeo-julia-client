# Provider


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** | The name of the organization or the individual. | [default to nothing]
**description** | **String** | Multi-line description to add further provider information such as processing details for processors and producers, hosting details for hosts or basic contact information.  CommonMark 0.29 syntax MAY be used for rich text representation. | [optional] [default to nothing]
**roles** | **Vector{String}** | Roles of the provider.  The provider&#39;s role(s) can be one or more of the following elements: * &#x60;licensor&#x60;: The organization that is licensing the dataset under the license specified in the collection&#39;s license field. * &#x60;producer&#x60;: The producer of the data is the provider that initially captured and processed the source data, e.g. ESA for Sentinel-2 data. * &#x60;processor&#x60;: A processor is any provider who processed data to a derived product. * &#x60;host&#x60;: The host is the actual provider offering the data on their storage. There SHOULD be no more than one host, specified as last element of the list. | [optional] [default to nothing]
**url** | **String** | Homepage on which the provider describes the dataset and publishes contact information. | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


