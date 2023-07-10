# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.

struct ProcessDiscoveryApi <: OpenAPI.APIClientImpl
    client::OpenAPI.Clients.Client
end

"""
The default API base path for APIs in `ProcessDiscoveryApi`.
This can be used to construct the `OpenAPI.Clients.Client` instance.
"""
basepath(::Type{ ProcessDiscoveryApi }) = "https://openeo.example/api/v1"

const _returntypes_describe_custom_process_ProcessDiscoveryApi = Dict{Regex,Type}(
    Regex("^" * replace("200", "x"=>".") * "\$") => UserDefinedProcess,
    Regex("^" * replace("4XX", "x"=>".") * "\$") => Error,
    Regex("^" * replace("5XX", "x"=>".") * "\$") => Error,
)

function _oacinternal_describe_custom_process(_api::ProcessDiscoveryApi, process_graph_id::String; _mediaType=nothing)

    _ctx = OpenAPI.Clients.Ctx(_api.client, "GET", _returntypes_describe_custom_process_ProcessDiscoveryApi, "/process_graphs/{process_graph_id}", ["Bearer", ])
    OpenAPI.Clients.set_param(_ctx.path, "process_graph_id", process_graph_id)  # type String
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? [] : [_mediaType])
    return _ctx
end

@doc raw"""Full metadata for a user-defined process

Lists all information about a user-defined process, including its process graph.

Params:
- process_graph_id::String (required)

Return: UserDefinedProcess, OpenAPI.Clients.ApiResponse
"""
function describe_custom_process(_api::ProcessDiscoveryApi, process_graph_id::String; _mediaType=nothing)
    _ctx = _oacinternal_describe_custom_process(_api, process_graph_id; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function describe_custom_process(_api::ProcessDiscoveryApi, response_stream::Channel, process_graph_id::String; _mediaType=nothing)
    _ctx = _oacinternal_describe_custom_process(_api, process_graph_id; _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

const _returntypes_list_custom_processes_ProcessDiscoveryApi = Dict{Regex,Type}(
    Regex("^" * replace("200", "x"=>".") * "\$") => UserDefinedProcesses,
    Regex("^" * replace("4XX", "x"=>".") * "\$") => Error,
    Regex("^" * replace("5XX", "x"=>".") * "\$") => Error,
)

function _oacinternal_list_custom_processes(_api::ProcessDiscoveryApi; limit=nothing, _mediaType=nothing)
    OpenAPI.validate_param("limit", "list_custom_processes", :minimum, limit, 1, false)

    _ctx = OpenAPI.Clients.Ctx(_api.client, "GET", _returntypes_list_custom_processes_ProcessDiscoveryApi, "/process_graphs", ["Bearer", ])
    OpenAPI.Clients.set_param(_ctx.query, "limit", limit)  # type Int64
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? [] : [_mediaType])
    return _ctx
end

@doc raw"""List all user-defined processes

Lists all user-defined processes (process graphs) of the authenticated user that are stored at the back-end.  It is **strongly RECOMMENDED** to keep the response size small by omitting larger optional values from the objects in `processes` (e.g. the `exceptions`, `examples` and `links` properties). To get the full metadata for a user-defined process clients MUST request `GET /process_graphs/{process_graph_id}`.

Params:
- limit::Int64

Return: UserDefinedProcesses, OpenAPI.Clients.ApiResponse
"""
function list_custom_processes(_api::ProcessDiscoveryApi; limit=nothing, _mediaType=nothing)
    _ctx = _oacinternal_list_custom_processes(_api; limit=limit, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function list_custom_processes(_api::ProcessDiscoveryApi, response_stream::Channel; limit=nothing, _mediaType=nothing)
    _ctx = _oacinternal_list_custom_processes(_api; limit=limit, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

const _returntypes_list_processes_ProcessDiscoveryApi = Dict{Regex,Type}(
    Regex("^" * replace("200", "x"=>".") * "\$") => Processes,
    Regex("^" * replace("4XX", "x"=>".") * "\$") => Error,
    Regex("^" * replace("5XX", "x"=>".") * "\$") => Error,
)

function _oacinternal_list_processes(_api::ProcessDiscoveryApi; limit=nothing, _mediaType=nothing)
    OpenAPI.validate_param("limit", "list_processes", :minimum, limit, 1, false)

    _ctx = OpenAPI.Clients.Ctx(_api.client, "GET", _returntypes_list_processes_ProcessDiscoveryApi, "/processes", ["Bearer", ])
    OpenAPI.Clients.set_param(_ctx.query, "limit", limit)  # type Int64
    OpenAPI.Clients.set_header_accept(_ctx, ["application/json", ])
    OpenAPI.Clients.set_header_content_type(_ctx, (_mediaType === nothing) ? [] : [_mediaType])
    return _ctx
end

@doc raw"""Supported predefined processes

Lists all predefined processes and returns detailed process descriptions, including parameters and return values.

Params:
- limit::Int64

Return: Processes, OpenAPI.Clients.ApiResponse
"""
function list_processes(_api::ProcessDiscoveryApi; limit=nothing, _mediaType=nothing)
    _ctx = _oacinternal_list_processes(_api; limit=limit, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx)
end

function list_processes(_api::ProcessDiscoveryApi, response_stream::Channel; limit=nothing, _mediaType=nothing)
    _ctx = _oacinternal_list_processes(_api; limit=limit, _mediaType=_mediaType)
    return OpenAPI.Clients.exec(_ctx, response_stream)
end

export describe_custom_process
export list_custom_processes
export list_processes