using OpenEOClient
using Documenter

DocMeta.setdocmeta!(OpenEOClient, :DocTestSetup, :(using OpenEOClient); recursive=true)

makedocs(;
    modules=[OpenEOClient],
    authors="Daniel Loos <dloos@bgc-jena.mpg.de> and contributors",
    repo="https://github.com/Open-EO/openeo-julia-client/blob/{commit}{path}#{line}",
    sitename="OpenEOClient.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://open-eo.github.io/openeo-julia-client",
        edit_link="main",
        assets=String[]
    ),
    pages=[
        "Home" => "index.md",
    ]
)

deploydocs(;
    repo="github.com/Open-EO/openeo-julia-client",
    devbranch="main"
)
