#
# julia types and functions representing openeEO functionality
#   - meant to be used directly by the user
#   - automatically converted to JSON objects of the openeEO API
#

import Base: convert, promote, promote_rule
import Base: +, -, *, /, cos, sqrt, abs, negate

struct DataCube
    connection::ConnectionInstance
    collection_id::String
end


struct Node
    op
    children::Vector
end

Node(x::Node) = x
Node(x) = Node("create", [x])
"Create Placeholder node e.g. for user defined functions in reducers and apply functions"
Node() = Node("create", [nothing])

isleaf(n::Node) = n.children |> typeof |> eltype != Node

# function Base.show(io::IO, ::MIME"text/plain", n::Node)
#     if isleaf(n)
#         print()
#     else

#     end

#     println(io, "openEO Collection \"$(c.id)\"")
#     print(io, c.description)
# end

convert(::Type{Node}, x) = Node(x)
convert(::Type{Node}, x::Node) = Node(x)
promote_rule(::Type{Node}, ::Type{T}) where {T<:Real} = Node

abs(x::Node) = Node("absolute", [x])
sin(x::Node) = Node("sin", [x])
cos(x::Node) = Node("cos", [x])
sqrt(x::Node) = Node("sqrt", [x])

+(x::Node, y::Node) = Node("add", [x, y])
-(x::Node, y::Node) = Node("subtract", [x, y])
*(x::Node, y::Node) = Node("multiply", [x, y])
/(x::Node, y::Node) = Node("divide", [x, y])

+(x::Node, y) = +(promote(x, y)...)
-(x::Node, y) = -(promote(x, y)...)
*(x::Node, y) = *(promote(x, y)...)
/(x::Node, y) = /(promote(x, y)...)

+(x, y::Node) = +(promote(x, y)...)
-(x, y::Node) = -(promote(x, y)...)
*(x, y::Node) = *(promote(x, y)...)
/(x, y::Node) = /(promote(x, y)...)
