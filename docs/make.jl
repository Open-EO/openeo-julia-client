using OpenEOClient
using Documenter

DocMeta.setdocmeta!(OpenEOClient, :DocTestSetup, :(using OpenEOClient); recursive=true)

makedocs(;
    modules=[OpenEOClient],
    authors="Daniel Loos <dloos@bgc-jena.mpg.de> and contributors",
    repo="https://github.com/danlooo/OpenEOClient.jl/blob/{commit}{path}#{line}",
    sitename="OpenEOClient.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://danlooo.github.io/OpenEOClient.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/danlooo/OpenEOClient.jl",
    devbranch="main",
)
