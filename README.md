<img src="https://openeo.org/images/openeo_logo.png" align="right" height="138" />

# OpenEOClient.jl

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://Open-EO.github.io/openeo-julia-client/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://open-eo.github.io/openeo-julia-client/dev/)
[![Build Status](https://github.com/Open-EO/openeo-julia-client/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Open-EO/openeo-julia-client/actions/workflows/CI.yml?query=branch%3Amain)


A Julia client for [openEO](https://openeo.org/) to access big Earth observation cloud back-ends in a simple and unified way. 

## Important Note

This project is currently under intensive development.
The API is not considered stable yet.
There may be errors in some outputs.
We do not take any warranty for that.
Please test this package with caution.
Bug reports and feature requests are welcome.
Please create a [new issue](https://github.com/Open-EO/openeo-julia-client/issues/new) for this.

## Get Started

Install the package using:

```julia
using Pkg
Pkg.add(url="https://github.com/Open-EO/openeo-julia-client.git")
```

Connect to an openEO backend server and load a collection:

```julia
using OpenEOClient
c = connect("earthengine.openeo.org", "v1.0")
c.load_collection(
    "COPERNICUS/S2", BoundingBox(west=16.06, south=48.06, east=16.65, north=48.35),
    ["2020-01-20", "2020-01-30"], ["B10"]
)
#openEO ProcessNode load_collection_tQ79zrFEGi8= with parameters:
#   bands:           ["B10"]
#   id:              "COPERNICUS/S2"
#   spatial_extent:  BoundingBox{Float64}(16.06, 48.06, 16.65, 48.35)
#   temporal_extent: ["2020-01-20", "2020-01-30"]
```

load the remote sensing data set, calculate the median of all time points for each pixel, execute the processes on the backend and download the result as a JPG image using an authorized connection:


```julia
using OpenEOClient
c = connect("earthengine.openeo.org", "v1.0", "my_username", "my_password")
step1 = c.load_collection(
    "COPERNICUS/S2", BoundingBox(west=16.06, south=48.06, east=16.65, north=48.35),
    ["2020-01-01", "2020-01-31"], ["B10"]
)
step2 = c.reduce_dimension(step1, Reducer("median"), "t", nothing)
step3 = c.save_result(step2, "JPEG", Dict())
c.compute_result(step3)
# "out.jpeg"
```

Explore the executed process graph:

```julia
g = ProcessGraph(step3)
# openEO ProcessGraph with steps:
#    1:    load_collection(["B10"], COPERNICUS/S2, BoundingBox{Float64}(16.06, 48.06, 16.65, 48.35), ["2020-01-01", "2020-01-31"])
#    2:    reduce_dimension(nothing, Reducer(OrderedCollections.OrderedDict{Symbol, ProcessNode}(:reduce1 => ProcessNode("reduce1", "median", Dict{Symbol, Any}(:data => Dict(:from_parameter => "data")), true))), OpenEOClient.ProcessNodeReference("load_collection_YwIbbFrt5Ws="), t)
#    3:    save_result(Dict{Any, Any}(), JPEG, OpenEOClient.ProcessNodeReference("reduce_dimension_7ezKGDXsnoE="))

g[1]
# openEO ProcessNode load_collection_YwIbbFrt5Ws= with parameters:
#    bands:           ["B10"]
#    id:              "COPERNICUS/S2"
#    spatial_extent:  BoundingBox{Float64}(16.06, 48.06, 16.65, 48.35)
#    temporal_extent: ["2020-01-01", "2020-01-31"]
```