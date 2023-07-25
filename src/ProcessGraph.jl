using OrderedCollections

function flatten!(g::AbstractProcessNode, root_id, nodes=Vector{ProcessNode}())
    processes = filter(((k, v),) -> v isa ProcessNode, g.arguments)

    # post order tree traversal
    for (key, child) in processes
        flatten!(child, root_id, nodes)
        g.arguments[key] = ProcessNodeReference(child.id)
    end

    append!(nodes, [v for (k, v) in processes])

    if g.id == root_id
        return vcat(nodes, [g])
    end
end

mutable struct ProcessGraph
    data::OrderedDict
end

function Base.show(io::IO, ::MIME"text/plain", g::ProcessGraph)
    println(io, "openEO ProcessGraph with steps:")
    for (id, step) in enumerate(values(g.data))
        args = join(values(step.arguments), ", ")
        println(io, "   $(id):\t $(step.process_id)($(args))")
    end
end

function ProcessGraph(process_call::ProcessNode)
    g = deepcopy(process_call)
    root_id = process_call.id
    processes = flatten!(g, root_id)

    res = OrderedDict()
    for p in processes
        id = p.id
        delete!(res, id)
        res[p.id] = p
    end

    # set last node as result
    l = last(res).second
    l = ProcessNode(l.id, l.process_id, l.arguments, true)
    res[l.id] = l

    return ProcessGraph(res)
end

function Base.getindex(g::ProcessGraph, i)
    id = g.data.keys[i]
    return Base.getindex(g.data, id)
end


"""
Process and download data synchronously
"""
function compute_result(connection::AuthorizedConnection, process_graph::ProcessGraph, filepath::String="", kw...)
    query = Dict(
        :process => Dict(
            :process_graph => process_graph.data,
            :parameters => []
        )
    )

    headers = [
        "Accept" => "*",
        "Content-Type" => "application/json"
    ]

    response = fetchApi(connection, "result"; method="POST", headers=headers, body=JSON3.write(query))

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