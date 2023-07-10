# CapabilitiesApi

All URIs are relative to *https://openeo.example/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**capabilities**](CapabilitiesApi.md#capabilities) | **GET** / | Information about the back-end
[**conformance**](CapabilitiesApi.md#conformance) | **GET** /conformance | Conformance classes this API implements
[**connect**](CapabilitiesApi.md#connect) | **GET** /.well-known/openeo | Supported openEO versions
[**list_file_types**](CapabilitiesApi.md#list_file_types) | **GET** /file_formats | Supported file formats
[**list_service_types**](CapabilitiesApi.md#list_service_types) | **GET** /service_types | Supported secondary web service protocols
[**list_udf_runtimes**](CapabilitiesApi.md#list_udf_runtimes) | **GET** /udf_runtimes | Supported UDF runtimes


# **capabilities**
> capabilities(_api::CapabilitiesApi; _mediaType=nothing) -> Capabilities, OpenAPI.Clients.ApiResponse <br/>
> capabilities(_api::CapabilitiesApi, response_stream::Channel; _mediaType=nothing) -> Channel{ Capabilities }, OpenAPI.Clients.ApiResponse

Information about the back-end

Lists general information about the back-end, including which version and endpoints of the openEO API are supported. May also include billing information.

### Required Parameters
This endpoint does not need any parameter.

### Return type

[**Capabilities**](Capabilities.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **conformance**
> conformance(_api::CapabilitiesApi; _mediaType=nothing) -> OGCConformanceClasses, OpenAPI.Clients.ApiResponse <br/>
> conformance(_api::CapabilitiesApi, response_stream::Channel; _mediaType=nothing) -> Channel{ OGCConformanceClasses }, OpenAPI.Clients.ApiResponse

Conformance classes this API implements

Lists all conformance classes specified in various standards that the implementation conforms to. Conformance classes are commonly used in all OGC APIs and the STAC API specification. openEO adds relatively broadly defined conformance classes, especially for the extensions. Otherwise, the implemented functionality can usually be retrieved from the [capabilties](#tag/Capabilities/operation/capabilities) in openEO.  The general openEO conformance class is `https://api.openeo.org/1.2.0`. See the individual openEO API extensions for their conformance classes.  The conformance classes listed at this endpoint and listed in the  corresponding `conformsTo` property in `GET /` MUST be equal.  More details: - [STAC API](https://github.com/radiantearth/stac-api-spec), especially the conformance class \"STAC API - Collections\" - [OGC APIs](https://ogcapi.ogc.org/)

### Required Parameters
This endpoint does not need any parameter.

### Return type

[**OGCConformanceClasses**](OGCConformanceClasses.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **connect**
> connect(_api::CapabilitiesApi; _mediaType=nothing) -> WellKnownDiscovery, OpenAPI.Clients.ApiResponse <br/>
> connect(_api::CapabilitiesApi, response_stream::Channel; _mediaType=nothing) -> Channel{ WellKnownDiscovery }, OpenAPI.Clients.ApiResponse

Supported openEO versions

Lists all implemented openEO versions supported by the service provider. This endpoint is the Well-Known URI (see [RFC 5785](https://www.rfc-editor.org/rfc/rfc5785.html)) for openEO.  This allows a client to easily identify the most recent openEO implementation it supports. By default, a client SHOULD connect to the most recent production-ready version it supports. If not available, the most recent supported version of *all* versions SHOULD be connected to. Clients MAY let users choose to connect to versions that are not production-ready or outdated. The most recent version is determined by comparing the version numbers according to rules from [Semantic Versioning](https://semver.org/), especially [§11](https://semver.org/#spec-item-11). Any pair of API versions in this list MUST NOT be equal according to Semantic Versioning.  The Well-Known URI is the entry point for clients and users, so make sure it is permanent and easy to use and remember. Clients MUST NOT require the well-known path (`/.well-known/openeo`) in the URL that is specified by a user to connect to the back-end.  For clients, the usual behavior SHOULD follow these steps: 1. The user provides a URI, which may consist of a scheme (protocol),     an authority (host, port) and a path. 2. The client parses the URI and appends `/.well-knwon/openeo` to the    path. Make sure to correctly handle leading/trailing slashes. 3. Send a request to the new URI.    A. On success: Detect the most suitable API instance/version (see above)       and read the [capabilites](#tag/Capabilities/operation/capabilities)       from there.    B. On failure: Directly try to read the capabilities from the original URI       given by the user.  **This URI MUST NOT be versioned as the other endpoints.** If your API is available at `https://openeo.example/api/v1`, and you instruct your API users to use `https://openeo.example` as connection URI,  the Well-Known URI SHOULD be located at `https://openeo.example/.well-known/openeo`. The Well-Known URI is usually directly located at the top-level, but it is not a requirement. For example, `https://openeo.example/eo/.well-known/openeo` is also allowed.  Clients MAY get additional information (e.g. title or description) about a back-end from the most recent version that has the `production` flag set to `true`.

### Required Parameters
This endpoint does not need any parameter.

### Return type

[**WellKnownDiscovery**](WellKnownDiscovery.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **list_file_types**
> list_file_types(_api::CapabilitiesApi; _mediaType=nothing) -> FileFormats, OpenAPI.Clients.ApiResponse <br/>
> list_file_types(_api::CapabilitiesApi, response_stream::Channel; _mediaType=nothing) -> Channel{ FileFormats }, OpenAPI.Clients.ApiResponse

Supported file formats

Lists supported input and output file formats. *Input* file formats specify which file a back-end can *read* from. *Output* file formats specify which file a back-end can *write* to.  The response to this request is an object listing all available input and output file formats separately with their parameters and additional data. This endpoint does not include the supported secondary web services.  **Note**: Format names and parameters MUST be fully aligned with the GDAL codes if available, see [GDAL Raster Formats](https://gdal.org/drivers/raster/index.html) and [OGR Vector Formats](https://gdal.org/drivers/vector/index.html). It is OPTIONAL to support all output format parameters supported by GDAL. Some file formats not available through GDAL may be defined centrally for openEO. Custom file formats or parameters MAY be defined.  The format descriptions must describe how the file formats relate to  data cubes. Input file formats must describe how the files have to be structured to be transformed into data cubes. Output file formats must describe how the data cubes are stored at the back-end and how the  resulting file structure looks like.  Back-ends MUST NOT support aliases, for example it is not allowed to support `geotiff` instead of `gtiff`. Nevertheless, openEO Clients MAY translate user input input for convenience (e.g. translate `geotiff` to `gtiff`). Also, for a better user experience the back-end can specify a `title`.  Format names MUST be accepted in a *case insensitive* manner throughout the API.

### Required Parameters
This endpoint does not need any parameter.

### Return type

[**FileFormats**](FileFormats.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **list_service_types**
> list_service_types(_api::CapabilitiesApi; _mediaType=nothing) -> Dict{String, ServiceTypes}, OpenAPI.Clients.ApiResponse <br/>
> list_service_types(_api::CapabilitiesApi, response_stream::Channel; _mediaType=nothing) -> Channel{ Dict{String, ServiceTypes} }, OpenAPI.Clients.ApiResponse

Supported secondary web service protocols

Lists supported secondary web service protocols such as [OGC WMS](http://www.opengeospatial.org/standards/wms), [OGC WCS](http://www.opengeospatial.org/standards/wcs), [OGC API - Features](https://www.ogc.org/standards/ogcapi-features) or [XYZ tiles](https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames). The response is an object of all available secondary web service protocols with their supported configuration settings and expected process parameters.  * The configuration settings for the service SHOULD be defined upon   creation of a service and the service will be set up accordingly. * The process parameters SHOULD be referenced (with a `from_parameter`   reference) in the user-defined process that is used to compute web service   results.   The appropriate arguments MUST be provided to the user-defined process,   usually at runtime from the context of the web service,   For example, a map service such as a WMS would   need to inject the spatial extent into the user-defined process so that the   back-end can compute the corresponding tile correctly.  To improve interoperability between back-ends common names for the services SHOULD be used, e.g. the abbreviations used in the official [OGC Schema Repository](http://schemas.opengis.net/) for the respective services.  Service names MUST be accepted in a *case insensitive* manner throughout the API.

### Required Parameters
This endpoint does not need any parameter.

### Return type

[**Dict{String, ServiceTypes}**](ServiceTypes.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **list_udf_runtimes**
> list_udf_runtimes(_api::CapabilitiesApi; _mediaType=nothing) -> Dict{String, UDFRuntimes}, OpenAPI.Clients.ApiResponse <br/>
> list_udf_runtimes(_api::CapabilitiesApi, response_stream::Channel; _mediaType=nothing) -> Channel{ Dict{String, UDFRuntimes} }, OpenAPI.Clients.ApiResponse

Supported UDF runtimes

Lists the supported runtimes for user-defined functions (UDFs), which includes either the programming languages including version numbers and available libraries including version numbers or docker containers.

### Required Parameters
This endpoint does not need any parameter.

### Return type

[**Dict{String, UDFRuntimes}**](UDFRuntimes.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)
