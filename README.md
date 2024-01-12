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

Connect to an openEO backend server and list available collections of raster image datasets:

```julia
using OpenEOClient
con = connect("openeo.dataspace.copernicus.eu/openeo", "")
con.collections
# 8-element Vector{OpenEOClient.Collection}:
#  SENTINEL3_OLCI_L1B: Sentinel 3 OLCI
#  SENTINEL3_SLSTR: Sentinel 3 SLSTR
#  SENTINEL_5P_L2: Sentinel 5 Precursor
#  SENTINEL2_L1C: Sentinel-2 L1C
#  SENTINEL2_L2A: Sentinel-2 L2A
#  SENTINEL1_GRD: Sentinel-1 SAR GRD: C-band Synthetic Aperture Radar Ground Range Detected.
#  COPERNICUS_30: Copernicus Global 30 meter Digital Elevation Model dataset.
#  LANDSAT8_L2: Landsat 8 level 2 ARD, European Coverage
```

Further computations require a free registration at an openEO backend.
Here, we use the [Copernicus Data Space](https://dataspace.copernicus.eu).
Calculate the enhanced vegetation index (EVI) analog to this [tutorial](https://documentation.dataspace.copernicus.eu/APIs/openEO/Python_Client/Python.html):

```julia
using OpenEOClient
con = connect("openeo.dataspace.copernicus.eu/openeo", "", OpenEOClient.oidc_auth)
cube = DataCube(con, "SENTINEL2_L2A",
    BoundingBox(west=5.14, south=51.17, east=5.17, north=51.19),
    ("2021-02-01", "2021-02-10"), ["B02", "B04", "B08"]
)
blue = cube["B02"] * 0.0001
red = cube["B04"] * 0.0001
nir = cube["B08"] * 0.0001
evi = 2.5 * (nir - red) / (nir + 6.0 * red - 7.5 * blue + 1.0)
# openEO DataCube
#    collection: SENTINEL2_L2A
#    bands: Single band
#    spatial extent: BoundingBox{Float64}(5.14, 51.17, 5.17, 51.19)
#    temporal extent: ("2021-02-01", "2021-02-10")
#    license: proprietary
#    connection: https://openeo.dataspace.copernicus.eu/openeo/
```

Up to now, the analysis workflow is just being constructed on the client.
It can be executed on the server using `compute_result(evi)` which returns the file name of the downloaded result.