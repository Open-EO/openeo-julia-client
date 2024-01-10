using OrderedCollections

function flatten!(g::AbstractProcessCall, root_id, nodes=OrderedSet{ProcessCall}())
    has_parameter = x -> ProcessCallParameter in typeof.(values(x.arguments))
    arguments_nodes = filter(((k, v),) -> v isa ProcessCall && !has_parameter(v), g.arguments)

    # post order tree traversal
    for (key, child) in arguments_nodes
        flatten!(child, root_id, nodes)
        g.arguments[key] = ProcessCallReference(child.id)
    end

    union!(nodes, OrderedSet([v for (k, v) in arguments_nodes]))

    if g.id == root_id
        push!(nodes, g)
        return nodes
    end
end

mutable struct ProcessGraph
    process_graph::OrderedSet{ProcessCall}
end

StructTypes.StructType(::Type{ProcessGraph}) = StructTypes.CustomStruct()
function StructTypes.lower(g::ProcessGraph)
    res = OrderedDict()
    for s in g.process_graph
        res[s.id] = s
    end
    return Dict(:process_graph => res)
end
Base.getindex(g::ProcessGraph, i...) = g.process_graph[i...]

function Base.show(io::IO, ::MIME"text/plain", g::ProcessGraph)
    println(io, "openEO ProcessGraph with $(length(g)) steps:")
    for step in g.process_graph
        args = join(values(step.arguments), ", ")
        println(io, "   $(step.process_id)($(args))")
    end
end

function ProcessGraph(process_node::ProcessCall)
    g = deepcopy(process_node)
    g.result = true
    root_id = process_node.id
    processes = flatten!(g, root_id)
    return ProcessGraph(processes)
end

Base.getindex(g::ProcessGraph, i) = Base.getindex(g.process_graph, i)
Base.length(g::ProcessGraph) = Base.length(g.process_graph)
print_json(g::ProcessGraph) = g |> JSON3.write |> JSON3.pretty

"""
Create a ProcessGraph to reduce dimesnions
"""
function ProcessGraph(process::String="mean")
    p = ProcessCall(process, Dict(:data => Dict(:from_parameter => "data")); result=true)
    return ProcessGraph(OrderedSet([p]))
end

"""
Process and download data synchronously
"""
function compute_result(connection::AuthorizedConnection, process_graph::Union{ProcessGraph,Dict}, filepath::String="", kw...)
    query = Dict(
        :process => process_graph
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
    open(filepath, "w") do f
        write(f, response.body)
    end
    return filepath
end

function compute_result(connection::AuthorizedConnection, process_node::ProcessCall, kw...)
    process_graph = ProcessGraph(process_node)
    return compute_result(connection, process_graph, kw...)
end

function compute_result(connection::AuthorizedConnection, json_graph_path::String, kw...)
    process_graph = JSON3.read(json_graph_path) |> Dict
    return compute_result(connection, process_graph, kw...)
end