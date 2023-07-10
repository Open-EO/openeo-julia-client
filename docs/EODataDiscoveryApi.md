# EODataDiscoveryApi

All URIs are relative to *https://openeo.example/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**describe_collection**](EODataDiscoveryApi.md#describe_collection) | **GET** /collections/{collection_id} | Full metadata for a specific dataset
[**list_collection_queryables**](EODataDiscoveryApi.md#list_collection_queryables) | **GET** /collections/{collection_id}/queryables | Metadata filters for a specific dataset
[**list_collections**](EODataDiscoveryApi.md#list_collections) | **GET** /collections | Basic metadata for all datasets


# **describe_collection**
> describe_collection(_api::EODataDiscoveryApi, collection_id::String; _mediaType=nothing) -> DescribeCollection200Response, OpenAPI.Clients.ApiResponse <br/>
> describe_collection(_api::EODataDiscoveryApi, response_stream::Channel, collection_id::String; _mediaType=nothing) -> Channel{ DescribeCollection200Response }, OpenAPI.Clients.ApiResponse

Full metadata for a specific dataset

Lists **all** information about a specific collection specified by the identifier `collection_id`.  This endpoint is compatible with [STAC API 0.9.0 and later](https://stacspec.org) and [OGC API - Features 1.0](http://docs.opengeospatial.org/is/17-069r3/17-069r3.html). [STAC API extensions](https://stac-api-extensions.github.io) and [STAC extensions](https://stac-extensions.github.io) can be implemented in addition to what is documented here.  Note: Providing the Bearer token is REQUIRED for private collections.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **EODataDiscoveryApi** | API context | 
**collection_id** | **String**| Collection identifier | [default to nothing]

### Return type

[**DescribeCollection200Response**](DescribeCollection200Response.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **list_collection_queryables**
> list_collection_queryables(_api::EODataDiscoveryApi, collection_id::String; _mediaType=nothing) -> JsonSchema, OpenAPI.Clients.ApiResponse <br/>
> list_collection_queryables(_api::EODataDiscoveryApi, response_stream::Channel, collection_id::String; _mediaType=nothing) -> Channel{ JsonSchema }, OpenAPI.Clients.ApiResponse

Metadata filters for a specific dataset

Lists **all** supported metadata filters (also called \"queryables\") for a specific collection.  This endpoint is compatible with endpoint defined in the STAC API extension [`filter`](https://github.com/stac-api-extensions/filter#queryables) and [OGC API - Features - Part 3: Filtering](https://github.com/opengeospatial/ogcapi-features/tree/master/extensions/filtering). For a precise definition please follow those specifications.  This endpoints provides a JSON Schema for each queryable that openEO users can use in multiple scenarios: 1. For loading data from the collection, e.g. in the process `load_collection`. 2. For filtering items using CQL2 on the `/collections/{collection_id}/items` endpoint    (if [STAC API - Features is implemented in addition to the openEO API](#tag/EO-Data-Discovery/STAC)).  Note: Providing the Bearer token is REQUIRED for private collections.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **EODataDiscoveryApi** | API context | 
**collection_id** | **String**| Collection identifier | [default to nothing]

### Return type

[**JsonSchema**](JsonSchema.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/schema+json, application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **list_collections**
> list_collections(_api::EODataDiscoveryApi; limit=nothing, _mediaType=nothing) -> Collections, OpenAPI.Clients.ApiResponse <br/>
> list_collections(_api::EODataDiscoveryApi, response_stream::Channel; limit=nothing, _mediaType=nothing) -> Channel{ Collections }, OpenAPI.Clients.ApiResponse

Basic metadata for all datasets

Lists available collections with at least the required information.  It is **strongly RECOMMENDED** to keep the response size small by omitting larger optional values from the objects in `collections` (e.g. the `summaries` and `cube:dimensions` properties). To get the full metadata for a collection clients MUST request `GET /collections/{collection_id}`.  This endpoint is compatible with [STAC API 0.9.0 and later](https://stacspec.org) and [OGC API - Features 1.0](http://docs.opengeospatial.org/is/17-069r3/17-069r3.html). [STAC API extensions](https://stac-api-extensions.github.io) and [STAC extensions](https://stac-extensions.github.io) can be implemented in addition to what is documented here.  Note: Although it is possible to request public collections without authorization, it is RECOMMENDED that clients (re-)request the collections with the Bearer token once available to also retrieve any private collections.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **EODataDiscoveryApi** | API context | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **Int64**| This parameter enables pagination for the endpoint and specifies the maximum number of elements that arrays in the top-level object (e.g. collections, processes, batch jobs, secondary services, log entries, etc.) are allowed to contain. The &#x60;links&#x60; array MUST NOT be paginated like the resources, but instead contain links related to the paginated resources or the pagination itself (e.g. a link to the next page). If the parameter is not provided or empty, all elements are returned.  Pagination is OPTIONAL: back-ends or clients may not support it. Therefore it MUST be implemented in a way that clients not supporting pagination get all resources regardless. Back-ends not supporting pagination MUST return all resources.  If the response is paginated, the &#x60;links&#x60; array MUST be used to communicate the links for browsing the pagination with predefined &#x60;rel&#x60; types. See the &#x60;links&#x60; array schema for supported &#x60;rel&#x60; types. Back-end implementations can, unless specified otherwise, use all kind of pagination techniques, depending on what is supported best by their infrastructure: page-based, offset-based, token-based or something else. The clients SHOULD use whatever is specified in the links with the corresponding &#x60;rel&#x60; types. | [default to nothing]

### Return type

[**Collections**](Collections.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

