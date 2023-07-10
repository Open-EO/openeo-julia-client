# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.

struct BatchJobsApi <: OpenAPI.APIClientImpl
    client::OpenAPI.Clients.Client
end

"""
The default API base path for APIs in `BatchJobsApi`.
This can be used to construct the `OpenAPI.Clients.Client` instance.
"""
basepath(::Type{ BatchJobsApi }) = "https://openeo.example/api/v1"

const _returntypes_create_job_BatchJobsApi = Dict{Regex,Type}(
    Regex("^" * replace("201", "x"=>".") * "\$") => Nothing,
    Regex("^" * replace("4XX", "x"=>".") * "\$") => Error,
    Regex("^" * replace("5XX", "x"=>".") * "\$") => Error,
)

function _oacinternal_create_job(_api::BatchJobsApi, request_body::Dict{String, Any}; _mediaType=nothing)
    _ctx = OpenAPI.Clients.Ctx(_api.client, "POST", _returntypes_create_job_BatchJobsApi, "/jobs", ["Bearer", ], request_body)
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? ["application/json", ] : [_mediaType])
    return _ctx
end

@doc raw"""Create a new batch job

Creates a new batch processing task (job) from one or more (chained) processes at the back-end.  Processing the data doesn't start yet. The job status gets initialized as `created` by default.

Params:
- request_body::Dict{String, Any} (required)

Return: Nothing, OpenAPI.Clients.ApiResponse
"""
function create_job(_api::BatchJobsApi, request_body::Dict{String, Any}; _mediaType=nothing)
    _ctx = _oacinternal_create_job(_api, request_body; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function create_job(_api::BatchJobsApi, response_stream::Channel, request_body::Dict{String, Any}; _mediaType=nothing)
    _ctx = _oacinternal_create_job(_api, request_body; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

const _returntypes_debug_job_BatchJobsApi = Dict{Regex,Type}(
    Regex("^" * replace("200", "x"=>".") * "\$") => LogEntries,
    Regex("^" * replace("4XX", "x"=>".") * "\$") => Error,
    Regex("^" * replace("5XX", "x"=>".") * "\$") => Error,
)

function _oacinternal_debug_job(_api::BatchJobsApi, job_id::String; offset=nothing, level=nothing, limit=nothing, _mediaType=nothing)

    OpenAPI.validate_param("limit", "debug_job", :minimum, limit, 1, false)

    _ctx = OpenAPI.Clients.Ctx(_api.client, "GET", _returntypes_debug_job_BatchJobsApi, "/jobs/{job_id}/logs", ["Bearer", ])
    OpenAPI.Clients.set_param(_ctx.path, "job_id", job_id)  # type String
    OpenAPI.Clients.set_param(_ctx.query, "offset", offset)  # type String
    OpenAPI.Clients.set_param(_ctx.query, "level", level)  # type String
    OpenAPI.Clients.set_param(_ctx.query, "limit", limit)  # type Int64
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? [] : [_mediaType])
    return _ctx
end

@doc raw"""Logs for a batch job

Lists log entries for the batch job, usually for debugging purposes.  Back-ends can log any information that may be relevant for a user at any stage (status) of the batch job. Users can log information during data processing using respective processes such as `inspect`.  If requested consecutively, it is RECOMMENDED that clients use the offset parameter to get only the entries they have not received yet.  While pagination itself is OPTIONAL, the `offset` parameter is REQUIRED to be implemented by back-ends.

Params:
- job_id::String (required)
- offset::String
- level::String
- limit::Int64

Return: LogEntries, OpenAPI.Clients.ApiResponse
"""
function debug_job(_api::BatchJobsApi, job_id::String; offset=nothing, level=nothing, limit=nothing, _mediaType=nothing)
    _ctx = _oacinternal_debug_job(_api, job_id; offset=offset, level=level, limit=limit, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function debug_job(_api::BatchJobsApi, response_stream::Channel, job_id::String; offset=nothing, level=nothing, limit=nothing, _mediaType=nothing)
    _ctx = _oacinternal_debug_job(_api, job_id; offset=offset, level=level, limit=limit, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

const _returntypes_delete_job_BatchJobsApi = Dict{Regex,Type}(
    Regex("^" * replace("204", "x"=>".") * "\$") => Nothing,
    Regex("^" * replace("4XX", "x"=>".") * "\$") => Error,
    Regex("^" * replace("5XX", "x"=>".") * "\$") => Error,
)

function _oacinternal_delete_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing)

    _ctx = OpenAPI.Clients.Ctx(_api.client, "DELETE", _returntypes_delete_job_BatchJobsApi, "/jobs/{job_id}", ["Bearer", ])
    OpenAPI.Clients.set_param(_ctx.path, "job_id", job_id)  # type String
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? [] : [_mediaType])
    return _ctx
end

@doc raw"""Delete a batch job

Deletes all data related to this job. Computations are stopped and computed results are deleted. This job won't generate additional costs for processing.

Params:
- job_id::String (required)

Return: Nothing, OpenAPI.Clients.ApiResponse
"""
function delete_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing)
    _ctx = _oacinternal_delete_job(_api, job_id; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function delete_job(_api::BatchJobsApi, response_stream::Channel, job_id::String; _mediaType=nothing)
    _ctx = _oacinternal_delete_job(_api, job_id; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

const _returntypes_describe_job_BatchJobsApi = Dict{Regex,Type}(
    Regex("^" * replace("200", "x"=>".") * "\$") => DescribeJob200Response,
    Regex("^" * replace("4XX", "x"=>".") * "\$") => Error,
    Regex("^" * replace("5XX", "x"=>".") * "\$") => Error,
)

function _oacinternal_describe_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing)

    _ctx = OpenAPI.Clients.Ctx(_api.client, "GET", _returntypes_describe_job_BatchJobsApi, "/jobs/{job_id}", ["Bearer", ])
    OpenAPI.Clients.set_param(_ctx.path, "job_id", job_id)  # type String
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? [] : [_mediaType])
    return _ctx
end

@doc raw"""Full metadata for a batch job

Lists all information about a submitted batch job.

Params:
- job_id::String (required)

Return: DescribeJob200Response, OpenAPI.Clients.ApiResponse
"""
function describe_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing)
    _ctx = _oacinternal_describe_job(_api, job_id; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function describe_job(_api::BatchJobsApi, response_stream::Channel, job_id::String; _mediaType=nothing)
    _ctx = _oacinternal_describe_job(_api, job_id; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

const _returntypes_estimate_job_BatchJobsApi = Dict{Regex,Type}(
    Regex("^" * replace("200", "x"=>".") * "\$") => BatchJobEstimate,
    Regex("^" * replace("4XX", "x"=>".") * "\$") => Error,
    Regex("^" * replace("5XX", "x"=>".") * "\$") => Error,
)

function _oacinternal_estimate_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing)

    _ctx = OpenAPI.Clients.Ctx(_api.client, "GET", _returntypes_estimate_job_BatchJobsApi, "/jobs/{job_id}/estimate", ["Bearer", ])
    OpenAPI.Clients.set_param(_ctx.path, "job_id", job_id)  # type String
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? [] : [_mediaType])
    return _ctx
end

@doc raw"""Get an estimate for a batch job

Calculates an estimate for a batch job. Back-ends can decide to either calculate the duration, the costs, the size or a combination of them. Back-end providers MAY specify an expiry time for the estimate. Starting to process data afterwards MAY be charged at a higher cost. Costs do often not include download costs. Whether download costs are included or not can be indicated explicitly with the `downloads_included` flag. The estimate SHOULD be the upper limit of the costs, but back-end are free to use the field according to their terms of service. For some batch jobs it is not (easily) possible to estimate the costs reliably, e.g. if a UDF or ML model is part of the process. In this case, the server SHOULD return a `EstimateComplexity` error with HTTP status code 500.

Params:
- job_id::String (required)

Return: BatchJobEstimate, OpenAPI.Clients.ApiResponse
"""
function estimate_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing)
    _ctx = _oacinternal_estimate_job(_api, job_id; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function estimate_job(_api::BatchJobsApi, response_stream::Channel, job_id::String; _mediaType=nothing)
    _ctx = _oacinternal_estimate_job(_api, job_id; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

const _returntypes_list_jobs_BatchJobsApi = Dict{Regex,Type}(
    Regex("^" * replace("200", "x"=>".") * "\$") => BatchJobs,
    Regex("^" * replace("4XX", "x"=>".") * "\$") => Error,
    Regex("^" * replace("5XX", "x"=>".") * "\$") => Error,
)

function _oacinternal_list_jobs(_api::BatchJobsApi; limit=nothing, _mediaType=nothing)
    OpenAPI.validate_param("limit", "list_jobs", :minimum, limit, 1, false)

    _ctx = OpenAPI.Clients.Ctx(_api.client, "GET", _returntypes_list_jobs_BatchJobsApi, "/jobs", ["Bearer", ])
    OpenAPI.Clients.set_param(_ctx.query, "limit", limit)  # type Int64
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? [] : [_mediaType])
    return _ctx
end

@doc raw"""List all batch jobs

Lists all batch jobs submitted by a user.  It is **strongly RECOMMENDED** to keep the response size small by omitting all optional non-scalar values (i.e. arrays and objects) from objects in `jobs` (i.e. the `process` property). To get the full metadata for a job clients MUST request `GET /jobs/{job_id}`.

Params:
- limit::Int64

Return: BatchJobs, OpenAPI.Clients.ApiResponse
"""
function list_jobs(_api::BatchJobsApi; limit=nothing, _mediaType=nothing)
    _ctx = _oacinternal_list_jobs(_api; limit=limit, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function list_jobs(_api::BatchJobsApi, response_stream::Channel; limit=nothing, _mediaType=nothing)
    _ctx = _oacinternal_list_jobs(_api; limit=limit, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

const _returntypes_list_results_BatchJobsApi = Dict{Regex,Type}(
    Regex("^" * replace("200", "x"=>".") * "\$") => ListResults200Response,
    Regex("^" * replace("424", "x"=>".") * "\$") => LogEntry,
    Regex("^" * replace("4XX", "x"=>".") * "\$") => Error,
    Regex("^" * replace("5XX", "x"=>".") * "\$") => Error,
)

function _oacinternal_list_results(_api::BatchJobsApi, job_id::String; partial=nothing, _mediaType=nothing)

    _ctx = OpenAPI.Clients.Ctx(_api.client, "GET", _returntypes_list_results_BatchJobsApi, "/jobs/{job_id}/results", ["Bearer", ])
    OpenAPI.Clients.set_param(_ctx.path, "job_id", job_id)  # type String
    OpenAPI.Clients.set_param(_ctx.query, "partial", partial)  # type Bool
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", "application/geo+json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? [] : [_mediaType])
    return _ctx
end

@doc raw"""List batch job results

Lists signed URLs pointing to the processed files, usually after the batch job has finished. Back-ends may also point to intermediate results after the job has stopped due to an error or if the `partial` parameter has been set.  The response includes additional metadata. It is a valid [STAC Item](https://github.com/radiantearth/stac-spec/tree/v1.0.0/item-spec) (if it has spatial and temporal references included) or a valid [STAC Collection](https://github.com/radiantearth/stac-spec/tree/v1.0.0/collection-spec) (supported since openEO API version 1.1.0). The assets to download are in both cases available in the property `assets` and have the same structure. All additional metadata is not strictly required to download the files, but are helpful for users to understand the data.  STAC Collections can either (1) add all assets as collection-level assets or (2) link to STAC Catalogs and STAC Items with signed URLs, which will provide a full STAC catalog structure a client has to go through. Option 2 is overall the better  architectural choice and allows a fine-grained description of the processed data, but it is not compliant with previous versions of the openEO API. **To maintain backward compatibility, it is REQUIRED to still copy all assets in the STAC catalog structure into the collection-level assets.** This requirement is planned to be removed in openEO API version 2.0.0. A client can enforce that the server returns a GeoJSON through content negotiation with the media type `application/geo+json`, but the results may not contain very meaningful metadata aside from the assets.  Clients are RECOMMENDED to store this response and all potential sub-catalogs and items with the assets so that the downloaded data is then a self-contained STAC catalog user could publish easily with all the data and metadata.  URL signing is a way to protect files from unauthorized access with a key in the URL instead of HTTP header based authorization. The URL signing key is similar to a password and its inclusion in the URL allows to download files using simple GET requests supported by a wide range of programs, e.g. web browsers or download managers. Back-ends are responsible to generate the URL signing keys and to manage their appropriate expiration. The back-end MAY indicate an expiration time by setting the `expires` property in the reponse. Requesting this endpoint SHOULD always return non-expired URLs. Signed URLs that were generated for a previous request and already expired SHOULD NOT be reused, but regenerated with new expiration time. Signed URLs that expired MAY return the openEO error `ResultLinkExpired`.  It is **strongly recommended** to add a link with relation type `canonical` to the STAC Item or STAC Collection (see the `links` property for details).  If processing has not finished yet and the `partial` parameter is not set to `true` requests to this endpoint MUST be rejected with openEO error `JobNotFinished`.

Params:
- job_id::String (required)
- partial::Bool

Return: ListResults200Response, OpenAPI.Clients.ApiResponse
"""
function list_results(_api::BatchJobsApi, job_id::String; partial=nothing, _mediaType=nothing)
    _ctx = _oacinternal_list_results(_api, job_id; partial=partial, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function list_results(_api::BatchJobsApi, response_stream::Channel, job_id::String; partial=nothing, _mediaType=nothing)
    _ctx = _oacinternal_list_results(_api, job_id; partial=partial, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

const _returntypes_start_job_BatchJobsApi = Dict{Regex,Type}(
    Regex("^" * replace("202", "x"=>".") * "\$") => Nothing,
    Regex("^" * replace("4XX", "x"=>".") * "\$") => Error,
    Regex("^" * replace("5XX", "x"=>".") * "\$") => Error,
)

function _oacinternal_start_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing)

    _ctx = OpenAPI.Clients.Ctx(_api.client, "POST", _returntypes_start_job_BatchJobsApi, "/jobs/{job_id}/results", ["Bearer", ])
    OpenAPI.Clients.set_param(_ctx.path, "job_id", job_id)  # type String
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? [] : [_mediaType])
    return _ctx
end

@doc raw"""Start processing a batch job

Adds a batch job to the processing queue to compute the results.  The result will be stored in the format specified in the process. To specify the format use a process such as `save_result`.  The job status is set to `queued`, if processing doesn't start instantly. The same applies if the job status is `canceled`, `finished`, or `error`, which restarts the job and discards previous results if the back-end doesn't reject the request with an error. Clients SHOULD warn users and ask for confirmation if results may get discarded.  * Once the processing starts the status is set to `running`. * Once the data is available to download the status is set to `finished`. * Whenever an error occurs during processing, the status MUST be set to `error`.  This endpoint has no effect if the job status is already `queued` or `running`. In particular, it doesn't restart a running job. To restart a queued or running job, processing MUST have been canceled before.  Back-ends SHOULD reject queueing jobs with openEO error `PaymentRequired`, if the back-end is able to detect that the budget is too low to fully process the request. Alternatively, back-ends MAY provide partial results once reaching the budget. If none of the alternatives is feasible, the results are discarded. Thus, client SHOULD warn users that reaching the budget may lead to partial or no results at all.

Params:
- job_id::String (required)

Return: Nothing, OpenAPI.Clients.ApiResponse
"""
function start_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing)
    _ctx = _oacinternal_start_job(_api, job_id; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function start_job(_api::BatchJobsApi, response_stream::Channel, job_id::String; _mediaType=nothing)
    _ctx = _oacinternal_start_job(_api, job_id; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

const _returntypes_stop_job_BatchJobsApi = Dict{Regex,Type}(
    Regex("^" * replace("204", "x"=>".") * "\$") => Nothing,
    Regex("^" * replace("4XX", "x"=>".") * "\$") => Error,
    Regex("^" * replace("5XX", "x"=>".") * "\$") => Error,
)

function _oacinternal_stop_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing)

    _ctx = OpenAPI.Clients.Ctx(_api.client, "DELETE", _returntypes_stop_job_BatchJobsApi, "/jobs/{job_id}/results", ["Bearer", ])
    OpenAPI.Clients.set_param(_ctx.path, "job_id", job_id)  # type String
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? [] : [_mediaType])
    return _ctx
end

@doc raw"""Cancel processing a batch job

Cancels all related computations for this job at the back-end. It will stop generating additional costs for processing.  A subset of processed results may be available for downloading depending on the state of the job at the time it was canceled.  Results MUST NOT be deleted until the job processing is started again or the job is completely deleted through a request to `DELETE /jobs/{job_id}`.  This endpoint only has an effect if the job status is `queued` or `running`.  The job status is set to `canceled` if the status was `running` beforehand and partial or preliminary results are available to be downloaded. Otherwise the status is set to `created`. 

Params:
- job_id::String (required)

Return: Nothing, OpenAPI.Clients.ApiResponse
"""
function stop_job(_api::BatchJobsApi, job_id::String; _mediaType=nothing)
    _ctx = _oacinternal_stop_job(_api, job_id; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function stop_job(_api::BatchJobsApi, response_stream::Channel, job_id::String; _mediaType=nothing)
    _ctx = _oacinternal_stop_job(_api, job_id; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

const _returntypes_update_job_BatchJobsApi = Dict{Regex,Type}(
    Regex("^" * replace("204", "x"=>".") * "\$") => Nothing,
    Regex("^" * replace("4XX", "x"=>".") * "\$") => Error,
    Regex("^" * replace("5XX", "x"=>".") * "\$") => Error,
)

function _oacinternal_update_job(_api::BatchJobsApi, job_id::String, update_batch_job_request::UpdateBatchJobRequest; _mediaType=nothing)

    _ctx = OpenAPI.Clients.Ctx(_api.client, "PATCH", _returntypes_update_job_BatchJobsApi, "/jobs/{job_id}", ["Bearer", ], update_batch_job_request)
    OpenAPI.Clients.set_param(_ctx.path, "job_id", job_id)  # type String
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? ["application/json", ] : [_mediaType])
    return _ctx
end

@doc raw"""Modify a batch job

Modifies an existing job at the back-end, but maintains the identifier. Changes can be grouped in a single request.  The job status does not change.  Jobs can only be modified when the job is not queued and not running. Otherwise, requests to this endpoint MUST be rejected with openEO error `JobLocked`.

Params:
- job_id::String (required)
- update_batch_job_request::UpdateBatchJobRequest (required)

Return: Nothing, OpenAPI.Clients.ApiResponse
"""
function update_job(_api::BatchJobsApi, job_id::String, update_batch_job_request::UpdateBatchJobRequest; _mediaType=nothing)
    _ctx = _oacinternal_update_job(_api, job_id, update_batch_job_request; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function update_job(_api::BatchJobsApi, response_stream::Channel, job_id::String, update_batch_job_request::UpdateBatchJobRequest; _mediaType=nothing)
    _ctx = _oacinternal_update_job(_api, job_id, update_batch_job_request; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

export create_job
export debug_job
export delete_job
export describe_job
export estimate_job
export list_jobs
export list_results
export start_job
export stop_job
export update_job