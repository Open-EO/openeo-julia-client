get_id(p::ProcessCall) = Symbol("$(p.id)-$(p |> repr |> objectid |> base64encode)")

"""
Process and download data synchronously
"""
function compute_result(connection::AbstractConnection, process_call::ProcessCall, filepath::String="", kw...)
    step2 = deepcopy(process_call)
    step1 = step2.parameters[:data]
    step2.parameters[:data] = Dict(:from_node => get_id(step1))

    query = Dict(
        :process => Dict(
            :process_graph => Dict(
                get_id(step1) => Dict(
                    :process_id => step1.id,
                    :arguments => step1.parameters
                ),
                get_id(step2) => Dict(
                    :process_id => step2.id,
                    :arguments => step2.parameters,
                    :result => true
                )
            )
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