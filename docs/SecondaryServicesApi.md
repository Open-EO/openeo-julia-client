# SecondaryServicesApi

All URIs are relative to *https://openeo.example/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_service**](SecondaryServicesApi.md#create_service) | **POST** /services | Publish a new service
[**debug_service**](SecondaryServicesApi.md#debug_service) | **GET** /services/{service_id}/logs | Logs for a secondary service
[**delete_service**](SecondaryServicesApi.md#delete_service) | **DELETE** /services/{service_id} | Delete a service
[**describe_service**](SecondaryServicesApi.md#describe_service) | **GET** /services/{service_id} | Full metadata for a service
[**list_service_types**](SecondaryServicesApi.md#list_service_types) | **GET** /service_types | Supported secondary web service protocols
[**list_services**](SecondaryServicesApi.md#list_services) | **GET** /services | List all web services
[**update_service**](SecondaryServicesApi.md#update_service) | **PATCH** /services/{service_id} | Modify a service


# **create_service**
> create_service(_api::SecondaryServicesApi, request_body::Dict{String, Any}; _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> create_service(_api::SecondaryServicesApi, response_stream::Channel, request_body::Dict{String, Any}; _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Publish a new service

Creates a new secondary web service such as a [OGC WMS](http://www.opengeospatial.org/standards/wms), [OGC WCS](http://www.opengeospatial.org/standards/wcs), [OGC API - Features](https://www.ogc.org/standards/ogcapi-features) or [XYZ tiles](https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames).  The secondary web service SHOULD process the underlying data on demand, based on process parameters provided to the user-defined process (through `from_parameter` references) at run-time, for example for the spatial/temporal extent, resolution, etc. The available process parameters are specified per service type at `GET /service_types`.  **Note:** Costs incurred by shared secondary web services are usually paid by the owner, but this depends on the service type and whether it supports charging fees or not.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **SecondaryServicesApi** | API context | 
**request_body** | [**Dict{String, Any}**](Any.md)| The base data for the secondary web service to create | 

### Return type

Nothing

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **debug_service**
> debug_service(_api::SecondaryServicesApi, service_id::String; offset=nothing, level=nothing, limit=nothing, _mediaType=nothing) -> LogEntries, OpenAPI.Clients.ApiResponse <br/>
> debug_service(_api::SecondaryServicesApi, response_stream::Channel, service_id::String; offset=nothing, level=nothing, limit=nothing, _mediaType=nothing) -> Channel{ LogEntries }, OpenAPI.Clients.ApiResponse

Logs for a secondary service

Lists log entries for the secondary service, usually for debugging purposes. Back-ends can log any information that may be relevant for a user. Users can log information during data processing using respective processes such as `inspect`. If requested consecutively while the secondary service is enabled, it is RECOMMENDED that clients use the offset parameter to get only the entries they have not received yet. While pagination itself is OPTIONAL, the `offset` parameter is REQUIRED to be implemented by back-ends.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **SecondaryServicesApi** | API context | 
**service_id** | **String**| Identifier of the secondary web service. | [default to nothing]

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **offset** | **String**| The last identifier (property &#x60;id&#x60; of a log entry) the client has received. If provided, the back-ends only sends the entries that occurred after the specified identifier. If not provided or empty, start with the first entry. | [default to nothing]
 **level** | **String**| The minimum severity level for log entries that the back-end returns.  The order of the levels is as follows (from low to high severity): &#x60;debug&#x60;, &#x60;info&#x60;, &#x60;warning&#x60;, &#x60;error&#x60;. That means if &#x60;warning&#x60; is set, the back-end will only return log entries with the level &#x60;warning&#x60; and &#x60;error&#x60;.  The default minimum log level is &#x60;debug&#x60;, which returns all log levels. | [default to info]
 **limit** | **Int64**| This parameter enables pagination for the endpoint and specifies the maximum number of elements that arrays in the top-level object (e.g. collections, processes, batch jobs, secondary services, log entries, etc.) are allowed to contain. The &#x60;links&#x60; array MUST NOT be paginated like the resources, but instead contain links related to the paginated resources or the pagination itself (e.g. a link to the next page). If the parameter is not provided or empty, all elements are returned.  Pagination is OPTIONAL: back-ends or clients may not support it. Therefore it MUST be implemented in a way that clients not supporting pagination get all resources regardless. Back-ends not supporting pagination MUST return all resources.  If the response is paginated, the &#x60;links&#x60; array MUST be used to communicate the links for browsing the pagination with predefined &#x60;rel&#x60; types. See the &#x60;links&#x60; array schema for supported &#x60;rel&#x60; types. Back-end implementations can, unless specified otherwise, use all kind of pagination techniques, depending on what is supported best by their infrastructure: page-based, offset-based, token-based or something else. The clients SHOULD use whatever is specified in the links with the corresponding &#x60;rel&#x60; types. | [default to nothing]

### Return type

[**LogEntries**](LogEntries.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **delete_service**
> delete_service(_api::SecondaryServicesApi, service_id::String; _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> delete_service(_api::SecondaryServicesApi, response_stream::Channel, service_id::String; _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Delete a service

Deletes all data related to this secondary web service. Computations are stopped, computed results are deleted and access to this is not possible any more. This service won't generate additional costs.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **SecondaryServicesApi** | API context | 
**service_id** | **String**| Identifier of the secondary web service. | [default to nothing]

### Return type

Nothing

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **describe_service**
> describe_service(_api::SecondaryServicesApi, service_id::String; _mediaType=nothing) -> DescribeService200Response, OpenAPI.Clients.ApiResponse <br/>
> describe_service(_api::SecondaryServicesApi, response_stream::Channel, service_id::String; _mediaType=nothing) -> Channel{ DescribeService200Response }, OpenAPI.Clients.ApiResponse

Full metadata for a service

Lists all information about a secondary web service.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **SecondaryServicesApi** | API context | 
**service_id** | **String**| Identifier of the secondary web service. | [default to nothing]

### Return type

[**DescribeService200Response**](DescribeService200Response.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **list_service_types**
> list_service_types(_api::SecondaryServicesApi; _mediaType=nothing) -> Dict{String, ServiceTypes}, OpenAPI.Clients.ApiResponse <br/>
> list_service_types(_api::SecondaryServicesApi, response_stream::Channel; _mediaType=nothing) -> Channel{ Dict{String, ServiceTypes} }, OpenAPI.Clients.ApiResponse

Supported secondary web service protocols

Lists supported secondary web service protocols such as [OGC WMS](http://www.opengeospatial.org/standards/wms), [OGC WCS](http://www.opengeospatial.org/standards/wcs), [OGC API - Features](https://www.ogc.org/standards/ogcapi-features) or [XYZ tiles](https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames). The response is an object of all available secondary web service protocols with their supported configuration settings and expected process parameters.  * The configuration settings for the service SHOULD be defined upon   creation of a service and the service will be set up accordingly. * The process parameters SHOULD be referenced (with a `from_parameter`   reference) in the user-defined process that is used to compute web service   results.   The appropriate arguments MUST be provided to the user-defined process,   usually at runtime from the context of the web service,   For example, a map service such as a WMS would   need to inject the spatial extent into the user-defined process so that the   back-end can compute the corresponding tile correctly.  To improve interoperability between back-ends common names for the services SHOULD be used, e.g. the abbreviations used in the official [OGC Schema Repository](http://schemas.opengis.net/) for the respective services.  Service names MUST be accepted in a *case insensitive* manner throughout the API.

### Required Parameters
This endpoint does not need any parameter.

### Return type

[**Dict{String, ServiceTypes}**](ServiceTypes.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **list_services**
> list_services(_api::SecondaryServicesApi; limit=nothing, _mediaType=nothing) -> SecondaryWebServices, OpenAPI.Clients.ApiResponse <br/>
> list_services(_api::SecondaryServicesApi, response_stream::Channel; limit=nothing, _mediaType=nothing) -> Channel{ SecondaryWebServices }, OpenAPI.Clients.ApiResponse

List all web services

Lists all secondary web services submitted by a user.  It is **strongly RECOMMENDED** to keep the response size small by omitting all optional non-scalar values (i.e. arrays and objects) from objects in `services` (i.e. the `process`, `configuration` and `attributes` properties). To get the full metadata for a secondary web service clients MUST request `GET /services/{service_id}`.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **SecondaryServicesApi** | API context | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **Int64**| This parameter enables pagination for the endpoint and specifies the maximum number of elements that arrays in the top-level object (e.g. collections, processes, batch jobs, secondary services, log entries, etc.) are allowed to contain. The &#x60;links&#x60; array MUST NOT be paginated like the resources, but instead contain links related to the paginated resources or the pagination itself (e.g. a link to the next page). If the parameter is not provided or empty, all elements are returned.  Pagination is OPTIONAL: back-ends or clients may not support it. Therefore it MUST be implemented in a way that clients not supporting pagination get all resources regardless. Back-ends not supporting pagination MUST return all resources.  If the response is paginated, the &#x60;links&#x60; array MUST be used to communicate the links for browsing the pagination with predefined &#x60;rel&#x60; types. See the &#x60;links&#x60; array schema for supported &#x60;rel&#x60; types. Back-end implementations can, unless specified otherwise, use all kind of pagination techniques, depending on what is supported best by their infrastructure: page-based, offset-based, token-based or something else. The clients SHOULD use whatever is specified in the links with the corresponding &#x60;rel&#x60; types. | [default to nothing]

### Return type

[**SecondaryWebServices**](SecondaryWebServices.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **update_service**
> update_service(_api::SecondaryServicesApi, service_id::String, update_secondary_web_service_request::UpdateSecondaryWebServiceRequest; _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> update_service(_api::SecondaryServicesApi, response_stream::Channel, service_id::String, update_secondary_web_service_request::UpdateSecondaryWebServiceRequest; _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Modify a service

Modifies an existing secondary web service at the back-end, but maintain the identifier. Changes can be grouped in a single request.  User have to create a new service to change the service type.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **SecondaryServicesApi** | API context | 
**service_id** | **String**| Identifier of the secondary web service. | [default to nothing]
**update_secondary_web_service_request** | [**UpdateSecondaryWebServiceRequest**](UpdateSecondaryWebServiceRequest.md)| The data to change for the specified secondary web service. | 

### Return type

Nothing

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

