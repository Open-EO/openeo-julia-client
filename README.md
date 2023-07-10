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

Connect to an openEO backend server:

```julia
using OpenEOClient
con = Connection("earthengine.openeo.org", "v1.0")
list_processes(con)
#67×1 DataFrame
# Row │ id                           
#     │ String                       
#─────┼──────────────────────────────
#   1 │ absolute
#   2 │ add
#   3 │ add_dimension
#   4 │ aggregate_temporal_frequency
```
