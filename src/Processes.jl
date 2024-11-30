using HTTP
import StructTypes
import Base64: base64encode
import Markdown

struct ProcessParameter
    name::String
    description::String
    schema::Any
    default::Union{Nothing,Any}
    optional::Union{Nothing,Bool}
    deprecated::Union{Nothing,Bool}
    experimental::Union{Nothing,Bool}
end
StructTypes.StructType(::Type{ProcessParameter}) = StructTypes.Struct()

struct Process
    id::String
    summary::Union{Nothing,String}
    description::String
    categories::Union{Nothing,Vector{String}}
    parameters::Vector{ProcessParameter}
    returns::Any
    examples::Union{Nothing,Vector{Any}}
    links::Union{Nothing,Vector{Any}}
    exceptions::Any
    experimental::Union{Nothing,Bool}
end
StructTypes.StructType(::Type{Process}) = StructTypes.Struct()

function (process::Process)(args...; kwargs...)
    required_args = get_parameters(process.parameters, :required)

    length(required_args) == length(args) || error("Must provide $(length(required_args)) positional arguments")

    args_d = Dict{Symbol,Any}(zip(map(x -> x.first, required_args), args))
    merge!(args_d, Dict(kwargs))

    if isnothing(args_d)
        args_d = Dict{Symbol,Any}()
    end
    ProcessCall("$(process.id)", args_d)
end

function Docs.getdoc(process::Process)
    args_str = join(["$(k)::$(v)" for (k, v) in get_parameters(process.parameters, :required)], ", ")
    kwargs_str = join(["$(k)::$(v)" for (k, v) in get_parameters(process.parameters, :optional)], ", ")
    docs = """    $(process.id)($(args_str); $(kwargs_str))
    $(process.description)
    """
    Markdown.parse(docs)
end
Base.Docs.doc(p::Process, ::Type=Union{}) = Base.Docs.getdoc(p)

function Base.show(io::IO, ::MIME"text/plain", p::Process)
    args_str = join(["$(k)::$(v)" for (k, v) in get_parameters(p.parameters, :required)], ", ")
    kwargs_str = join(["$(k)::$(v)" for (k, v) in get_parameters(p.parameters, :optional)], ", ")
    print(io, "$(p.id)($(args_str); $(kwargs_str)): $(p.summary)")
end

# root e.g. https://earthengine.openeo.org/v1.0/processes
struct ProcessesRoot
    processes::Vector{Process}
    links::Vector{Any}
end

StructTypes.StructType(::Type{ProcessesRoot}) = StructTypes.Struct()

abstract type AbstractProcessCall end

struct ProcessCallReference <: AbstractProcessCall
    from_node::String
end

struct ProcessCallParameter <: AbstractProcessCall
    from_parameter::String
end

"""
Placeholder to define process graphs e.g. lambda functions
"""
const value = ProcessCallParameter("value")

mutable struct ProcessCall <: AbstractProcessCall
    const id::String
    const process_id::String
    const arguments::Dict{Symbol,Any}
    result::Bool
end
StructTypes.StructType(::Type{ProcessCall}) = StructTypes.Mutable()
StructTypes.excludes(::Type{ProcessCall}) = (:id,)

function ProcessCall(process_id::String, parameters; id_annotation::String="", result::Bool=false)
    id_hash = (process_id, parameters) |> repr |> objectid |> base64encode
    id = [process_id, id_annotation, id_hash] |> filter(!isempty) |> x -> join(x, "_")
    ProcessCall(id, process_id, parameters, result)
end

function pretty_print(io, d::AbstractDict, tabwidth=3)
    if length(d) == 0
        println(io, join(fill(" ", tabwidth)) * "No parameters specified.")
        return
    end

    max_pad = maximum([length(String(x)) for x in keys(d)]) + 1
    for (k, v) in d
        if typeof(v) <: AbstractDict
            s = "$(k): "
            println(io, join(fill(" ", tabwidth)) * s)
            pretty_print(io, v, tabwidth + tabwidth)
        else
            println(io, join(fill(" ", tabwidth)) * "$(rpad(String(k)*":", max_pad)) $(repr(v))")
        end
    end
    return nothing
end


function Base.show(io::IO, ::MIME"text/plain", p::ProcessCall)
    println(io, "openEO ProcessCall $(p.id)")
    pretty_print(io, p.arguments)
    pretty_print(io, Dict(:result => p.result))
end

function get_parameters(parameters, keep=:all)
    # openEO type string to Julia type
    julia_types_map = Dict(
        "string" => String,
        "boolean" => Bool,
        "number" => Number,
        "integer" => Integer,
        "object" => Any,
        "null" => Nothing,
        "array" => Vector,
        # subtypes
        "bounding-box" => BoundingBox,
        "raster-cube" => ProcessCall,
        "process-graph" => ProcessGraph
    )

    res = [] # result must be ordered
    for p in parameters
        name = Symbol(p.name)
        schemata = p.schema isa Vector ? p.schema : [p.schema]
        types = []
        for s in schemata
            if "subtype" in keys(s) && s["subtype"] in keys(julia_types_map)
                push!(types, s["subtype"])
            elseif "type" in keys(s)
                push!(types, s["type"])
            else
                push!(types, "object")
            end
        end
        julia_types = [get(julia_types_map, t, String) for t in types]
        julia_type = Union{julia_types...}

        if keep == :all || (keep == :optional && p.optional == true) || (keep == :required && isnothing(p.optional))
            push!(res, name => julia_type)
        end
    end
    return res
end

print_json(c::ProcessCall) = c |> JSON3.write |> JSON3.pretty
