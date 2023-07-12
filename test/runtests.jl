using OpenEOClient
using Test
using JSON

host = ENV["OPENEO_HOST"]
version = ENV["OPENEO_VERSION"]
username = ENV["OPENEO_USERNAME"]
password = ENV["OPENEO_PASSWORD"]

@testset "OpenEOClient.jl" begin
    con = connect(host, version)

    auth_con = connect(host, username, password, version)
    @test length(auth_con.access_token) > 0

    processes1 = list_processes(con)
    processes2 = list_processes(auth_con)
    @test size(processes1) == size(processes2)

    collections1 = list_collections(con)
    collections2 = list_collections(auth_con)
    @test size(collections1) == size(collections2)

    collection = describe_collection(auth_con, "COPERNICUS/S2")
    @test length(collection) == 17

    process_graph = JSON.parsefile("sentinel2-time-min.json")
    result = save_result(auth_con, process_graph)
    @test length(result.body) == 136148
end
