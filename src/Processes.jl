using HTTP

struct Process
    id::String
    parameters
end

function pretty_print(io, d::Dict, tabwidth=3)
    d = Dict([String(k) => v for (k, v) in d]) # length of symbol is undefined

    if length(d) == 0
        println(io, join(fill(" ", tabwidth)) * "No parameters specified.")
        return
    end

    max_pad = maximum([length(x) for x in keys(d)]) + 1
    for (k, v) in d
        if typeof(v) <: Dict
            s = "$(k): "
            println(io, join(fill(" ", tabwidth)) * s)
            pretty_print(io, v, tabwidth + tabwidth)
        else
            println(io, join(fill(" ", tabwidth)) * "$(rpad(k*":", max_pad)) $(repr(v))")
        end
    end
    return nothing
end

function Base.show(io::IO, ::MIME"text/plain", p::Process)
    println(io, "openEO Process $(p.id) with parameters:")
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
        name = Symbol(p["name"])
        # implement first method of function
        # TODO: Multiple dispatch on other methods
        schema = p["schema"]
        schema = typeof(schema) <: Vector ? schema[1] : schema

        if "subtype" in keys(schema)
            openeo_type = schema["subtype"] in keys(openeo_types) ? schema["subtype"] : schema["type"]
        else
            openeo_type = schema["type"]
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

function get_process_function(process_specs::Dict)
    parameters = get_parameters(process_specs["parameters"])
    args_str = join(["$(k)::$(v)" for (k, v) in parameters], ", ")
    args_dict_str = join([":$k=>$k" for (k, v) in parameters], ", ")
    docs = [
        "    $(process_specs["id"])($(args_str)) -> Process",
        process_specs["description"]
    ]
    doc_str = join(docs, "\n\n")
    code = """
    \"\"\"
    $(doc_str)
    \"\"\"
    function $(process_specs["id"])($args_str)
        Process("$(process_specs["id"])", Dict(($args_dict_str)))
    end
    """
    return code
end

function register_processes(connection::AbstractConnection)
    processes = list_processes(connection)
    processes_codes = []
    warnings = []
    for process_spec in processes
        try
            code = get_process_function(process_spec)
            append!(processes_codes, [code])
        catch e
            append!(warnings, [(process_spec["id"] => e)])
        end
    end

    length(warnings) > 0 && @warn "Parsing of $(length(warnings)) processes failed:\n" * join(warnings, "\n")

    # wrap into a new module to avoid namespace issues
    codes = append!(["module Processes", "import ..OpenEOClient: Process"], processes_codes, ["end"])
    code = join(codes, "\n")
    eval(Meta.parse(code))
end