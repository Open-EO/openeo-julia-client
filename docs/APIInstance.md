# APIInstance


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**url** | **String** | *Absolute* URLs to the service. | [default to nothing]
**production** | **Bool** | Specifies whether the implementation is ready to be used in production use (&#x60;true&#x60;) or not (&#x60;false&#x60;). Clients SHOULD only connect to non-production implementations if the user explicitly confirmed to use a non-production implementation. This flag is part of &#x60;GET /.well-known/openeo&#x60; and &#x60;GET /&#x60;. It MUST be used consistently in both endpoints. | [optional] [default to false]
**api_version** | **String** | Version number of the openEO specification this back-end implements. | [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


