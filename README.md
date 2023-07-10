# Julia API client for APIClient

The openEO API specification for interoperable cloud-based processing of large Earth observation datasets.

**Conformance class:** `https://api.openeo.org/1.2.0`

# API Principles

## Language

In the specification the key words “MUST”, “MUST NOT”, “REQUIRED”, “SHALL”, “SHALL NOT”, “SHOULD”, “SHOULD NOT”, “RECOMMENDED”, “MAY”, and “OPTIONAL” in this document are to be interpreted as described in [RFC 2119](https://www.rfc-editor.org/rfc/rfc2119.html) and [RFC 8174](https://www.rfc-editor.org/rfc/rfc8174.html).

## Casing

Unless otherwise stated the API works **case sensitive**.

All names SHOULD be written in snake case, i.e. words are separated with one underscore character (`_`) and no spaces, with all letters lower-cased. Example: `hello_world`. This applies particularly to endpoints and JSON property names. HTTP header fields are generally case-insensitive according to [RFC 7230](https://www.rfc-editor.org/rfc/rfc7230.html#section-3.2) and in the specification we follow their respective casing conventions, e.g. `Content-Type` or `OpenEO-Costs`, for better readability and consistency.

## HTTP / REST

This uses [HTTP REST](https://en.wikipedia.org/wiki/Representational_state_transfer) [Level 2](https://martinfowler.com/articles/richardsonMaturityModel.html#level2) for communication between client and back-end server.

Public APIs MUST be available via HTTPS only. 

Endpoints are made use meaningful HTTP verbs (e.g. GET, POST, PUT, PATCH, DELETE) whenever technically possible. If there is a need to transfer big chunks of data for a GET requests to the back-end, POST requests MAY be used as a replacement as they support to send data via request body. Unless otherwise stated, PATCH requests are only defined to work on direct (first-level) children of the full JSON object. Therefore, changing a property on a deeper level of the full JSON object always requires to send the whole JSON object defined by the first-level property.

Naming of endpoints follow the REST principles. Therefore, endpoints are centered around resources. Resource identifiers MUST be named with a noun in plural form except for single actions that can not be modelled with the regular HTTP verbs. Single actions MUST be single endpoints with a single HTTP verb (POST is RECOMMENDED) and no other endpoints beneath it.

The openEO API makes use of [HTTP Content Negotiation](https://www.rfc-editor.org/rfc/rfc9110.html#name-content-negotiation),
including, but not limited to, the request headers `Accept`, `Accept-Charset` and `Accept-Language`.

### JSON

The API uses JSON for request and response bodies whenever feasible. Services use JSON as the default encoding. Other encodings can be requested using HTTP Content Negotiation ([`Accept` header](https://www.rfc-editor.org/rfc/rfc9110.html#name-accept)). Clients and servers MUST NOT rely on the order in which properties appear in JSON. To keep the response size small, lists of resources (e.g. the list of batch jobs) usually should not include nested JSON objects, if this information can be requested from the individual resource endpoints (e.g. the metadata for a single batch job).

### Charset

Services use [UTF-8](https://en.wikipedia.org/wiki/UTF-8) as the default charset if not negotiated otherwise with HTTP Content Negotiation ([`Accept-Charset` header](https://www.rfc-editor.org/rfc/rfc9110.html#name-accept-charset)).

## Web Linking

The API is designed in a way that to most entities (e.g. collections and processes) a set of links can be added. These can be alternate representations, e.g. data discovery via OGC WCS or OGC CSW, references to a license, references to actual raw data for downloading, detailed information about pre-processing and more. Clients should allow users to follow the links.

Whenever links are utilized in the API, the description explains which relation (`rel` property) types are commonly used.
A [list of standardized link relations types is provided by IANA](https://www.iana.org/assignments/link-relations/link-relations.xhtml) and the API tries to align whenever feasible.

Some very common relation types - usually not mentioned explicitly in the description of `links` fields - are:

1. `self`: which allows link to the location that the resource can be (permanently) found online.This is particularly useful when the data is data is made available offline, so that the downstream user knows where the data has come from.

2. `alternate`: An alternative representation of the resource, may it be another metadata standard the data is available in or simply a human-readable version in HTML or PDF.

3. `about`: A resource that is related or further explains the resource, e.g. a user guide.

4. `canonical`: This relation type usually points to a publicly accessible and more long-lived URL for a resource that otherwise often requires (Bearer) authentication with a short-lived token.
This way the the exposed resources can be used by non-openEO clients without additional authentication steps.
For example, a shared user-defined process or batch job results could be exposed via a canonical link.
If a URL should be publicly available to everyone, it can simply a user-specific URL, e.g. `https://openeo.example/processes/john_doe/ndvi`.
For resources that should only be accessible to a certain group of user, a signed URL could be given, e.g. `https://openeo.example/processes/81zjh1tc2pt52gbx/ndvi`.

Generally, it is RECOMMENDED to add descriptive titles (propertty `title`) and media type information (propertty `type`) for a better user experience.

## Error Handling

The success of requests MUST be indicated using [HTTP status codes](https://www.rfc-editor.org/rfc/rfc7231.html#section-6) according to [RFC 7231](https://www.rfc-editor.org/rfc/rfc7231.html).

If the API responds with a status code between 100 and 399 the back-end indicates that the request has been handled successfully.

In general an error is communicated with a status code between 400 and 599. Client errors are defined as a client passing invalid data to the service and the service *correctly* rejecting that data. Examples include invalid credentials, incorrect parameters, unknown versions, or similar. These are generally \"4xx\" HTTP error codes and are the result of a client passing incorrect or invalid data. Client errors do *not* contribute to overall API availability. 

Server errors are defined as the server failing to correctly return in response to a valid client request. These are generally \"5xx\" HTTP error codes. Server errors *do* contribute to the overall API availability. Calls that fail due to rate limiting or quota failures MUST NOT count as server errors. 

### JSON error object

A JSON error object SHOULD be sent with all responses that have a status code between 400 and 599.

``` json
{
  \"id\": \"936DA01F-9ABD-4D9D-80C7-02AF85C822A8\",
  \"code\": \"SampleError\",
  \"message\": \"A sample error message.\",
  \"url\": \"https://openeo.example/docs/errors/SampleError\"
}
```

Sending `code` and `message` is REQUIRED. 

* A back-end MAY add a free-form `id` (unique identifier) to the error response to be able to log and track errors with further non-disclosable details.
* The `code` is either one of the [standardized textual openEO error codes](errors.json) or a proprietary error code.
* The `message` explains the reason the server is rejecting the request. For \"4xx\" error codes the message explains how the client needs to modify the request.

  By default the message MUST be sent in English language. Content Negotiation is used to localize the error messages: If an `Accept-Language` header is sent by the client and a translation is available, the message should be translated accordingly and the `Content-Language` header must be present in the response. See \"[How to localize your API](http://apiux.com/2013/04/25/how-to-localize-your-api/)\" for more information.
* `url` is an OPTIONAL attribute and contains a link to a resource that is explaining the error and potential solutions in-depth.

### Standardized status codes

The openEO API usually uses the following HTTP status codes for successful requests: 

- **200 OK**:
  Indicates a successful request **with** a response body being sent.
- **201 Created**
  Indicates a successful request that successfully created a new resource. Sends a `Location` header to the newly created resource **without** a response body.
- **202 Accepted**
  Indicates a successful request that successfully queued the creation of a new resource, but it has not been created yet. The response is sent **without** a response body.
- **204 No Content**:
  Indicates a successful request **without** a response body being sent.

The openEO API has some commonly used HTTP status codes for failed requests: 

- **400 Bad Request**:
  The back-end responds with this error code whenever the error has its origin on client side and no other HTTP status code in the 400 range is suitable.

- **401 Unauthorized**:
  The client did not provide any authentication details for a resource requiring authentication or the provided authentication details are not correct.

- **403 Forbidden**:
  The client did provided correct authentication details, but the privileges/permissions of the provided credentials do not allow to request the resource.

- **404 Not Found**:
  The resource specified by the path does not exist, i.e. one of the resources belonging to the specified identifiers are not available at the back-end.
  *Note:* Unsupported endpoints MAY also return HTTP status code 501.

- **500 Internal Server Error**:
  The error has its origin on server side and no other status code in the 500 range is suitable.

- **501 Not Implemented**:
  The requested endpoint is specified by the openEO API, but is not implemented (yet) by the back-end.
  *Note:* Unsupported endpoints MAY also return HTTP status code 404.


If a HTTP status code in the 400 range is returned, the client SHOULD NOT repeat the request without modifications. For HTTP status code in the 500 range, the client MAY repeat the same request later.

All HTTP status codes defined in RFC 7231 in the 400 and 500 ranges can be used as openEO error code in addition to the most used status codes mentioned here. Responding with openEO error codes 400 and 500 SHOULD be avoided in favor of any more specific standardized or proprietary openEO error code.

## Temporal data

Date, time, intervals and durations are formatted based on ISO 8601 or its profile [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) whenever there is an appropriate encoding available in the standard. All temporal data are specified based on the Gregorian calendar.

# Authentication

The openEO API offers two forms of authentication by default:
* OpenID Connect (recommended) at `GET /credentials/oidc`
* Basic at `GET /credentials/basic`
  
After authentication with any of the methods listed above, the tokens obtained during the authentication workflows can be sent to protected endpoints in subsequent requests.

Further authentication methods MAY be added by back-ends.

<SecurityDefinitions />

**Note:** Although it is possible to request several public endpoints for capabilities and discovery that don't require authorization, it is RECOMMENDED that clients (re-)request the public endpoints that support Bearer authentication with the Bearer token once available to also retrieve any private data that is made available specifically for the authenticated user.
This may require that clients clear any cached data they retrieved from public endpoints before.

# Cross-Origin Resource Sharing (CORS)

> Cross-origin resource sharing (CORS) is a mechanism that allows restricted resources [...] on a web page to be requested from another domain outside the domain from which the first resource was served. [...]
> CORS defines a way in which a browser and server can interact to determine whether or not it is safe to allow the cross-origin request. It allows for more freedom and functionality than purely same-origin requests, but is more secure than simply allowing all cross-origin requests.

Source: [https://en.wikipedia.org/wiki/Cross-origin_resource_sharing](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)

openEO-based back-ends are usually hosted on a different domain / host than the client that is requesting data from the back-end. Therefore most requests to the back-end are blocked by all modern browsers. This leads to the problem that the JavaScript library and any browser-based application can't access back-ends. Therefore, all back-end providers SHOULD support CORS to enable browser-based applications to access back-ends. [CORS is a recommendation of the W3C organization](https://www.w3.org/TR/cors/). The following chapters will explain how back-end providers can implement CORS support.

**Tip**: Most servers can send the required headers and the responses to the OPTIONS requests automatically for all endpoints. Otherwise you may also use a proxy server to add the headers and OPTIONS responses.

## CORS headers

The following headers MUST be included with every response:

| Name                             | Description                                                  | Example |
| -------------------------------- | ------------------------------------------------------------ | ------- |
| Access-Control-Allow-Origin      | Allowed origin for the request, including protocol, host and port or `*` for all origins. It is RECOMMENDED to return the value `*` to allow requests from browser-based implementations such as the Web Editor. | `*` |
| Access-Control-Expose-Headers    | Some endpoints require to send additional HTTP response headers such as `OpenEO-Identifier` and `Location`. To make these headers available to browser-based clients, they MUST be white-listed with this CORS header. The following HTTP headers are white-listed by browsers and MUST NOT be included: `Cache-Control`, `Content-Language`, `Content-Length`, `Content-Type`, `Expires`, `Last-Modified` and `Pragma`. At least the following headers MUST be listed in this version of the openEO API: `Link`, `Location`, `OpenEO-Costs` and `OpenEO-Identifier`. | `Link, Location, OpenEO-Costs, OpenEO-Identifier` |



### Example request and response

Request:

```http
POST /api/v1/jobs HTTP/1.1
Host: openeo.example
Origin: https://company.example:8080
Authorization: Bearer basic//ZXhhbXBsZTpleGFtcGxl
```

Response:

```http
HTTP/1.1 201 Created
Access-Control-Allow-Origin: *
Access-Control-Expose-Headers: Location, OpenEO-Identifier, OpenEO-Costs, Link
Content-Type: application/json
Location: https://openeo.example/api/v1/jobs/abc123
OpenEO-Identifier: abc123
```

## OPTIONS method

All endpoints must respond to the `OPTIONS` HTTP method. This is a response for the preflight requests made by web browsers before sending the actual request (e.g. `POST /jobs`). It needs to respond with a status code of `204` and no response body.
**In addition** to the HTTP headers shown in the table above, the following HTTP headers MUST be included with every response to an `OPTIONS` request:

| Name                             | Description                                                  | Example |
| -------------------------------- | ------------------------------------------------------------ | ------- |
| Access-Control-Allow-Headers     | Comma-separated list of HTTP headers allowed to be sent with the actual (non-preflight) request. MUST contain at least `Authorization` if any kind of authorization is implemented by the back-end. | `Authorization, Content-Type` |
| Access-Control-Allow-Methods     | Comma-separated list of HTTP methods allowed to be requested. Back-ends MUST list all implemented HTTP methods for the endpoint. | `OPTIONS, GET, POST, PATCH, PUT, DELETE` |
| Content-Type                     | SHOULD return the content type delivered by the request that the permission is requested for. | `application/json` |

### Example request and response

Request:

```http
OPTIONS /api/v1/jobs HTTP/1.1
Host: openeo.example
Origin: https://company.example:8080
Access-Control-Request-Method: POST 
Access-Control-Request-Headers: Authorization, Content-Type
```

Note that the `Access-Control-Request-*` headers are automatically attached to the requests by the browsers.

Response:

```http
HTTP/1.1 204 No Content
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: OPTIONS, GET, POST, PATCH, PUT, DELETE
Access-Control-Allow-Headers: Authorization, Content-Type
Access-Control-Expose-Headers: Location, OpenEO-Identifier, OpenEO-Costs, Link
Content-Type: application/json
```

# Processes

A **process** is an operation that performs a specific task on a set of parameters and returns a result. An example is computing a statistical operation, such as mean or median, on selected EO data. A process is similar to a function or method in programming languages. In openEO, processes are used to build a chain of processes ([process graph](#section/Processes/Process-Graphs)), which can be applied to EO data to derive your own findings from the data.

A **predefined process** is a process provided by the *back-end*. There is a set of predefined processes by openEO to improve interoperability between back-ends.
Back-ends SHOULD follow these specifications whenever possible. Not all processes need to be implemented by all back-ends. See the **[process reference](https://processes.openeo.org)** for predefined processes.

A **user-defined process** is a process defined by the *user*. It can directly be part of another process graph or be stored as custom process on a back-end. Internally, it is a *process graph* with a variety of additional metadata.

A **process graph** chains specific process calls from the set of predefined and user-defined processes together. A process graph itself can be stored as a (user-defined) process again. Similarly to scripts in the context of programming, process graphs organize and automate the execution of one or more processes that could alternatively be executed individually. In a process graph, processes need to be specific, i.e. concrete values or \"placeholders\" for input parameters need to be specified. These values can be scalars, arrays, objects, references to parameters or previous computations or other process graphs.

## Defining Processes

Back-ends and users MAY define new proprietary processes for their domain. 

**Back-end providers** MUST follow the schema for predefined processes as in [`GET /processes`](#operation/list-processes) to define new processes. This includes:

* Choosing a intuitive process id, consisting of only letters (a-z), numbers and underscores. It MUST be unique across the predefined processes.
* Defining the parameters and their exact (JSON) schemes.
* Specifying the return value of a process also with a (JSON) schema.
* Providing examples or compliance tests.
* Trying to make the process universally usable so that other back-end providers or openEO can adopt it.

**Users** MUST follow the schema for user-defined processes as in [`GET /process_graphs/{process_graph_id}`](#operation/describe-custom-process) to define new processes. This includes:

* Choosing a intuitive name as process id, consisting of only letters (a-z), numbers and underscores. It MUST be unique per user across the user-defined processes.
* Defining the algorithm as a process graph.
* Optionally, specifying the additional metadata for processes.

If new process are potentially useful for other back-ends the openEO consortium is happily accepting [pull requests](https://github.com/Open-EO/openeo-processes/pulls) to include them in the list of predefined processes.

### Schemas

Each process parameter and the return values of a process define a schema that the value MUST comply to. The schemas are based on [JSON Schema draft-07](http://json-schema.org/).

Multiple custom keywords have been defined:
* `subtype` for more fine-grained data-types than JSON Schema supports.
* `dimensions` to further define the dimension types required if the `subtype` is `datacube`.
* `parameters` to specify the parameters of a process graph if the `subtype` is `process-graph`.
* `returns` to describe the return value of a process graph if the `subtype` is `process-graph`.

### Subtypes

JSON Schema allows to specify only a small set of native data types (string, boolean, number, integer, array, object, null).
To support more fine grained data types, a custom [JSON Schema keyword](https://json-schema.org/draft-07/json-schema-core.html#rfc.section.6.4) has been defined: `subtype`.
It works similarly as the JSON Schema keyword [`format`](https://json-schema.org/draft-07/json-schema-validation.html#rfc.section.7)
and standardizes a number of openEO related data types that extend the native data types, for example:
`bounding-box` (object with at least `west`, `south`, `east` and `north` properties),
`date-time` (string representation of date and time following RFC 3339),
`datacube` (a datacube with dimensions), etc.
The subtypes should be re-used in process schema definitions whenever suitable.

If a general data type such as `string` or `number` is used in a schema, all subtypes with the same parent data type can be passed, too.
Clients should offer make passing subtypes as easy as passing a general data type.
For example, a parameter accepting strings must also allow passing a string with subtype `date` and thus clients should encourage this by also providing a date-picker.

A list of predefined subtypes is available as JSON Schema in [openeo-processes](https://github.com/Open-EO/openeo-processes).

## Process Graphs

As defined above, a **process graph** is a chain of processes with explicit values for their parameters.
Technically, a process graph is defined to be a graph of connected processes with exactly one node returning the final result:

```
<ProcessGraph> := {
  \"<ProcessNodeIdentifier>\": <ProcessNode>,
  ...
}
```

`<ProcessNodeIdentifier>` is a unique key within the process graph that is used to reference (the return value of) this process in arguments of other processes. The identifier is unique only strictly within itself, excluding any parent and child process graphs. Process node identifiers are also strictly scoped and can not be referenced from child or parent process graphs. Circular references are not allowed.

Note: We provide a non-binding [JSON Schema for basic process graph validation](assets/pg-schema.json).

### Processes (Process Nodes)

A single node in a process graph (i.e. a specific instance of a process) is defined as follows:

```
<ProcessNode> := {
  \"process_id\": <string>,
  \"namespace\": <string> / null,
  \"description\": <string>,
  \"arguments\": <Arguments>,
  \"result\": true / false
}
```
A process node MUST always contain key-value-pairs named `process_id` and `arguments`. It MAY contain a `description`.

One of the nodes in a map of processes (the final one) MUST have the `result` flag set to `true`, all the other nodes can omit it as the default value is `false`. Having such a node is important as multiple end nodes are possible, but in most use cases it is important to exactly specify the return value to be used by other processes. Each child process graph must also specify a result node similar to the \"main\" process graph.

`process_id` MUST be a valid process ID in the `namespace` given. Clients SHOULD warn the user if a user-defined process is added with the same identifier as one of the predefined process.

### Arguments

A process can have an arbitrary number of arguments. Their name and value are specified 
in the process specification as an object of key-value pairs:

```
<Arguments> := {
  \"<ParameterName>\": <string|number|boolean|null|array|object|ResultReference|UserDefinedProcess|ParameterReference>
}
```

**Notes:**
- The specified data types are the native data types supported by JSON, except for `ResultReference`, `UserDefinedProcess` and `ParameterReference`.
- Objects are not allowed to have keys with the following reserved names:

    * `from_node`, except for objects of type `ResultReference`
    * `process_graph`, except for objects of type `UserDefinedProcess`
    * `from_parameter`, except for objects of type `ParameterReference`

- Arrays and objects can also contain a `ResultReference`, a `UserDefinedProcess` or a `ParameterReference`. So back-ends must *fully* traverse the process graphs, including all children.

### Accessing results of other process nodes

A value of type `<ResultReference>` is an object with a key `from_node` and a `<ProcessNodeIdentifier>` as corresponding value:

```
<ResultReference> := {
  \"from_node\": \"<ProcessNodeIdentifier>\"
}
```

This tells the back-end that the process expects the result (i.e. the return value) from another process node to be passed as argument.
The `<ProcessNodeIdentifier>` is strictly scoped and can only reference nodes from within the same process graph, not child or parent process graphs.

### Child processes

Some processes can run child processes, which is similar to the concept that other programming languages call
[callbacks](https://en.wikipedia.org/wiki/Callback_(computer_programming)) or lambda functions.
Each child process is simply a user-defined process again and can in theory be arbritarily complex.

A very simple example would be to calculate the absolute value of each pixel in a data cube.
This can be achieved in openEO by using the `apply` process which gets the `absolute` process passed as child process.
In this example, the \"child\" processes consists of a single process `absolute`, but it can also be a more complex computation such as an NDVI or a prediciton based on a machine learning model.

**Example**: 

A `<UserDefinedProcess>` argument MUST at least consist of an object with a key `process_graph`.
Optionally, it can also be described with the same additional properties available for predefined processes such as an id, parameters, return values etc.
When embedded in a process graph, these additional properties of a user-defined process are usually not used, except for validation purposes.

```
<UserDefinedProcess> := {
  \"process_graph\": <ProcessGraph>,
  ...
}
```

### Accessing process parameters

A \"parent\" process that works with a child process can make so called *process graph parameters*
available to the \"child\" logic.
Processes in the \"child\" process graph can access these parameters by passing a `ParameterReference` object as argument.
It is an object with key `from_parameter` specifying the name of the process graph parameter:

```
<ParameterReference> := {
  \"from_parameter\": \"<ParameterReferenceName>\"
}
```

The parameter names made available for `<ParameterReferenceName>` are defined and passed to the process graph by one of the parent entities.
The parent could be a process (such as `apply` or `reduce_dimension`) or something else that executes a process graph (a secondary web service for example).
If the parent is a process, the parameter are defined in the [`parameters` property](#section/Processes/Defining-Processes) of the corresponding JSON Schema.

In case of the example given above, the parameter `process` in the process [`apply`](https://processes.openeo.org/#apply) defines two process graph parameters: `x` (the value of each pixel that will be processed) and `context` (additional data passed through from the user).
The process `absolute` expects an argument with the same name `x`.
The process graph for the example would look as follows:

```
{
  \"process_id\": \"apply\",
  \"arguments\": {
    \"data\": {\"from_node\": \"loadcollection1\"}
    \"process\": {
      \"process_graph\": {
        \"abs1\": {
          \"process_id\": \"absolute\",
          \"arguments\": {
            \"x\": {\"from_parameter\": \"x\"}
          },
          \"result\": true
        }
      }
    }
  }
}
```

`loadcollection1` would be a result from another process, which is not part of this example.

**Important:** `<ParameterReferenceName>` is less strictly scoped than `<ProcessNodeIdentifier>`.
`<ParameterReferenceName>` can be any parameter from the process graph or any of its parents.

The value for the parameter MUST be resolved as follows:
1. In general the most specific parameter value is used. This means the parameter value is resolved starting from the current scope and then checking each parent for a suitable parameter value until a parameter values is found or the \"root\" process graph has been reached.
2. In case a parameter value is not available, the most unspecific default value from the process graph parameter definitions are used. For example, if default values are available for the root process graph and all children, the default value from the root process graph is used.
3. If no default values are available either, the error `ProcessParameterMissing` must be thrown.

### Full example for an EVI computation

Deriving minimum EVI (Enhanced Vegetation Index) measurements over pixel time series of Sentinel 2 imagery. The main process graph in blue, child process graphs in yellow:

![Graph with processing instructions](assets/pg-evi-example.png)

The process graph for the algorithm: [pg-evi-example.json](assets/pg-evi-example.json)

## Data Processing

Processes can run in three different ways:

1. Results can be pre-computed by creating a ***batch job***. They are submitted to the back-end's processing system, but will remain inactive until explicitly put into the processing queue. They will run only once and store results after execution. Results can be downloaded. Batch jobs are typically time consuming and user interaction is not possible although log files are generated for them. This is the only mode that allows to get an estimate about time, volume and costs beforehand.

2. A more dynamic way of processing and accessing data is to create a **secondary web service**. They allow web-based access using different protocols such as [OGC WMS](http://www.opengeospatial.org/standards/wms), [OGC WCS](http://www.opengeospatial.org/standards/wcs), [OGC API - Features](https://www.ogc.org/standards/ogcapi-features) or [XYZ tiles](https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames). Some protocols such as the OGC WMS or XYZ tiles allow users to change the viewing extent or level of detail (zoom level). Therefore, computations often run *on demand* so that the requested data is calculated during the request. Back-ends should make sure to cache processed data to avoid additional/high costs and reduce waiting times for the user.

3. Processes can also be executed **on-demand** (i.e. synchronously). Results are delivered with the request itself and no job is created. Only lightweight computations, for example previews, should be executed using this approach as timeouts are to be expected for [long-polling HTTP requests](https://www.pubnub.com/blog/2014-12-01-http-long-polling/).

### Validation

Process graph validation is a quite complex task. There's a [JSON schema](assets/pg-schema.json) for basic process graph validation. It checks the general structure of a process graph, but only checking against the schema is not fully validating a process graph. Note that this JSON Schema is probably good enough for a first version, but should be revised and improved for production. There are further steps to do:

1. Validate whether there's exactly one `result: true` per process graph.
2. Check whether the process names that are referenced in the field `process_id` are actually available in the corresponding `namespace`.
3. Validate all arguments for each process against the JSON schemas that are specified in the corresponding process specifications.
4. Check whether the values specified for `from_node` have a corresponding node in the same process graph.
5. Validate whether the return value and the arguments requesting a return value with `from_node` are compatible.
7. Check the content of arrays and objects. These could include parameter and result references (`from_node`, `from_parameter` etc.).


### Execution

To process the process graph on the back-end you need to go through all nodes/processes in the list and set for each node to which node it passes data and from which it expects data. In another iteration the back-end can find all start nodes for processing by checking for zero dependencies.

You can now start and execute the start nodes (in parallel, if possible). Results can be passed to the nodes that were identified beforehand. For each node that depends on multiple inputs you need to check whether all dependencies have already finished and only execute once the last dependency is ready.

Please be aware that the result node (`result` set to `true`) is not necessarily the last node that is executed. The author of the process graph may choose to set a non-end node to the result node!

## Overview
This API client was generated by the [OpenAPI Generator](https://openapi-generator.tech) project.  By using the [openapi-spec](https://openapis.org) from a remote server, you can easily generate an API client.

- API version: 1.2.0
- Build package: org.openapitools.codegen.languages.JuliaClientCodegen
For more information, please visit [https://openeo.org](https://openeo.org)


## Installation
Place the Julia files generated under the `src` folder in your Julia project. Include APIClient.jl in the project code.
It would include the module named APIClient.

Documentation is generated as markdown files under the `docs` folder. You can include them in your project documentation.
Documentation is also embedded in Julia which can be used with a Julia specific documentation generator.

## API Endpoints

Class | Method
------------ | -------------
*AccountManagementApi* | [**authenticate_basic**](docs/AccountManagementApi.md#authenticate_basic)<br/>**GET** /credentials/basic<br/>HTTP Basic authentication
*AccountManagementApi* | [**authenticate_oidc**](docs/AccountManagementApi.md#authenticate_oidc)<br/>**GET** /credentials/oidc<br/>OpenID Connect authentication
*AccountManagementApi* | [**describe_account**](docs/AccountManagementApi.md#describe_account)<br/>**GET** /me<br/>Information about the authenticated user
*BatchJobsApi* | [**create_job**](docs/BatchJobsApi.md#create_job)<br/>**POST** /jobs<br/>Create a new batch job
*BatchJobsApi* | [**debug_job**](docs/BatchJobsApi.md#debug_job)<br/>**GET** /jobs/{job_id}/logs<br/>Logs for a batch job
*BatchJobsApi* | [**delete_job**](docs/BatchJobsApi.md#delete_job)<br/>**DELETE** /jobs/{job_id}<br/>Delete a batch job
*BatchJobsApi* | [**describe_job**](docs/BatchJobsApi.md#describe_job)<br/>**GET** /jobs/{job_id}<br/>Full metadata for a batch job
*BatchJobsApi* | [**estimate_job**](docs/BatchJobsApi.md#estimate_job)<br/>**GET** /jobs/{job_id}/estimate<br/>Get an estimate for a batch job
*BatchJobsApi* | [**list_jobs**](docs/BatchJobsApi.md#list_jobs)<br/>**GET** /jobs<br/>List all batch jobs
*BatchJobsApi* | [**list_results**](docs/BatchJobsApi.md#list_results)<br/>**GET** /jobs/{job_id}/results<br/>List batch job results
*BatchJobsApi* | [**start_job**](docs/BatchJobsApi.md#start_job)<br/>**POST** /jobs/{job_id}/results<br/>Start processing a batch job
*BatchJobsApi* | [**stop_job**](docs/BatchJobsApi.md#stop_job)<br/>**DELETE** /jobs/{job_id}/results<br/>Cancel processing a batch job
*BatchJobsApi* | [**update_job**](docs/BatchJobsApi.md#update_job)<br/>**PATCH** /jobs/{job_id}<br/>Modify a batch job
*CapabilitiesApi* | [**capabilities**](docs/CapabilitiesApi.md#capabilities)<br/>**GET** /<br/>Information about the back-end
*CapabilitiesApi* | [**conformance**](docs/CapabilitiesApi.md#conformance)<br/>**GET** /conformance<br/>Conformance classes this API implements
*CapabilitiesApi* | [**connect**](docs/CapabilitiesApi.md#connect)<br/>**GET** /.well-known/openeo<br/>Supported openEO versions
*CapabilitiesApi* | [**list_file_types**](docs/CapabilitiesApi.md#list_file_types)<br/>**GET** /file_formats<br/>Supported file formats
*CapabilitiesApi* | [**list_service_types**](docs/CapabilitiesApi.md#list_service_types)<br/>**GET** /service_types<br/>Supported secondary web service protocols
*CapabilitiesApi* | [**list_udf_runtimes**](docs/CapabilitiesApi.md#list_udf_runtimes)<br/>**GET** /udf_runtimes<br/>Supported UDF runtimes
*DataProcessingApi* | [**compute_result**](docs/DataProcessingApi.md#compute_result)<br/>**POST** /result<br/>Process and download data synchronously
*DataProcessingApi* | [**create_job**](docs/DataProcessingApi.md#create_job)<br/>**POST** /jobs<br/>Create a new batch job
*DataProcessingApi* | [**debug_job**](docs/DataProcessingApi.md#debug_job)<br/>**GET** /jobs/{job_id}/logs<br/>Logs for a batch job
*DataProcessingApi* | [**delete_job**](docs/DataProcessingApi.md#delete_job)<br/>**DELETE** /jobs/{job_id}<br/>Delete a batch job
*DataProcessingApi* | [**describe_job**](docs/DataProcessingApi.md#describe_job)<br/>**GET** /jobs/{job_id}<br/>Full metadata for a batch job
*DataProcessingApi* | [**estimate_job**](docs/DataProcessingApi.md#estimate_job)<br/>**GET** /jobs/{job_id}/estimate<br/>Get an estimate for a batch job
*DataProcessingApi* | [**list_file_types**](docs/DataProcessingApi.md#list_file_types)<br/>**GET** /file_formats<br/>Supported file formats
*DataProcessingApi* | [**list_jobs**](docs/DataProcessingApi.md#list_jobs)<br/>**GET** /jobs<br/>List all batch jobs
*DataProcessingApi* | [**list_results**](docs/DataProcessingApi.md#list_results)<br/>**GET** /jobs/{job_id}/results<br/>List batch job results
*DataProcessingApi* | [**start_job**](docs/DataProcessingApi.md#start_job)<br/>**POST** /jobs/{job_id}/results<br/>Start processing a batch job
*DataProcessingApi* | [**stop_job**](docs/DataProcessingApi.md#stop_job)<br/>**DELETE** /jobs/{job_id}/results<br/>Cancel processing a batch job
*DataProcessingApi* | [**update_job**](docs/DataProcessingApi.md#update_job)<br/>**PATCH** /jobs/{job_id}<br/>Modify a batch job
*DataProcessingApi* | [**validate_custom_process**](docs/DataProcessingApi.md#validate_custom_process)<br/>**POST** /validation<br/>Validate a user-defined process (graph)
*EODataDiscoveryApi* | [**describe_collection**](docs/EODataDiscoveryApi.md#describe_collection)<br/>**GET** /collections/{collection_id}<br/>Full metadata for a specific dataset
*EODataDiscoveryApi* | [**list_collection_queryables**](docs/EODataDiscoveryApi.md#list_collection_queryables)<br/>**GET** /collections/{collection_id}/queryables<br/>Metadata filters for a specific dataset
*EODataDiscoveryApi* | [**list_collections**](docs/EODataDiscoveryApi.md#list_collections)<br/>**GET** /collections<br/>Basic metadata for all datasets
*FileStorageApi* | [**delete_file**](docs/FileStorageApi.md#delete_file)<br/>**DELETE** /files/{path}<br/>Delete a file from the workspace
*FileStorageApi* | [**download_file**](docs/FileStorageApi.md#download_file)<br/>**GET** /files/{path}<br/>Download a file from the workspace
*FileStorageApi* | [**list_files**](docs/FileStorageApi.md#list_files)<br/>**GET** /files<br/>List all files in the workspace
*FileStorageApi* | [**upload_file**](docs/FileStorageApi.md#upload_file)<br/>**PUT** /files/{path}<br/>Upload a file to the workspace
*ProcessDiscoveryApi* | [**describe_custom_process**](docs/ProcessDiscoveryApi.md#describe_custom_process)<br/>**GET** /process_graphs/{process_graph_id}<br/>Full metadata for a user-defined process
*ProcessDiscoveryApi* | [**list_custom_processes**](docs/ProcessDiscoveryApi.md#list_custom_processes)<br/>**GET** /process_graphs<br/>List all user-defined processes
*ProcessDiscoveryApi* | [**list_processes**](docs/ProcessDiscoveryApi.md#list_processes)<br/>**GET** /processes<br/>Supported predefined processes
*SecondaryServicesApi* | [**create_service**](docs/SecondaryServicesApi.md#create_service)<br/>**POST** /services<br/>Publish a new service
*SecondaryServicesApi* | [**debug_service**](docs/SecondaryServicesApi.md#debug_service)<br/>**GET** /services/{service_id}/logs<br/>Logs for a secondary service
*SecondaryServicesApi* | [**delete_service**](docs/SecondaryServicesApi.md#delete_service)<br/>**DELETE** /services/{service_id}<br/>Delete a service
*SecondaryServicesApi* | [**describe_service**](docs/SecondaryServicesApi.md#describe_service)<br/>**GET** /services/{service_id}<br/>Full metadata for a service
*SecondaryServicesApi* | [**list_service_types**](docs/SecondaryServicesApi.md#list_service_types)<br/>**GET** /service_types<br/>Supported secondary web service protocols
*SecondaryServicesApi* | [**list_services**](docs/SecondaryServicesApi.md#list_services)<br/>**GET** /services<br/>List all web services
*SecondaryServicesApi* | [**update_service**](docs/SecondaryServicesApi.md#update_service)<br/>**PATCH** /services/{service_id}<br/>Modify a service
*UserDefinedProcessesApi* | [**delete_custom_process**](docs/UserDefinedProcessesApi.md#delete_custom_process)<br/>**DELETE** /process_graphs/{process_graph_id}<br/>Delete a user-defined process
*UserDefinedProcessesApi* | [**describe_custom_process**](docs/UserDefinedProcessesApi.md#describe_custom_process)<br/>**GET** /process_graphs/{process_graph_id}<br/>Full metadata for a user-defined process
*UserDefinedProcessesApi* | [**list_custom_processes**](docs/UserDefinedProcessesApi.md#list_custom_processes)<br/>**GET** /process_graphs<br/>List all user-defined processes
*UserDefinedProcessesApi* | [**store_custom_process**](docs/UserDefinedProcessesApi.md#store_custom_process)<br/>**PUT** /process_graphs/{process_graph_id}<br/>Store a user-defined process
*UserDefinedProcessesApi* | [**validate_custom_process**](docs/UserDefinedProcessesApi.md#validate_custom_process)<br/>**POST** /validation<br/>Validate a user-defined process (graph)


## Models

 - [APIInstance](docs/APIInstance.md)
 - [Asset](docs/Asset.md)
 - [BaseParameter](docs/BaseParameter.md)
 - [BatchJob](docs/BatchJob.md)
 - [BatchJobEstimate](docs/BatchJobEstimate.md)
 - [BatchJobResult](docs/BatchJobResult.md)
 - [BatchJobResultGeometry](docs/BatchJobResultGeometry.md)
 - [BatchJobResultsResponseAsSTACCollection](docs/BatchJobResultsResponseAsSTACCollection.md)
 - [BatchJobUsage](docs/BatchJobUsage.md)
 - [BatchJobs](docs/BatchJobs.md)
 - [Billing](docs/Billing.md)
 - [BillingPlan](docs/BillingPlan.md)
 - [Capabilities](docs/Capabilities.md)
 - [Collection](docs/Collection.md)
 - [CollectionDimensionSrs](docs/CollectionDimensionSrs.md)
 - [CollectionDimensionValuesInner](docs/CollectionDimensionValuesInner.md)
 - [CollectionExtent](docs/CollectionExtent.md)
 - [CollectionSpatialExtent](docs/CollectionSpatialExtent.md)
 - [CollectionSummaryStats](docs/CollectionSummaryStats.md)
 - [CollectionSummaryStatsMaximum](docs/CollectionSummaryStatsMaximum.md)
 - [CollectionSummaryStatsMinimum](docs/CollectionSummaryStatsMinimum.md)
 - [CollectionTemporalExtent](docs/CollectionTemporalExtent.md)
 - [Collections](docs/Collections.md)
 - [DataTypeSchema](docs/DataTypeSchema.md)
 - [DatacubeJsonSchema](docs/DatacubeJsonSchema.md)
 - [DefaultOpenIDConnectClient](docs/DefaultOpenIDConnectClient.md)
 - [DescribeCollection200Response](docs/DescribeCollection200Response.md)
 - [DescribeJob200Response](docs/DescribeJob200Response.md)
 - [DescribeService200Response](docs/DescribeService200Response.md)
 - [Dimension](docs/Dimension.md)
 - [DimensionAxisXyz](docs/DimensionAxisXyz.md)
 - [DimensionBands](docs/DimensionBands.md)
 - [DimensionGeometry](docs/DimensionGeometry.md)
 - [DimensionOther](docs/DimensionOther.md)
 - [DimensionSpatial](docs/DimensionSpatial.md)
 - [DimensionSpatialHorizontal](docs/DimensionSpatialHorizontal.md)
 - [DimensionSpatialVertical](docs/DimensionSpatialVertical.md)
 - [DimensionTemporal](docs/DimensionTemporal.md)
 - [Endpoint](docs/Endpoint.md)
 - [Error](docs/Error.md)
 - [File](docs/File.md)
 - [FileFormat](docs/FileFormat.md)
 - [FileFormats](docs/FileFormats.md)
 - [GeoJson](docs/GeoJson.md)
 - [GeoJsonFeature](docs/GeoJsonFeature.md)
 - [GeoJsonFeatureCollection](docs/GeoJsonFeatureCollection.md)
 - [GeoJsonGeometry](docs/GeoJsonGeometry.md)
 - [GeoJsonGeometryCollection](docs/GeoJsonGeometryCollection.md)
 - [GeoJsonLineString](docs/GeoJsonLineString.md)
 - [GeoJsonMultiLineString](docs/GeoJsonMultiLineString.md)
 - [GeoJsonMultiPoint](docs/GeoJsonMultiPoint.md)
 - [GeoJsonMultiPolygon](docs/GeoJsonMultiPolygon.md)
 - [GeoJsonPoint](docs/GeoJsonPoint.md)
 - [GeoJsonPolygon](docs/GeoJsonPolygon.md)
 - [GeometryType](docs/GeometryType.md)
 - [HTTPBasicAccessToken](docs/HTTPBasicAccessToken.md)
 - [ItemProperties](docs/ItemProperties.md)
 - [JsonSchema](docs/JsonSchema.md)
 - [JsonSchemaItems](docs/JsonSchemaItems.md)
 - [JsonSchemaType](docs/JsonSchemaType.md)
 - [JsonSchemaType1](docs/JsonSchemaType1.md)
 - [Link](docs/Link.md)
 - [ListResults200Response](docs/ListResults200Response.md)
 - [LogEntries](docs/LogEntries.md)
 - [LogEntry](docs/LogEntry.md)
 - [LogEntryPathInner](docs/LogEntryPathInner.md)
 - [LogLevel](docs/LogLevel.md)
 - [MinLogLevelDefault](docs/MinLogLevelDefault.md)
 - [MinLogLevelUpdate](docs/MinLogLevelUpdate.md)
 - [OGCConformanceClasses](docs/OGCConformanceClasses.md)
 - [ObjectRestricted](docs/ObjectRestricted.md)
 - [OpenIDConnectProvider](docs/OpenIDConnectProvider.md)
 - [OpenIDConnectProviders](docs/OpenIDConnectProviders.md)
 - [Parameter](docs/Parameter.md)
 - [ParameterReference](docs/ParameterReference.md)
 - [PredefinedProcess](docs/PredefinedProcess.md)
 - [Process](docs/Process.md)
 - [ProcessArgumentValue](docs/ProcessArgumentValue.md)
 - [ProcessExample](docs/ProcessExample.md)
 - [ProcessExceptions](docs/ProcessExceptions.md)
 - [ProcessGraph](docs/ProcessGraph.md)
 - [ProcessGraphJsonSchema](docs/ProcessGraphJsonSchema.md)
 - [ProcessGraphReturnValue](docs/ProcessGraphReturnValue.md)
 - [ProcessGraphWithMetadata](docs/ProcessGraphWithMetadata.md)
 - [ProcessJsonSchema](docs/ProcessJsonSchema.md)
 - [ProcessParameter](docs/ProcessParameter.md)
 - [ProcessReturnValue](docs/ProcessReturnValue.md)
 - [ProcessSchema](docs/ProcessSchema.md)
 - [Processes](docs/Processes.md)
 - [ProgrammingLanguageLibrary](docs/ProgrammingLanguageLibrary.md)
 - [ProgrammingLanguageVersion](docs/ProgrammingLanguageVersion.md)
 - [Provider](docs/Provider.md)
 - [ResourceParameter](docs/ResourceParameter.md)
 - [ResourceUsageMetrics](docs/ResourceUsageMetrics.md)
 - [ResultReference](docs/ResultReference.md)
 - [ResultStatus](docs/ResultStatus.md)
 - [STACCollectionCubeDimensions](docs/STACCollectionCubeDimensions.md)
 - [STACSummariesCollectionProperties](docs/STACSummariesCollectionProperties.md)
 - [SecondaryWebServices](docs/SecondaryWebServices.md)
 - [Service](docs/Service.md)
 - [ServiceTypes](docs/ServiceTypes.md)
 - [ServiceUsage](docs/ServiceUsage.md)
 - [StacExtensionsInner](docs/StacExtensionsInner.md)
 - [StoreBatchJobRequest](docs/StoreBatchJobRequest.md)
 - [StoreSecondaryWebServiceRequest](docs/StoreSecondaryWebServiceRequest.md)
 - [SynchronousResultRequest](docs/SynchronousResultRequest.md)
 - [UDFRuntimes](docs/UDFRuntimes.md)
 - [UdfDocker](docs/UdfDocker.md)
 - [UdfProgrammingLanguage](docs/UdfProgrammingLanguage.md)
 - [UdfRuntime](docs/UdfRuntime.md)
 - [UpdateBatchJobRequest](docs/UpdateBatchJobRequest.md)
 - [UpdateSecondaryWebServiceRequest](docs/UpdateSecondaryWebServiceRequest.md)
 - [Usage](docs/Usage.md)
 - [UsageCpu](docs/UsageCpu.md)
 - [UsageDisk](docs/UsageDisk.md)
 - [UsageDuration](docs/UsageDuration.md)
 - [UsageMemory](docs/UsageMemory.md)
 - [UsageMetric](docs/UsageMetric.md)
 - [UsageNetwork](docs/UsageNetwork.md)
 - [UsageStorage](docs/UsageStorage.md)
 - [UserData](docs/UserData.md)
 - [UserDefinedProcess](docs/UserDefinedProcess.md)
 - [UserDefinedProcessMeta](docs/UserDefinedProcessMeta.md)
 - [UserDefinedProcesses](docs/UserDefinedProcesses.md)
 - [UserStorage](docs/UserStorage.md)
 - [ValidationResult](docs/ValidationResult.md)
 - [WellKnownDiscovery](docs/WellKnownDiscovery.md)
 - [WorkspaceFiles](docs/WorkspaceFiles.md)


<a id="authorization"></a>
## Authorization

Authentication schemes defined for the API:
<a id="Bearer"></a>
### Bearer
- **Type**: HTTP Bearer Token authentication (The Bearer Token MUST consist of the authentication method, a provider ID (if available) and the token itself. All separated by a forward slash `/`. Examples (replace `TOKEN` with the actual access token): (1) Basic authentication (no provider ID available): `basic//TOKEN` (2) OpenID Connect (provider ID is `ms`): `oidc/ms/TOKEN`. For OpenID Connect, the provider ID corresponds to the value specified for `id` for each provider in `GET /credentials/oidc`.)
<a id="Basic"></a>
### Basic
- **Type**: HTTP basic authentication

Example
```
    using OpenAPI
    using OpenAPI.Clients
    import OpenAPI.Clients: Client, set_header
    client = Client(server_uri)
    set_header(client, "Authorization", "Basic $basic_auth")
    api = MyApi(client)
    result = callApi(api, args...; api_key)
```

## Author

openeo.psc@uni-muenster.de

