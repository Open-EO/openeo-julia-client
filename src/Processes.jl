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
function (process::Process)(args...)
    params = get_parameters(process.parameters)
    length(args) == length(params) || throw(ArgumentError("Number of arguments does not match for process $(process.id)"))
    argument_dict = Dict{Symbol,Any}()
    for i in 1:length(args)
        argname,argtype = params[i]
        args[i] isa argtype || throw(ArgumentError("Type of argument number $i does not match, expected $argtype but got $(typeof(args[i]))"))
        argument_dict[argname] = args[i]
    end
    ProcessNode("$(process.id)", argument_dict)
end
function Docs.getdoc(process::Process)
    arguments = get_parameters(process.parameters)
    args_str = join(["$(k)::$(v)" for (k, v) in arguments], ", ")
    docs = """    $(process.id)($(args_str))
    $(process.description)
    """
    Markdown.parse(docs)
end
Base.Docs.doc(p::Process, ::Type = Union{}) = Base.Docs.getdoc(p)

function Base.show(io::IO, ::MIME"text/plain", p::Process)
    print(io, "$(p.id)($(join([x.name for x in p.parameters], ", "))): $(p.summary)")
end

# root e.g. https://earthengine.openeo.org/v1.0/processes
struct ProcessesRoot
    processes::Vector{Process}
    links::Vector{Any}
end

StructTypes.StructType(::Type{ProcessesRoot}) = StructTypes.Struct()

abstract type AbstractProcessNode end

struct ProcessNodeReference <: AbstractProcessNode
    from_node::String
end

struct ProcessNodeParameter <: AbstractProcessNode
    from_parameter::String
end

mutable struct ProcessNode <: AbstractProcessNode
    const id::String
    const process_id::String
    const arguments::Dict{Symbol,Any}
    result::Bool
end
ProcessNode(id, process_id, arguments) = ProcessNode(id, process_id, arguments, false)
StructTypes.StructType(::Type{ProcessNode}) = StructTypes.Mutable()
StructTypes.excludes(::Type{ProcessNode}) = (:id,)

function ProcessNode(process_id::String, parameters; id_annotation::String="", result::Bool=false)
    id_hash = (process_id, parameters) |> repr |> objectid |> base64encode
    id = [process_id, id_annotation, id_hash] |> filter(!isempty) |> x -> join(x, "_")
    ProcessNode(id, process_id, parameters, result)
end

# to transpile julia method calls to openEO process graphs
function ProcessNode(e::Expr, lowered::Core.CodeInfo; result::Bool=false)
    arguments = Dict(
        :data => Dict(:from_parameter => "data"),
        :index => e.args[2].args[3]
    )
    slot = e.args[1] |> Symbol |> String |> x -> x[2:end] |> x -> parse(Int64, x)
    id_annotation = String(lowered.slotnames[slot])
    p = ProcessNode("array_element", arguments; id_annotation=id_annotation, result=result)
    return p
end

keywords = [
    # julia keywords
    "begin", "while", "if", "for", "try", "return", "break", "continue",
    "function", "macro", "quote", "let", "local", "global", "const", "do",
    "struct", "module", "baremodule", "using", "import", "export",

    # module symbols
    "collections", "connection", "compute_result"
]

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


function Base.show(io::IO, ::MIME"text/plain", p::ProcessNode)
    println(io, "openEO ProcessNode $(p.id)")
    pretty_print(io, p.arguments)
    pretty_print(io, Dict(:result => p.result))
end

function get_parameters(parameters)
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
        "raster-cube" => ProcessNode,
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
        julia_type = eval(Meta.parse("Union{" * join(julia_types, ",") * "}"))

        push!(res, name => julia_type)
    end
    return res
end

function get_processes_code(host, version)
    connection = UnAuthorizedConnection(host, version)
    processes = list_processes(connection)
    processes_codes = []
    warnings = []
    for process in processes
        try
            arguments = get_parameters(process.parameters)
            args_str = join(["$(k)::$(v)" for (k, v) in arguments], ", ")
            args_dict_str = join([":$k=>$k" for (k, v) in arguments], ", ")
            docs = [
                "    $(process.id)($(args_str))",
                process.description
            ]
            doc_str = join(docs, "\n\n") |> escape_string

            code = """
            \"\"\"
            $(doc_str)
            \"\"\"
            function $(process.id)$(process.id in keywords ? "_" : "")($args_str)
                ProcessNode("$(process.id)", Dict{Symbol, Any}(($args_dict_str)))
            end
            """

            if Meta.parse(code).head != :incomplete
                append!(processes_codes, [code])
            else
                println(code)
            end

        catch e
            append!(warnings, [(process.id => e)])
        end
    end
    code = join(processes_codes, "\n")
    length(warnings) > 0 && @warn join(vcat(["Ignore processes with errors"], warnings), "\n")
    return code
end