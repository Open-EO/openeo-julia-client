```@meta
CurrentModule = OpenEOClient
```

# OpenEOClient

Documentation for [OpenEOClient](https://github.com/Open-EO/openeo-julia-client).


# Tutorial

Processing data on a openEO server requires authentication.


```@example tutorial
using OpenEOClient
username = ENV["username"]
password = ENV["password"]
c = connect("earthengine.openeo.org", "v1.0", username, password)
step1 = c.load_collection(
    "COPERNICUS/S2", BoundingBox(west=16.06, south=48.06, east=16.65, north=48.35),
    ["2020-01-01", "2020-01-31"], ["B10"]
)
step2 = c.reduce_dimension(step1, Reducer("median"), "t", nothing)
step3 = c.save_result(step2, "GTIFF-ZIP", Dict())
path = c.compute_result(step3)
```

The data is downloaded in zipped GeoTiff format.
It can be loaded into a local Julia session using [Rasters.jl](https://rafaqz.github.io/Rasters.jl/stable/):

```@example tutorial
using ZipFile, Rasters, Plots, ArchGDAL

f = ZipFile.Reader(path).files[1]
write(open(f.name, "w"), read(f, String))

cube = Raster(f.name)
```

Plotting:

```@example tutorial
plot(cube)
```

```@index
```

```@autodocs
Modules = [OpenEOClient]
```
