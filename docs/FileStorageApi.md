# FileStorageApi

All URIs are relative to *https://openeo.example/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**delete_file**](FileStorageApi.md#delete_file) | **DELETE** /files/{path} | Delete a file from the workspace
[**download_file**](FileStorageApi.md#download_file) | **GET** /files/{path} | Download a file from the workspace
[**list_files**](FileStorageApi.md#list_files) | **GET** /files | List all files in the workspace
[**upload_file**](FileStorageApi.md#upload_file) | **PUT** /files/{path} | Upload a file to the workspace


# **delete_file**
> delete_file(_api::FileStorageApi, path::String; _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> delete_file(_api::FileStorageApi, response_stream::Channel, path::String; _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Delete a file from the workspace

Deletes an existing user-uploaded file specified by its path. Resulting empty folders MUST be deleted automatically.  Back-ends MAY support deleting folders including its files and sub-folders. If not supported by the back-end a `FileOperationUnsupported` error MUST be sent as response.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **FileStorageApi** | API context | 
**path** | **String**| Path of the file, relative to the user&#39;s root directory. MAY include folders, but MUST not include relative references such as &#x60;.&#x60; and &#x60;..&#x60;.  Folder and file names in the path MUST be url-encoded. The path separator &#x60;/&#x60; and the file extension separator &#x60;.&#x60; MUST NOT be url-encoded.  The URL-encoding may be shown incorrectly in rendered versions due to [OpenAPI 3 not supporting path parameters which contain slashes](https://github.com/OAI/OpenAPI-Specification/issues/892). This may also lead to OpenAPI validators not validating paths containing folders correctly. | [default to nothing]

### Return type

Nothing

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **download_file**
> download_file(_api::FileStorageApi, path::String; _mediaType=nothing) -> String, OpenAPI.Clients.ApiResponse <br/>
> download_file(_api::FileStorageApi, response_stream::Channel, path::String; _mediaType=nothing) -> Channel{ String }, OpenAPI.Clients.ApiResponse

Download a file from the workspace

Offers a file from the user workspace for download. The file is identified by its path relative to the user's root directory. If a folder is specified as path a `FileOperationUnsupported` error MUST be sent as response.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **FileStorageApi** | API context | 
**path** | **String**| Path of the file, relative to the user&#39;s root directory. MAY include folders, but MUST not include relative references such as &#x60;.&#x60; and &#x60;..&#x60;.  Folder and file names in the path MUST be url-encoded. The path separator &#x60;/&#x60; and the file extension separator &#x60;.&#x60; MUST NOT be url-encoded.  The URL-encoding may be shown incorrectly in rendered versions due to [OpenAPI 3 not supporting path parameters which contain slashes](https://github.com/OAI/OpenAPI-Specification/issues/892). This may also lead to OpenAPI validators not validating paths containing folders correctly. | [default to nothing]

### Return type

**String**

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/octet-stream, application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **list_files**
> list_files(_api::FileStorageApi; limit=nothing, _mediaType=nothing) -> WorkspaceFiles, OpenAPI.Clients.ApiResponse <br/>
> list_files(_api::FileStorageApi, response_stream::Channel; limit=nothing, _mediaType=nothing) -> Channel{ WorkspaceFiles }, OpenAPI.Clients.ApiResponse

List all files in the workspace

Lists all user-uploaded files that are stored at the back-end.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **FileStorageApi** | API context | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **Int64**| This parameter enables pagination for the endpoint and specifies the maximum number of elements that arrays in the top-level object (e.g. collections, processes, batch jobs, secondary services, log entries, etc.) are allowed to contain. The &#x60;links&#x60; array MUST NOT be paginated like the resources, but instead contain links related to the paginated resources or the pagination itself (e.g. a link to the next page). If the parameter is not provided or empty, all elements are returned.  Pagination is OPTIONAL: back-ends or clients may not support it. Therefore it MUST be implemented in a way that clients not supporting pagination get all resources regardless. Back-ends not supporting pagination MUST return all resources.  If the response is paginated, the &#x60;links&#x60; array MUST be used to communicate the links for browsing the pagination with predefined &#x60;rel&#x60; types. See the &#x60;links&#x60; array schema for supported &#x60;rel&#x60; types. Back-end implementations can, unless specified otherwise, use all kind of pagination techniques, depending on what is supported best by their infrastructure: page-based, offset-based, token-based or something else. The clients SHOULD use whatever is specified in the links with the corresponding &#x60;rel&#x60; types. | [default to nothing]

### Return type

[**WorkspaceFiles**](WorkspaceFiles.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **upload_file**
> upload_file(_api::FileStorageApi, path::String, body::String; _mediaType=nothing) -> String, OpenAPI.Clients.ApiResponse <br/>
> upload_file(_api::FileStorageApi, response_stream::Channel, path::String, body::String; _mediaType=nothing) -> Channel{ String }, OpenAPI.Clients.ApiResponse

Upload a file to the workspace

Uploads a new file to the given path or updates an existing file if a file at the path exists.  Folders are created once required by a file upload. Empty folders can't be created.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **FileStorageApi** | API context | 
**path** | **String**| Path of the file, relative to the user&#39;s root directory. MAY include folders, but MUST not include relative references such as &#x60;.&#x60; and &#x60;..&#x60;.  Folder and file names in the path MUST be url-encoded. The path separator &#x60;/&#x60; and the file extension separator &#x60;.&#x60; MUST NOT be url-encoded.  The URL-encoding may be shown incorrectly in rendered versions due to [OpenAPI 3 not supporting path parameters which contain slashes](https://github.com/OAI/OpenAPI-Specification/issues/892). This may also lead to OpenAPI validators not validating paths containing folders correctly. | [default to nothing]
**body** | **String****String**|  | 

### Return type

**String**

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/octet-stream
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

