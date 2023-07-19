#
# Types used by JSON3.jl to parse API responses.
# @see https://api.openeo.org/#tag/Process-Discovery/operation/list-processes
# Union{Nothing,T} describes optional elements
#

module OpenEOApiTypes
import StructTypes

const API_VERSION = "1.0.0"

#
# Collections
#

struct Collection
    stac_version::String
    stac_extensions::Vector{Any}
    type::String
    id::String
    title::String
    description::String
    license::String
    providers::Vector{Any}
    extent::Any
    links::Vector{Any}
end
StructTypes.StructType(::Type{Collection}) = StructTypes.Struct()

# root e.g. https://earthengine.openeo.org/v1.0/collections
struct CollectionsRoot
    collections::Vector{Collection}
    links::Vector{Any}
end
StructTypes.StructType(::Type{CollectionsRoot}) = StructTypes.Struct()

#
# Processes
#

struct Parameter
    name::String
    description::String
    schema::Any
    default::Union{Nothing,Any}
    optional::Union{Nothing,Bool}
    deprecated::Union{Nothing,Bool}
    experimental::Union{Nothing,Bool}
end
StructTypes.StructType(::Type{Parameter}) = StructTypes.Struct()

struct Process
    id::String
    summary::String
    description::String
    categories::Vector{String}
    parameters::Vector{Parameter}
    returns::Any
    examples::Union{Nothing,Vector{Any}}
    links::Union{Nothing,Vector{Any}}
    exceptions::Any
    experimental::Union{Nothing,Bool}
end
StructTypes.StructType(::Type{Process}) = StructTypes.Struct()

# root e.g. https://earthengine.openeo.org/v1.0/processes
struct ProcessesRoot
    processes::Vector{Process}
    links::Vector{Any}
end
StructTypes.StructType(::Type{ProcessesRoot}) = StructTypes.Struct()
end