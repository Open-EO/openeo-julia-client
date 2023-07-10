using OpenEOClient
using Test

host = ENV["OPENEO_HOST"]
version = ENV["OPENEO_VERSION"]
username = ENV["OPENEO_USERNAME"]
password = ENV["OPENEO_PASSWORD"]

@testset "OpenEOClient.jl" begin
    connection = Connection(host, username, password, version)
    @test length(connection.access_token) > 0
end
