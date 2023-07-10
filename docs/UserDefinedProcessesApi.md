# UserDefinedProcessesApi

All URIs are relative to *https://openeo.example/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**delete_custom_process**](UserDefinedProcessesApi.md#delete_custom_process) | **DELETE** /process_graphs/{process_graph_id} | Delete a user-defined process
[**describe_custom_process**](UserDefinedProcessesApi.md#describe_custom_process) | **GET** /process_graphs/{process_graph_id} | Full metadata for a user-defined process
[**list_custom_processes**](UserDefinedProcessesApi.md#list_custom_processes) | **GET** /process_graphs | List all user-defined processes
[**store_custom_process**](UserDefinedProcessesApi.md#store_custom_process) | **PUT** /process_graphs/{process_graph_id} | Store a user-defined process
[**validate_custom_process**](UserDefinedProcessesApi.md#validate_custom_process) | **POST** /validation | Validate a user-defined process (graph)


# **delete_custom_process**
> delete_custom_process(_api::UserDefinedProcessesApi, process_graph_id::String; _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> delete_custom_process(_api::UserDefinedProcessesApi, response_stream::Channel, process_graph_id::String; _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Delete a user-defined process

Deletes the data related to this user-defined process, including its process graph.  Does NOT delete jobs or services that reference this user-defined process.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **UserDefinedProcessesApi** | API context | 
**process_graph_id** | **String**| Per-user unique identifier for a user-defined process. | [default to nothing]

### Return type

Nothing

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **describe_custom_process**
> describe_custom_process(_api::UserDefinedProcessesApi, process_graph_id::String; _mediaType=nothing) -> UserDefinedProcess, OpenAPI.Clients.ApiResponse <br/>
> describe_custom_process(_api::UserDefinedProcessesApi, response_stream::Channel, process_graph_id::String; _mediaType=nothing) -> Channel{ UserDefinedProcess }, OpenAPI.Clients.ApiResponse

Full metadata for a user-defined process

Lists all information about a user-defined process, including its process graph.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **UserDefinedProcessesApi** | API context | 
**process_graph_id** | **String**| Per-user unique identifier for a user-defined process. | [default to nothing]

### Return type

[**UserDefinedProcess**](UserDefinedProcess.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **list_custom_processes**
> list_custom_processes(_api::UserDefinedProcessesApi; limit=nothing, _mediaType=nothing) -> UserDefinedProcesses, OpenAPI.Clients.ApiResponse <br/>
> list_custom_processes(_api::UserDefinedProcessesApi, response_stream::Channel; limit=nothing, _mediaType=nothing) -> Channel{ UserDefinedProcesses }, OpenAPI.Clients.ApiResponse

List all user-defined processes

Lists all user-defined processes (process graphs) of the authenticated user that are stored at the back-end.  It is **strongly RECOMMENDED** to keep the response size small by omitting larger optional values from the objects in `processes` (e.g. the `exceptions`, `examples` and `links` properties). To get the full metadata for a user-defined process clients MUST request `GET /process_graphs/{process_graph_id}`.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **UserDefinedProcessesApi** | API context | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **Int64**| This parameter enables pagination for the endpoint and specifies the maximum number of elements that arrays in the top-level object (e.g. collections, processes, batch jobs, secondary services, log entries, etc.) are allowed to contain. The &#x60;links&#x60; array MUST NOT be paginated like the resources, but instead contain links related to the paginated resources or the pagination itself (e.g. a link to the next page). If the parameter is not provided or empty, all elements are returned.  Pagination is OPTIONAL: back-ends or clients may not support it. Therefore it MUST be implemented in a way that clients not supporting pagination get all resources regardless. Back-ends not supporting pagination MUST return all resources.  If the response is paginated, the &#x60;links&#x60; array MUST be used to communicate the links for browsing the pagination with predefined &#x60;rel&#x60; types. See the &#x60;links&#x60; array schema for supported &#x60;rel&#x60; types. Back-end implementations can, unless specified otherwise, use all kind of pagination techniques, depending on what is supported best by their infrastructure: page-based, offset-based, token-based or something else. The clients SHOULD use whatever is specified in the links with the corresponding &#x60;rel&#x60; types. | [default to nothing]

### Return type

[**UserDefinedProcesses**](UserDefinedProcesses.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **store_custom_process**
> store_custom_process(_api::UserDefinedProcessesApi, process_graph_id::String, process_graph_with_metadata::ProcessGraphWithMetadata; _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> store_custom_process(_api::UserDefinedProcessesApi, response_stream::Channel, process_graph_id::String, process_graph_with_metadata::ProcessGraphWithMetadata; _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Store a user-defined process

Stores a provided user-defined process with process graph that can be reused in other processes.  If a process with the specified `process_graph_id` exists, the process is fully replaced. The id can't be changed for existing user-defined processes. The id MUST be unique across its namespace.  Partially updating user-defined processes is not supported.  To simplify exchanging user-defined processes, the property `id` can be part of the request body. If the values don't match, the value for `id` gets replaced with the value from the `process_graph_id` parameter in the path.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **UserDefinedProcessesApi** | API context | 
**process_graph_id** | **String**| Per-user unique identifier for a user-defined process. | [default to nothing]
**process_graph_with_metadata** | [**ProcessGraphWithMetadata**](ProcessGraphWithMetadata.md)| Specifies the process graph with its meta data. | 

### Return type

Nothing

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **validate_custom_process**
> validate_custom_process(_api::UserDefinedProcessesApi, process_graph_with_metadata::ProcessGraphWithMetadata; _mediaType=nothing) -> ValidationResult, OpenAPI.Clients.ApiResponse <br/>
> validate_custom_process(_api::UserDefinedProcessesApi, response_stream::Channel, process_graph_with_metadata::ProcessGraphWithMetadata; _mediaType=nothing) -> Channel{ ValidationResult }, OpenAPI.Clients.ApiResponse

Validate a user-defined process (graph)

Validates a user-defined process without executing it. A user-defined process is considered valid unless the `errors` array in the response contains at least one error.  Checks whether the process graph is schematically correct and the processes are supported by the back-end. It MUST also check the arguments against the schema, but checking whether the arguments are adequate in the context of data is OPTIONAL. For example, a non-existing band name may get rejected only by a few back-ends. The validation MUST NOT throw an error for unresolvable process parameters.  Back-ends MUST validate the process graph. Validating the corresponding metadata is OPTIONAL.  Errors that usually occur during processing MAY NOT get reported, e.g. if a referenced file is accessible at the time of execution.  Back-ends can either report all errors at once or stop the validation once they found the first error.   Please note that a validation always returns with HTTP status code 200. Error codes in the 4xx and 5xx ranges MUST be returned only when the general validation request is invalid (e.g. server is busy or properties in the request body are missing), but never if an error was found during validation of the user-defined process (e.g. an unsupported process).

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **UserDefinedProcessesApi** | API context | 
**process_graph_with_metadata** | [**ProcessGraphWithMetadata**](ProcessGraphWithMetadata.md)| Specifies the user-defined process to be validated. | 

### Return type

[**ValidationResult**](ValidationResult.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

