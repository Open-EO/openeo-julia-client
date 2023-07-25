using HTTP
import StructTypes
import Base64: base64encode

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
    categories::Vector{String}
    parameters::Vector{ProcessParameter}
    returns::Any
    examples::Union{Nothing,Vector{Any}}
    links::Union{Nothing,Vector{Any}}
    exceptions::Any
    experimental::Union{Nothing,Bool}
end
StructTypes.StructType(::Type{Process}) = StructTypes.Struct()

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

struct ProcessNode <: AbstractProcessNode
    id::String
    process_id::String
    arguments::Dict{Symbol,Any}
    result::Bool
end
ProcessNode(id, process_id, arguments) = ProcessNode(id, process_id, arguments, false)

function ProcessNode(process_id::String, parameters)
    id = (process_id, parameters) |> repr |> objectid |> base64encode |> x -> process_id * "_" * x
    ProcessNode(id, process_id, parameters)
end

keywords = [
    "begin", "while", "if", "for", "try", "return", "break", "continue",
    "function", "macro", "quote", "let", "local", "global", "const", "do",
    "struct", "module", "baremodule", "using", "import", "export"
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
    println(io, "openEO ProcessNode $(p.id) with parameters:")
    pretty_print(io, p.arguments)
end

function get_parameters(parameters)
    # openEO type string to Julia type
    openeo_types = Dict(
        "string" => String,
        "boolean" => Bool,
        "number" => Number,
        "integer" => Integer,
        "object" => Any,
        "null" => Nothing,
        "array" => Vector,
        # subtypes
        "bounding-box" => BoundingBox,
        "raster-cube" => ProcessNode
    )

    res = [] # result must be ordered
    for p in parameters
        name = Symbol(p.name)
        # implement first method of function
        # TODO: Multiple dispatch on other methods
        schema = p.schema
        schema = typeof(schema) <: Vector ? schema[1] : schema

        if "subtype" in keys(schema) && schema["subtype"] in keys(openeo_types)
            openeo_type = schema["subtype"]
            # TODO: can be multiple return types
        elseif "type" in keys(schema) && schema["type"] in keys(openeo_types)
            openeo_type = schema["type"]
        else
            openeo_type = "object"
        end

        if typeof(openeo_type) <: Vector
            types = map(x -> openeo_types[x], openeo_type)
            type = eval(Meta.parse("Union{" * join(types, ",") * "}"))
        else
            type = openeo_types[openeo_type]
        end

        append!(res, [(name => type)])
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
            doc_str = join(docs, "\n\n")
            code = """
            \"\"\"
            $(doc_str)
            \"\"\"
            function $(process.id)$(process.id in keywords ? "_" : "")($args_str)
                ProcessNode("$(process.id)", Dict{Symbol, Any}(($args_dict_str)))
            end
            """
            append!(processes_codes, [code])
        catch e
            append!(warnings, [(process.id => e)])
        end
    end
    code = join(processes_codes, "\n")
    length(warnings) > 0 && @warn join(warnings, "\n")
    return code
end