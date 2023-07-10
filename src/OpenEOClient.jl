module OpenEOClient

include("Connection.jl")
include("API.jl")

export
    Connection,
    list_jobs,
    list_processes
end
