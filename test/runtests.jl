using OpenEOClient
using Test

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
end
