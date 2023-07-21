"""
Process and download data synchronously
"""
function compute_result(connection::AbstractConnection, step2::ProcessCall, kw...)
    step1 = step2.parameters[:data]
    step2.parameters[:data] = Dict(:from_node => Symbol(step1))

    query = Dict(
        :process => Dict(
            :process_graph => Dict(
                Symbol(step1) => Dict(
                    :process_id => step1.id,
                    :arguments => step1.parameters
                ),
                Symbol(step2) => Dict(
                    :process_id => step2.id,
                    :arguments => step2.parameters,
                    :result => true
                )
            )
        )
    )

    @info query |> JSON3.write |> JSON3.read |> JSON3.pretty

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