using OrderedCollections

function flatten!(g::AbstractProcessNode, root_id, nodes=OrderedSet{ProcessNode}())
    arguments_nodes = filter(((k, v),) -> v isa ProcessNode, g.arguments)

    # post order tree traversal
    for (key, child) in arguments_nodes
        flatten!(child, root_id, nodes)
        g.arguments[key] = ProcessNodeReference(child.id)
    end

    union!(nodes, OrderedSet([v for (k, v) in arguments_nodes]))

    if g.id == root_id
        push!(nodes, g)
        return nodes
    end
end

abstract type AbstractProcessGraph end

mutable struct ProcessGraph <: AbstractProcessGraph
    data::OrderedSet{ProcessNode}
end

StructTypes.StructType(::Type{ProcessGraph}) = StructTypes.CustomStruct()
StructTypes.lower(g::ProcessGraph) = [Symbol(x.id) => x for x in g.data] |> OrderedDict
Base.getindex(g::ProcessGraph, i...) = g.data[i...]

function Base.show(io::IO, ::MIME"text/plain", g::ProcessGraph)
    println(io, "openEO ProcessGraph with $(length(g)) steps:")
    for step in g.data
        args = join(values(step.arguments), ", ")
        println(io, "   $(step.process_id)($(args))")
    end
end

function ProcessGraph(process_call::ProcessNode)
    g = deepcopy(process_call)
    g.result = true
    root_id = process_call.id
    processes = flatten!(g, root_id)
    return ProcessGraph(processes)
end

Base.getindex(g::ProcessGraph, i) = Base.getindex(g.data, i)
Base.length(g::ProcessGraph) = Base.length(g.data)

struct Reducer <: AbstractProcessGraph
    process_graph::OrderedDict
end

"""
Create a ProcessGraph to reduce dimesnions
"""
function Reducer(process::String="mean")
    process_graph = Dict(
        :reduce1 => ProcessNode(
            "reduce1", process, Dict(:data => Dict(:from_parameter => "data")), true
        )
    )
    return Reducer(process_graph)
end

"""
Process and download data synchronously
"""
function compute_result(connection::AuthorizedConnection, process_graph::ProcessGraph, filepath::String="", kw...)
    query = Dict(
        :process => Dict(
            :process_graph => process_graph,
            :parameters => []
        )
    )

    headers = [
        "Accept" => "*",
        "Content-Type" => "application/json"
    ]

    response = fetchApi(connection, "result"; method="POST", headers=headers, body=JSON3.write(query))
    response isa Exception ? throw(response) : true

    if isempty(filepath)
        file_extension = split(Dict(response.headers)["Content-Type"], "/")[2]
        filepath = "out." * file_extension
    end

    write(open(filepath, "w"), response.body)
    return filepath
end

function compute_result(connection::AuthorizedConnection, process_node::ProcessNode, kw...)
    process_graph = ProcessGraph(process_node)
    return compute_result(connection, process_graph, kw...)
end