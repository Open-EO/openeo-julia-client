import StructTypes

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

function Base.show(io::IO, ::MIME"text/plain", c::Collection)
    println(io, "openEO Collection \"$(c.id)\"")
    print(io, c.description)
end

function Base.show(io::IO, ::MIME"text/plain", v::Vector{Collection}; n=10)
    println(io, "$(length(v))-element $(typeof(v)):")
    for c in first(v, n)
        println(io, " $(c.id): $(c.title)")
    end
    n < length(v) && print("⋮")
end

# @see https://earthengine.openeo.org/v1.0/collections
struct CollectionsRoot
    collections::Vector{Collection}
    links::Vector{Any}
end
StructTypes.StructType(::Type{CollectionsRoot}) = StructTypes.Struct()
