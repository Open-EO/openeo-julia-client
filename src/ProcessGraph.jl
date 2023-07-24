using OrderedCollections

using Infiltrator

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

function get_process_graph(process_call::ProcessNode)
    g = deepcopy(process_call)
    root_id = process_call.id
    processes = flatten!(g, root_id)

    res = OrderedDict()
    for p in processes
        id = p.id
        delete!(res, id)
        res[p.id] = p
    end

    l = last(res).second
    l = ProcessNode(l.id, l.process_id, l.arguments, true)
    res[l.id] = l

    return res
end


"""
Process and download data synchronously
"""
function compute_result(connection::AbstractConnection, process_call::ProcessNode, filepath::String="", kw...)
    query = Dict(
        :process => Dict(
            :process_graph => get_process_graph(process_call),
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


