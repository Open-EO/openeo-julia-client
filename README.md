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
connection = connect("earthengine.openeo.org", "v1.0")
connection.load_collection(
    "COPERNICUS/S2", (16.06, 48.06, 16.65, 48.35),
    ["2020-01-20", "2020-01-30"], ["B10"]
)
# openEO ProcessCall load_collection with parameters:
#    bands:           ["B10"]
#    spatial_extent:  (16.06, 48.06, 16.65, 48.35)
#    id:              "COPERNICUS/S2"
#    temporal_extent: ["2020-01-20", "2020-01-30"]
```