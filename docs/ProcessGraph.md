# ProcessGraph


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**process_id** | **String** | The identifier for the process. It MUST be unique across its namespace (e.g. predefined processes or user-defined processes).  Clients SHOULD warn the user if a user-defined process is added with the  same identifier as one of the predefined process. | [default to nothing]
**namespace** | **String** | The namespace the &#x60;process_id&#x60; is valid for.  The following options are predefined by the openEO API, but additional namespaces may be introduced by back-ends or in a future version of the API.  * &#x60;null&#x60; (default): Checks both user-defined and predefined processes,    but prefers user-defined processes if both are available.    This allows users to add missing predefined processes for portability,    e.g. common processes from [processes.openeo.org](https://processes.openeo.org)    that have a process graph included.    It is RECOMMENDED to log the namespace selected by the back-end for debugging purposes. * &#x60;backend&#x60;: Uses exclusively the predefined processes listed at &#x60;GET /processes&#x60;. * &#x60;user&#x60;: Uses exclusively the user-defined processes listed at &#x60;GET /process_graphs&#x60;.  If multiple processes with the same identifier exist, Clients SHOULD inform the user that it&#39;s recommended to select a namespace. | [optional] [default to nothing]
**result** | **Bool** | Used to specify which node is the last in the chain and returns the result to return to the requesting context. This flag MUST only be set once in each list of process nodes. | [optional] [default to false]
**description** | **String** | Optional description about the process and its arguments. | [optional] [default to nothing]
**arguments** | [**Dict{String, ProcessArgumentValue}**](ProcessArgumentValue.md) |  | [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


