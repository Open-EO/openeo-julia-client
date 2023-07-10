# DimensionGeometry


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | **String** | Type of the dimension. | [default to nothing]
**description** | **String** | Detailed description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. | [optional] [default to nothing]
**axes** | [**Vector{DimensionAxisXyz}**](DimensionAxisXyz.md) | Axes of the vector dimension as an ordered set of &#x60;x&#x60;, &#x60;y&#x60; and &#x60;z&#x60;. Defaults to &#x60;x&#x60; and &#x60;y&#x60;. | [optional] [default to nothing]
**bbox** | **Vector{Float64}** | Each bounding box is provided as four or six numbers, depending on whether the coordinate reference system includes a vertical axis (height or depth):  * West (lower left corner, coordinate axis 1) * South (lower left corner, coordinate axis 2) * Base (optional, minimum value, coordinate axis 3) * East (upper right corner, coordinate axis 1) * North (upper right corner, coordinate axis 2) * Height (optional, maximum value, coordinate axis 3)  The coordinate reference system of the values is WGS 84 longitude/latitude (http://www.opengis.net/def/crs/OGC/1.3/CRS84).  For WGS 84 longitude/latitude the values are in most cases the sequence of minimum longitude, minimum latitude, maximum longitude and maximum latitude.  However, in cases where the box spans the antimeridian the first value (west-most box edge) is larger than the third value (east-most box edge).  If the vertical axis is included, the third and the sixth number are the bottom and the top of the 3-dimensional bounding box. | [default to nothing]
**values** | **Vector{String}** | Optionally, a representation of the vectors. This can be a list of WKT string or other free-form identifiers. | [optional] [default to nothing]
**geometry_types** | [**Vector{GeometryType}**](GeometryType.md) | A set of all geometry types included in this dimension. If not present, mixed geometry types must be assumed. | [optional] [default to nothing]
**reference_system** | [***CollectionDimensionSrs**](CollectionDimensionSrs.md) |  | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


