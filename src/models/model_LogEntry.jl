# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""log_entry
An log message that communicates information about the processed data.

    LogEntry(;
        id=nothing,
        code=nothing,
        level=nothing,
        message=nothing,
        time=nothing,
        data=nothing,
        path=nothing,
        usage=nothing,
        links=nothing,
    )

    - id::String : An unique identifier for the log message, could simply be an incrementing number.
    - code::String : The code is either one of the standardized error codes or a custom code, for example specified by a user in the &#x60;inspect&#x60; process.
    - level::LogLevel
    - message::String : A concise message explaining the log entry. Messages do *not* explicitly support [CommonMark 0.29](http://commonmark.org/) syntax as other descriptive fields in the openEO API do, but the messages MAY contain line breaks or indentation. It is NOT RECOMMENDED to add stacktraces to the &#x60;message&#x60;.
    - time::ZonedDateTime : The date and time the event happened, in UTC. Formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time.
    - data::Any : Data of any type. It is the back-ends task to decide how to best present passed data to a user.  For example, a datacube passed to the &#x60;inspect&#x60; SHOULD return the metadata similar to the collection metadata, including &#x60;cube:dimensions&#x60;. There are implementation guidelines available for the &#x60;inspect&#x60; process.
    - path::Vector{LogEntryPathInner} : Describes where the log entry originates from.  The first element of the array is the process that has triggered the log entry, the second element is the parent of the process that has triggered the log entry, etc. This pattern is followed until the root of the process graph.
    - usage::Usage
    - links::Vector{Link} : Links related to this log entry / error, e.g. to a resource that provides further explanations.  For relation types see the lists of [common relation types in openEO](#section/API-Principles/Web-Linking).
"""
Base.@kwdef mutable struct LogEntry <: OpenAPI.APIModel
    id::Union{Nothing, String} = nothing
    code::Union{Nothing, String} = nothing
    level = nothing # spec type: Union{ Nothing, LogLevel }
    message::Union{Nothing, String} = nothing
    time::Union{Nothing, ZonedDateTime} = nothing
    data::Union{Nothing, Any} = nothing
    path::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{LogEntryPathInner} }
    usage = nothing # spec type: Union{ Nothing, Usage }
    links::Union{Nothing, Vector} = nothing # spec type: Union{ Nothing, Vector{Link} }

    function LogEntry(id, code, level, message, time, data, path, usage, links, )
        OpenAPI.validate_property(LogEntry, Symbol("id"), id)
        OpenAPI.validate_property(LogEntry, Symbol("code"), code)
        OpenAPI.validate_property(LogEntry, Symbol("level"), level)
        OpenAPI.validate_property(LogEntry, Symbol("message"), message)
        OpenAPI.validate_property(LogEntry, Symbol("time"), time)
        OpenAPI.validate_property(LogEntry, Symbol("data"), data)
        OpenAPI.validate_property(LogEntry, Symbol("path"), path)
        OpenAPI.validate_property(LogEntry, Symbol("usage"), usage)
        OpenAPI.validate_property(LogEntry, Symbol("links"), links)
        return new(id, code, level, message, time, data, path, usage, links, )
    end
end # type LogEntry

const _property_types_LogEntry = Dict{Symbol,String}(Symbol("id")=>"String", Symbol("code")=>"String", Symbol("level")=>"LogLevel", Symbol("message")=>"String", Symbol("time")=>"ZonedDateTime", Symbol("data")=>"Any", Symbol("path")=>"Vector{LogEntryPathInner}", Symbol("usage")=>"Usage", Symbol("links")=>"Vector{Link}", )
OpenAPI.property_type(::Type{ LogEntry }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_LogEntry[name]))}

function check_required(o::LogEntry)
    o.id === nothing && (return false)
    o.level === nothing && (return false)
    o.message === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ LogEntry }, name::Symbol, val)
    if name === Symbol("time")
        OpenAPI.validate_param(name, "LogEntry", :format, val, "date-time")
    end
end
