# Endpoint


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**path** | **String** | Path to the endpoint, relative to the URL of this endpoint. In general the paths MUST follow the paths specified in the openAPI specification as closely as possible. Therefore, paths MUST be prepended with a leading slash, but MUST NOT contain a trailing slash. Variables in the paths MUST be placed in curly braces and follow the parameter names in the openAPI specification, e.g. &#x60;{job_id}&#x60;. | [default to nothing]
**methods** | **Vector{String}** | Supported HTTP verbs in uppercase. It is OPTIONAL to list &#x60;OPTIONS&#x60; as method (see the [CORS section](#section/Cross-Origin-Resource-Sharing-(CORS))). | [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


