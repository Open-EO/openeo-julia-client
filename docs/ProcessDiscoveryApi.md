# ProcessDiscoveryApi

All URIs are relative to *https://openeo.example/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**describe_custom_process**](ProcessDiscoveryApi.md#describe_custom_process) | **GET** /process_graphs/{process_graph_id} | Full metadata for a user-defined process
[**list_custom_processes**](ProcessDiscoveryApi.md#list_custom_processes) | **GET** /process_graphs | List all user-defined processes
[**list_processes**](ProcessDiscoveryApi.md#list_processes) | **GET** /processes | Supported predefined processes


# **describe_custom_process**
> describe_custom_process(_api::ProcessDiscoveryApi, process_graph_id::String; _mediaType=nothing) -> UserDefinedProcess, OpenAPI.Clients.ApiResponse <br/>
> describe_custom_process(_api::ProcessDiscoveryApi, response_stream::Channel, process_graph_id::String; _mediaType=nothing) -> Channel{ UserDefinedProcess }, OpenAPI.Clients.ApiResponse

Full metadata for a user-defined process

Lists all information about a user-defined process, including its process graph.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **ProcessDiscoveryApi** | API context | 
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
> list_custom_processes(_api::ProcessDiscoveryApi; limit=nothing, _mediaType=nothing) -> UserDefinedProcesses, OpenAPI.Clients.ApiResponse <br/>
> list_custom_processes(_api::ProcessDiscoveryApi, response_stream::Channel; limit=nothing, _mediaType=nothing) -> Channel{ UserDefinedProcesses }, OpenAPI.Clients.ApiResponse

List all user-defined processes

Lists all user-defined processes (process graphs) of the authenticated user that are stored at the back-end.  It is **strongly RECOMMENDED** to keep the response size small by omitting larger optional values from the objects in `processes` (e.g. the `exceptions`, `examples` and `links` properties). To get the full metadata for a user-defined process clients MUST request `GET /process_graphs/{process_graph_id}`.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **ProcessDiscoveryApi** | API context | 

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

# **list_processes**
> list_processes(_api::ProcessDiscoveryApi; limit=nothing, _mediaType=nothing) -> Processes, OpenAPI.Clients.ApiResponse <br/>
> list_processes(_api::ProcessDiscoveryApi, response_stream::Channel; limit=nothing, _mediaType=nothing) -> Channel{ Processes }, OpenAPI.Clients.ApiResponse

Supported predefined processes

Lists all predefined processes and returns detailed process descriptions, including parameters and return values.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **ProcessDiscoveryApi** | API context | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **Int64**| This parameter enables pagination for the endpoint and specifies the maximum number of elements that arrays in the top-level object (e.g. collections, processes, batch jobs, secondary services, log entries, etc.) are allowed to contain. The &#x60;links&#x60; array MUST NOT be paginated like the resources, but instead contain links related to the paginated resources or the pagination itself (e.g. a link to the next page). If the parameter is not provided or empty, all elements are returned.  Pagination is OPTIONAL: back-ends or clients may not support it. Therefore it MUST be implemented in a way that clients not supporting pagination get all resources regardless. Back-ends not supporting pagination MUST return all resources.  If the response is paginated, the &#x60;links&#x60; array MUST be used to communicate the links for browsing the pagination with predefined &#x60;rel&#x60; types. See the &#x60;links&#x60; array schema for supported &#x60;rel&#x60; types. Back-end implementations can, unless specified otherwise, use all kind of pagination techniques, depending on what is supported best by their infrastructure: page-based, offset-based, token-based or something else. The clients SHOULD use whatever is specified in the links with the corresponding &#x60;rel&#x60; types. | [default to nothing]

### Return type

[**Processes**](Processes.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

