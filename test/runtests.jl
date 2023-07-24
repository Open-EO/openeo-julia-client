using OpenEOClient
using Test

host = ENV["OPENEO_HOST"]
version = ENV["OPENEO_VERSION"]
username = ENV["OPENEO_USERNAME"]
password = ENV["OPENEO_PASSWORD"]

@testset "OpenEOClient.jl" begin
    unauth_con = OpenEOClient.UnAuthorizedConnection(host, version)
    response = OpenEOClient.fetchApi(unauth_con, "/")
    @test "api_version" in keys(response)
    @test "backend_version" in keys(response)

    list_processes(unauth_con)
    list_collections(unauth_con)

    c1 = connect(host, version)
    c2 = connect(host, version, username, password)
    @test allequal([c1, c2] .|> x -> size(x.collections))
    @test allequal([c1, c2] .|> x -> names(x, all=true) |> length)

    step1 = c2.load_collection(
        "COPERNICUS/S2", BoundingBox(west=16.06, south=48.06, east=16.65, north=48.35),
        ["2020-01-20", "2020-01-30"], ["B10"]
    )
    @test step1.id == "load_collection_tQ79zrFEGi8="
    @test step1.process_id == "load_collection"
    @test Set(keys(step1.arguments)) == Set([:bands, :id, :spatial_extent, :temporal_extent])
    @test step1.arguments[:bands] == ["B10"]

    step2 = c.save_result(step1, "GTIFF-ZIP", Dict())
    result = compute_result(c.connection, step2)
    @test result == "out.zip"
end
