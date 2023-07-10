# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""Process_Graph

    ProcessGraph(;
        process_id=nothing,
        namespace=nothing,
        result=false,
        description=nothing,
        arguments=nothing,
    )

    - process_id::String : The identifier for the process. It MUST be unique across its namespace (e.g. predefined processes or user-defined processes).  Clients SHOULD warn the user if a user-defined process is added with the  same identifier as one of the predefined process.
    - namespace::String : The namespace the &#x60;process_id&#x60; is valid for.  The following options are predefined by the openEO API, but additional namespaces may be introduced by back-ends or in a future version of the API.  * &#x60;null&#x60; (default): Checks both user-defined and predefined processes,    but prefers user-defined processes if both are available.    This allows users to add missing predefined processes for portability,    e.g. common processes from [processes.openeo.org](https://processes.openeo.org)    that have a process graph included.    It is RECOMMENDED to log the namespace selected by the back-end for debugging purposes. * &#x60;backend&#x60;: Uses exclusively the predefined processes listed at &#x60;GET /processes&#x60;. * &#x60;user&#x60;: Uses exclusively the user-defined processes listed at &#x60;GET /process_graphs&#x60;.  If multiple processes with the same identifier exist, Clients SHOULD inform the user that it&#39;s recommended to select a namespace.
    - result::Bool : Used to specify which node is the last in the chain and returns the result to return to the requesting context. This flag MUST only be set once in each list of process nodes.
    - description::String : Optional description about the process and its arguments.
    - arguments::Dict{String, ProcessArgumentValue}
"""
Base.@kwdef mutable struct ProcessGraph <: OpenAPI.APIModel
    process_id::Union{Nothing, String} = nothing
    namespace::Union{Nothing, String} = nothing
    result::Union{Nothing, Bool} = false
    description::Union{Nothing, String} = nothing
    arguments::Union{Nothing, Dict} = nothing # spec type: Union{ Nothing, Dict{String, ProcessArgumentValue} }

    function ProcessGraph(process_id, namespace, result, description, arguments, )
        OpenAPI.validate_property(ProcessGraph, Symbol("process_id"), process_id)
        OpenAPI.validate_property(ProcessGraph, Symbol("namespace"), namespace)
        OpenAPI.validate_property(ProcessGraph, Symbol("result"), result)
        OpenAPI.validate_property(ProcessGraph, Symbol("description"), description)
        OpenAPI.validate_property(ProcessGraph, Symbol("arguments"), arguments)
        return new(process_id, namespace, result, description, arguments, )
    end
end # type ProcessGraph

const _property_types_ProcessGraph = Dict{Symbol,String}(Symbol("process_id")=>"String", Symbol("namespace")=>"String", Symbol("result")=>"Bool", Symbol("description")=>"String", Symbol("arguments")=>"Dict{String, ProcessArgumentValue}", )
OpenAPI.property_type(::Type{ ProcessGraph }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_ProcessGraph[name]))}

function check_required(o::ProcessGraph)
    o.process_id === nothing && (return false)
    o.arguments === nothing && (return false)
    true
end

function OpenAPI.validate_property(::Type{ ProcessGraph }, name::Symbol, val)
    if name === Symbol("process_id")
        OpenAPI.validate_param(name, "ProcessGraph", :pattern, val, r"^\w+$")
    end
end