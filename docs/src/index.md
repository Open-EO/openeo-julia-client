```@meta
CurrentModule = OpenEOClient
```

# OpenEOClient

Documentation for [OpenEOClient](https://github.com/Open-EO/openeo-julia-client).


```@index
```


# Tutorial

Processing data on a openEO server requires authentication.


```@example tutorial
using OpenEOClient
username = ENV["OPENEO_USERNAME"]
password = ENV["OPENEO_PASSWORD"]
c = connect("earthengine.openeo.org", "v1.0", username, password)
step1 = c.load_collection(
    "COPERNICUS/S2", BoundingBox(west=16.06, south=48.06, east=16.65, north=48.35),
    ["2020-01-01", "2020-01-31"]; bands = ["B10"]
)
step2 = c.reduce_dimension(step1, ProcessGraph("median"), "t")
step3 = c.save_result(step2, "GTIFF")
path = c.compute_result(step3)
```

# Connect to Copernicus Dataspace using OIDC

The [Copernicus Data Space Ecosystem](https://dataspace.copernicus.eu/) provides free instant access to sentinel mission data using openEO.
After registration, we can establish an connection using OID.
The log-in process is performed at a given URL that must be visited in a browser.
This can happen at any device and does not need to be at the server running the code:

```
c = connect("openeo.dataspace.copernicus.eu/openeo/", "1.2", OpenEOClient.oidc_auth)
┌ Info: Please log in using any device at:
│ https://identity.dataspace.copernicus.eu/auth/realms/CDSE/device?user_code=ABCDE-FGHI
└ Waiting until log in succeeded...
openEO ConnectionInstance
authorized openEO connection to https://openeo.dataspace.copernicus.eu/openeo//1.2
8 collections
132 processes
```

Explore available collections:

```julia
c.collections
```

```
8-element Vector{OpenEOClient.Collection}:
 SENTINEL3_OLCI_L1B: Sentinel 3 OLCI
 SENTINEL3_SLSTR: Sentinel 3 SLSTR
 SENTINEL_5P_L2: Sentinel 5 Precursor
 SENTINEL2_L1C: Sentinel-2 L1C
 SENTINEL2_L2A: Sentinel-2 L2A
 SENTINEL1_GRD: Sentinel-1 SAR GRD: C-band Synthetic Aperture Radar Ground Range Detected.
 COPERNICUS_30: Copernicus Global 30 meter Digital Elevation Model dataset.
 LANDSAT8_L2: Landsat 8 level 2 ARD, European Coverage
```

Explore available processes:

```julia
c.processes
```

```
Dict{Symbol, OpenEOClient.Process} with 132 entries:
  :sinh                  => Process("sinh", "Hyperbolic sine", "Computes the hyperbolic sine of `x`.\n\nWorks on radians only.\nThe …
  :eq                    => Process("eq", "Equal to comparison", "Compares whether `x` is strictly equal to `y`.\n\n**Remarks:**\n\n…
  :sgn                   => Process("sgn", "Signum", "The signum (also known as *sign*) of `x` is defined as:\n\n* *1* if *x > 0*\n*…
  :apply_kernel          => Process("apply_kernel", "Apply a spatial convolution with a kernel", "Applies a 2D convolution (i.e. a f…
  :filter_labels         => Process("filter_labels", "Filter dimension labels based on a condition", "Filters the dimension labels i…
  :rename_dimension      => Process("rename_dimension", "Rename a dimension", "Renames a dimension in the data cube while preserving…
  :load_ml_model         => Process("load_ml_model", "Load a ML model", "Loads a machine learning model from a STAC Item.\n\nSuch a …
  :drop_dimension        => Process("drop_dimension", "Remove a dimension", "Drops a dimension from the data cube.\n\nDropping a dim…
  :is_valid              => Process("is_valid", "Value is valid data", "Checks whether the specified value `x` is valid. The followi…
  :mod                   => Process("mod", "Modulo", "Remainder after a division of `x` by `y` for both integers and floating-point …
  :apply_neighborhood    => Process("apply_neighborhood", "Apply a process to pixels in a n-dimensional neighborhood", "Applies a fo…
  :save_result           => Process("save_result", "Save processed data", "Makes the processed data available in the given file form…
  :filter_spatial        => Process("filter_spatial", "Spatial filter raster data cubes using geometries", "Limits the raster data c…
  :run_udf               => Process("run_udf", "Run a UDF", "Runs a UDF in one of the supported runtime environments.\n\nThe process…
  :mask_scl_dilation     => Process("mask_scl_dilation", "Mask clouds by dilating Sen2Cor sceneclassification", "Mask clouds by dila…
  :date_between          => Process("date_between", "Between comparison for dates and times", "By default, this process checks wheth…
  :count                 => Process("count", "Count the number of elements", "Gives the number of elements in an array that matches …
  :arctan2               => Process("arctan2", "Inverse tangent of two numbers", "Computes the arc tangent of two numbers `x` and `y…
  :exp                   => Process("exp", "Exponentiation to the base e", "Exponential function to the base *e* raised to the power…
  :tanh                  => Process("tanh", "Hyperbolic tangent", "Computes the hyperbolic tangent of `x`. The tangent is defined to…
  :floor                 => Process("floor", "Round fractions down", "The greatest integer less than or equal to the number `x`.\n\n…
  :apply_dimension       => Process("apply_dimension", "Apply a process to all values along a dimension", "Applies a process to all …
  :normalized_difference => Process("normalized_difference", "Normalized difference", "Computes the normalized difference for two ba…
  :all                   => Process("all", "Are all of the values true?", "Checks if **all** of the values in `data` are true. If no…
  :log                   => Process("log", "Logarithm to a base", "Logarithm to the base `base` of the number `x` is defined to be t…
  :between               => Process("between", "Between comparison", "By default, this process checks whether `x` is greater than or…
  :mean                  => Process("mean", "Arithmetic mean (average)", "The arithmetic mean of an array of numbers is the quantity…
  ⋮                      => ⋮
```


# Reference

```@autodocs
Modules = [OpenEOClient]
```
