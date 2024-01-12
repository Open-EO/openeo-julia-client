using OpenEOClient
using Test

host = ENV["OPENEO_HOST"]
version = ENV["OPENEO_VERSION"]
username = ENV["OPENEO_USERNAME"]
password = ENV["OPENEO_PASSWORD"]

@testset "OpenEOClient.jl" begin
    unauth_con = OpenEOClient.UnAuthorizedCredentials(host, version)
    response = OpenEOClient.fetchApi(unauth_con, "/")
    @test "api_version" in keys(response)
    @test "backend_version" in keys(response)

    list_processes(unauth_con)
    list_collections(unauth_con)

    c1 = connect(host, version)
    c2 = connect(host, version, username, password)
    @test allequal([c1, c2] .|> x -> size(x.collections))

    # test sequential workflow
    step1 = c2.load_collection(
        "COPERNICUS/S2", BoundingBox(west=16.06, south=48.06, east=16.65, north=48.35),
        ["2020-01-20", "2020-01-30"], ["B10"]
    )
    @test step1.id == "load_collection_tQ79zrFEGi8="
    @test step1.process_id == "load_collection"
    @test Set(keys(step1.arguments)) == Set([:bands, :id, :spatial_extent, :temporal_extent])
    @test step1.arguments[:bands] == ["B10"]

    step2 = c2.reduce_dimension(step1, ProcessGraph("median"), "t", nothing)
    step3 = c2.save_result(step2, "JPEG", Dict())
    result = c2.compute_result(step3)
    @test result == "out.jpeg"

    # test julia syntax workflow
    cube = DataCube(c2, "COPERNICUS/S2",
        BoundingBox(west=16.06, south=48.06, east=16.65, north=48.35),
        ("2020-01-20", "2020-01-30"), ["B01", "B02"]
    )

    abs(cube)
    abs(cube["B01"])
    cube |> abs |> sqrt
    cube["B01"] |> abs |> sqrt

    cube["B01"]
    cube["B01"] + 1
    1 + cube["B01"]
    cube["B01"] + 1 + 2
    cube + 1
    1 + cube + 1
    cube["B01"] + cube["B02"]
    cube + cube
    cube + 1
    cube + 1 + 2
    1 + cube
    @test (cube["B01"]+1+1).call.arguments[:reducer] |> length == 3
    @test (cube["B01"] + cube["B02"]).call.process_id == "merge_cubes"
    @test (cube+2*3).call.arguments[:process] |> length == 1
    @test cube2 = cube + 2 * 3 |> typeof == DataCube
end