using HTTP

struct ProcessCall
    id::String
    parameters
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

    max_pad = maximum([length(x) for x in keys(d)]) + 1
    for (k, v) in d
        if typeof(v) <: AbstractDict
            s = "$(k): "
            println(io, join(fill(" ", tabwidth)) * s)
            pretty_print(io, v, tabwidth + tabwidth)
        else
            println(io, join(fill(" ", tabwidth)) * "$(rpad(k*":", max_pad)) $(repr(v))")
        end
    end
    return nothing
end

function Base.show(io::IO, ::MIME"text/plain", p::ProcessCall)
    println(io, "openEO ProcessCall $(p.id) with parameters:")
    pretty_print(io, p.parameters)
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
        "bounding-box" => NTuple{4,<:Number}
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

function get_process_function(process_specs)
    parameters = get_parameters(process_specs.parameters)
    args_str = join(["$(k)::$(v)" for (k, v) in parameters], ", ")
    args_dict_str = join([":$k=>$k" for (k, v) in parameters], ", ")
    docs = [
        "    $(process_specs.id)($(args_str)) -> Process",
        process_specs.description
    ]
    doc_str = join(docs, "\n\n")
    code = """
    \"\"\"
    $(doc_str)
    \"\"\"
    function $(process_specs.id)$(process_specs.id in keywords ? "_" : "")($args_str)
        ProcessCall("$(process_specs.id)", Dict(($args_dict_str)))
    end
    """
    return code
end

function get_processes_code(host, version)
    connection = UnAuthorizedConnection(host, version)
    processes = list_processes(connection)
    processes_codes = []
    warnings = []
    for process in processes
        try
            code = get_process_function(process)
            append!(processes_codes, [code])
        catch e
            append!(warnings, [(process.id => e)])
        end
    end
    code = join(processes_codes, "\n")
    return code
end