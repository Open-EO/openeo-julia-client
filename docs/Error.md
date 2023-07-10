# Error


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | A back-end MAY add a unique identifier to the error response to be able to log and track errors with further non-disclosable details. A client could communicate this id to a back-end provider to get further information. | [optional] [default to nothing]
**code** | **String** | The code is either one of the standardized error codes or a custom code, for example specified by a user in the &#x60;inspect&#x60; process. | [default to nothing]
**message** | **String** | A message explaining what the client may need to change or what difficulties the server is facing. | [default to nothing]
**links** | [**Vector{Link}**](Link.md) | Links related to this log entry / error, e.g. to a resource that provides further explanations.  For relation types see the lists of [common relation types in openEO](#section/API-Principles/Web-Linking). | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


