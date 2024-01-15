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

    @test list_processes(unauth_con) |> typeof == Vector{OpenEOClient.Process}
    @test list_collections(unauth_con) |> typeof == Vector{OpenEOClient.Collection}

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

    @test_throws MethodError abs(cube)
    @test abs.(cube) |> typeof == DataCube

    cube["B01"]
    cube["B01"] .+ 1
    1 .+ cube["B01"]
    cube["B01"] .+ 1 .+ 2
    1 .+ cube .+ 1
    cube["B01"] .+ cube["B02"]
    cube .+ cube
    cube .+ 1
    cube .+ 1 .+ 2
    1 .+ cube
    @test (cube["B01"].+1 .+ 1).call.arguments[:reducer] |> length == 3
    @test (cube["B01"] .+ cube["B02"]).call.process_id == "merge_cubes"
    @test (cube .+ 2*3).call.arguments[:process] |> length == 1
    @test cube2 = cube .+ 2 * 3 |> typeof == DataCube

    # OpenEO applies processes per element thus enforce broadcasting
    @test sin.(cube) |> typeof == DataCube
    @test_throws MethodError sin(cube)
    @test cube ./ 2 |> typeof == DataCube
    @test cube / 2 |> typeof == DataCube
    @test_throws MethodError 2 / cube
    @test 2 ./ cube |> typeof == DataCube
    @test_throws MethodError cube / cube
    @test cube ./ cube |> typeof == DataCube
    @test cube + cube |> typeof == DataCube
    @test cube .+ cube |> typeof == DataCube

    @test_throws ErrorException reduce_dimension(cube, "xxx", "t") 
    @test_throws ErrorException reduce_dimension(cube, "min", "xxx")
    @test reduce_dimension(cube["B02"], "min", "t") |> typeof == DataCube
    @test reduce_dimension(cube, "min", "t") |> typeof == DataCube

    @test reduce(con.max, cube["B01"], dims="t")  |> typeof == DataCube
    @test maximum(cube["B01"], dims="t") |> typeof == DataCube
    @test reduce(con.max, cube["B01"], dims="t") |> typeof == DataCube
    @test_throws ErrorException maximum(cube["B01"], dims="xx")

    @test cube.dimensions == ["x", "y", "t", "bands"]
    @test cube["B01"].dimensions == ["x", "y", "t"]
    @test maximum(cube["B01"], dims = "t").dimensions == ["x", "y"]
    @test maximum(cube, dims = "bands").dimensions == ["x", "y", "t"]
end