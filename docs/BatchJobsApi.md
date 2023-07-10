# BatchJobsApi

All URIs are relative to *https://openeo.example/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**create_job**](BatchJobsApi.md#create_job) | **POST** /jobs | Create a new batch job
[**debug_job**](BatchJobsApi.md#debug_job) | **GET** /jobs/{job_id}/logs | Logs for a batch job
[**delete_job**](BatchJobsApi.md#delete_job) | **DELETE** /jobs/{job_id} | Delete a batch job
[**describe_job**](BatchJobsApi.md#describe_job) | **GET** /jobs/{job_id} | Full metadata for a batch job
[**estimate_job**](BatchJobsApi.md#estimate_job) | **GET** /jobs/{job_id}/estimate | Get an estimate for a batch job
[**list_jobs**](BatchJobsApi.md#list_jobs) | **GET** /jobs | List all batch jobs
[**list_results**](BatchJobsApi.md#list_results) | **GET** /jobs/{job_id}/results | List batch job results
[**start_job**](BatchJobsApi.md#start_job) | **POST** /jobs/{job_id}/results | Start processing a batch job
[**stop_job**](BatchJobsApi.md#stop_job) | **DELETE** /jobs/{job_id}/results | Cancel processing a batch job
[**update_job**](BatchJobsApi.md#update_job) | **PATCH** /jobs/{job_id} | Modify a batch job


# **create_job**
> create_job(_api::BatchJobsApi, request_body::Dict{String, Any}; _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> create_job(_api::BatchJobsApi, response_stream::Channel, request_body::Dict{String, Any}; _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Create a new batch job

Creates a new batch processing task (job) from one or more (chained) processes at the back-end.  Processing the data doesn't start yet. The job status gets initialized as `created` by default.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **BatchJobsApi** | API context | 
**request_body** | [**Dict{String, Any}**](Any.md)| Specifies the job details, e.g. the user-defined process and billing details. | 

### Return type

Nothing

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **debug_job**
> debug_job(_api::BatchJobsApi, job_id::String; offset=nothing, level=nothing, limit=nothing, _mediaType=nothing) -> LogEntries, OpenAPI.Clients.ApiResponse <br/>
> debug_job(_api::BatchJobsApi, response_stream::Channel, job_id::String; offset=nothing, level=nothing, limit=nothing, _mediaType=nothing) -> Channel{ LogEntries }, OpenAPI.Clients.ApiResponse

Logs for a batch job

Lists log entries for the batch job, usually for debugging purposes.  Back-ends can log any information that may be relevant for a user at any stage (status) of the batch job. Users can log information during data processing using respective processes such as `inspect`.  If requested consecutively, it is RECOMMENDED that clients use the offset parameter to get only the entries they have not received yet.  While pagination itself is OPTIONAL, the `offset` parameter is REQUIRED to be implemented by back-ends.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **BatchJobsApi** | API context | 
**job_id** | **String**| Identifier of the batch job. | [default to nothing]

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

# **delete_job**
> delete_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> delete_job(_api::BatchJobsApi, response_stream::Channel, job_id::String; _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Delete a batch job

Deletes all data related to this job. Computations are stopped and computed results are deleted. This job won't generate additional costs for processing.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **BatchJobsApi** | API context | 
**job_id** | **String**| Identifier of the batch job. | [default to nothing]

### Return type

Nothing

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **describe_job**
> describe_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing) -> DescribeJob200Response, OpenAPI.Clients.ApiResponse <br/>
> describe_job(_api::BatchJobsApi, response_stream::Channel, job_id::String; _mediaType=nothing) -> Channel{ DescribeJob200Response }, OpenAPI.Clients.ApiResponse

Full metadata for a batch job

Lists all information about a submitted batch job.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **BatchJobsApi** | API context | 
**job_id** | **String**| Identifier of the batch job. | [default to nothing]

### Return type

[**DescribeJob200Response**](DescribeJob200Response.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **estimate_job**
> estimate_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing) -> BatchJobEstimate, OpenAPI.Clients.ApiResponse <br/>
> estimate_job(_api::BatchJobsApi, response_stream::Channel, job_id::String; _mediaType=nothing) -> Channel{ BatchJobEstimate }, OpenAPI.Clients.ApiResponse

Get an estimate for a batch job

Calculates an estimate for a batch job. Back-ends can decide to either calculate the duration, the costs, the size or a combination of them. Back-end providers MAY specify an expiry time for the estimate. Starting to process data afterwards MAY be charged at a higher cost. Costs do often not include download costs. Whether download costs are included or not can be indicated explicitly with the `downloads_included` flag. The estimate SHOULD be the upper limit of the costs, but back-end are free to use the field according to their terms of service. For some batch jobs it is not (easily) possible to estimate the costs reliably, e.g. if a UDF or ML model is part of the process. In this case, the server SHOULD return a `EstimateComplexity` error with HTTP status code 500.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **BatchJobsApi** | API context | 
**job_id** | **String**| Identifier of the batch job. | [default to nothing]

### Return type

[**BatchJobEstimate**](BatchJobEstimate.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **list_jobs**
> list_jobs(_api::BatchJobsApi; limit=nothing, _mediaType=nothing) -> BatchJobs, OpenAPI.Clients.ApiResponse <br/>
> list_jobs(_api::BatchJobsApi, response_stream::Channel; limit=nothing, _mediaType=nothing) -> Channel{ BatchJobs }, OpenAPI.Clients.ApiResponse

List all batch jobs

Lists all batch jobs submitted by a user.  It is **strongly RECOMMENDED** to keep the response size small by omitting all optional non-scalar values (i.e. arrays and objects) from objects in `jobs` (i.e. the `process` property). To get the full metadata for a job clients MUST request `GET /jobs/{job_id}`.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **BatchJobsApi** | API context | 

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **Int64**| This parameter enables pagination for the endpoint and specifies the maximum number of elements that arrays in the top-level object (e.g. collections, processes, batch jobs, secondary services, log entries, etc.) are allowed to contain. The &#x60;links&#x60; array MUST NOT be paginated like the resources, but instead contain links related to the paginated resources or the pagination itself (e.g. a link to the next page). If the parameter is not provided or empty, all elements are returned.  Pagination is OPTIONAL: back-ends or clients may not support it. Therefore it MUST be implemented in a way that clients not supporting pagination get all resources regardless. Back-ends not supporting pagination MUST return all resources.  If the response is paginated, the &#x60;links&#x60; array MUST be used to communicate the links for browsing the pagination with predefined &#x60;rel&#x60; types. See the &#x60;links&#x60; array schema for supported &#x60;rel&#x60; types. Back-end implementations can, unless specified otherwise, use all kind of pagination techniques, depending on what is supported best by their infrastructure: page-based, offset-based, token-based or something else. The clients SHOULD use whatever is specified in the links with the corresponding &#x60;rel&#x60; types. | [default to nothing]

### Return type

[**BatchJobs**](BatchJobs.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **list_results**
> list_results(_api::BatchJobsApi, job_id::String; partial=nothing, _mediaType=nothing) -> ListResults200Response, OpenAPI.Clients.ApiResponse <br/>
> list_results(_api::BatchJobsApi, response_stream::Channel, job_id::String; partial=nothing, _mediaType=nothing) -> Channel{ ListResults200Response }, OpenAPI.Clients.ApiResponse

List batch job results

Lists signed URLs pointing to the processed files, usually after the batch job has finished. Back-ends may also point to intermediate results after the job has stopped due to an error or if the `partial` parameter has been set.  The response includes additional metadata. It is a valid [STAC Item](https://github.com/radiantearth/stac-spec/tree/v1.0.0/item-spec) (if it has spatial and temporal references included) or a valid [STAC Collection](https://github.com/radiantearth/stac-spec/tree/v1.0.0/collection-spec) (supported since openEO API version 1.1.0). The assets to download are in both cases available in the property `assets` and have the same structure. All additional metadata is not strictly required to download the files, but are helpful for users to understand the data.  STAC Collections can either (1) add all assets as collection-level assets or (2) link to STAC Catalogs and STAC Items with signed URLs, which will provide a full STAC catalog structure a client has to go through. Option 2 is overall the better  architectural choice and allows a fine-grained description of the processed data, but it is not compliant with previous versions of the openEO API. **To maintain backward compatibility, it is REQUIRED to still copy all assets in the STAC catalog structure into the collection-level assets.** This requirement is planned to be removed in openEO API version 2.0.0. A client can enforce that the server returns a GeoJSON through content negotiation with the media type `application/geo+json`, but the results may not contain very meaningful metadata aside from the assets.  Clients are RECOMMENDED to store this response and all potential sub-catalogs and items with the assets so that the downloaded data is then a self-contained STAC catalog user could publish easily with all the data and metadata.  URL signing is a way to protect files from unauthorized access with a key in the URL instead of HTTP header based authorization. The URL signing key is similar to a password and its inclusion in the URL allows to download files using simple GET requests supported by a wide range of programs, e.g. web browsers or download managers. Back-ends are responsible to generate the URL signing keys and to manage their appropriate expiration. The back-end MAY indicate an expiration time by setting the `expires` property in the reponse. Requesting this endpoint SHOULD always return non-expired URLs. Signed URLs that were generated for a previous request and already expired SHOULD NOT be reused, but regenerated with new expiration time. Signed URLs that expired MAY return the openEO error `ResultLinkExpired`.  It is **strongly recommended** to add a link with relation type `canonical` to the STAC Item or STAC Collection (see the `links` property for details).  If processing has not finished yet and the `partial` parameter is not set to `true` requests to this endpoint MUST be rejected with openEO error `JobNotFinished`.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **BatchJobsApi** | API context | 
**job_id** | **String**| Identifier of the batch job. | [default to nothing]

### Optional Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **partial** | **Bool**| If set to &#x60;true&#x60;, the results endpoint returns incomplete results while still running. Enabling this parameter requires to indicate the status of the batch job in the STAC metadata by setting the &#x60;openeo:status&#x60;. | [default to false]

### Return type

[**ListResults200Response**](ListResults200Response.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json, application/geo+json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **start_job**
> start_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> start_job(_api::BatchJobsApi, response_stream::Channel, job_id::String; _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Start processing a batch job

Adds a batch job to the processing queue to compute the results.  The result will be stored in the format specified in the process. To specify the format use a process such as `save_result`.  The job status is set to `queued`, if processing doesn't start instantly. The same applies if the job status is `canceled`, `finished`, or `error`, which restarts the job and discards previous results if the back-end doesn't reject the request with an error. Clients SHOULD warn users and ask for confirmation if results may get discarded.  * Once the processing starts the status is set to `running`. * Once the data is available to download the status is set to `finished`. * Whenever an error occurs during processing, the status MUST be set to `error`.  This endpoint has no effect if the job status is already `queued` or `running`. In particular, it doesn't restart a running job. To restart a queued or running job, processing MUST have been canceled before.  Back-ends SHOULD reject queueing jobs with openEO error `PaymentRequired`, if the back-end is able to detect that the budget is too low to fully process the request. Alternatively, back-ends MAY provide partial results once reaching the budget. If none of the alternatives is feasible, the results are discarded. Thus, client SHOULD warn users that reaching the budget may lead to partial or no results at all.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **BatchJobsApi** | API context | 
**job_id** | **String**| Identifier of the batch job. | [default to nothing]

### Return type

Nothing

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **stop_job**
> stop_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> stop_job(_api::BatchJobsApi, response_stream::Channel, job_id::String; _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Cancel processing a batch job

Cancels all related computations for this job at the back-end. It will stop generating additional costs for processing.  A subset of processed results may be available for downloading depending on the state of the job at the time it was canceled.  Results MUST NOT be deleted until the job processing is started again or the job is completely deleted through a request to `DELETE /jobs/{job_id}`.  This endpoint only has an effect if the job status is `queued` or `running`.  The job status is set to `canceled` if the status was `running` beforehand and partial or preliminary results are available to be downloaded. Otherwise the status is set to `created`. 

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **BatchJobsApi** | API context | 
**job_id** | **String**| Identifier of the batch job. | [default to nothing]

### Return type

Nothing

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **update_job**
> update_job(_api::BatchJobsApi, job_id::String, update_batch_job_request::UpdateBatchJobRequest; _mediaType=nothing) -> Nothing, OpenAPI.Clients.ApiResponse <br/>
> update_job(_api::BatchJobsApi, response_stream::Channel, job_id::String, update_batch_job_request::UpdateBatchJobRequest; _mediaType=nothing) -> Channel{ Nothing }, OpenAPI.Clients.ApiResponse

Modify a batch job

Modifies an existing job at the back-end, but maintains the identifier. Changes can be grouped in a single request.  The job status does not change.  Jobs can only be modified when the job is not queued and not running. Otherwise, requests to this endpoint MUST be rejected with openEO error `JobLocked`.

### Required Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **_api** | **BatchJobsApi** | API context | 
**job_id** | **String**| Identifier of the batch job. | [default to nothing]
**update_batch_job_request** | [**UpdateBatchJobRequest**](UpdateBatchJobRequest.md)| Specifies the job details to update. | 

### Return type

Nothing

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

