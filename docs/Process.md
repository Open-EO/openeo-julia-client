# Process


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | The identifier for the process. It MUST be unique across its namespace (e.g. predefined processes or user-defined processes).  Clients SHOULD warn the user if a user-defined process is added with the  same identifier as one of the predefined process. | [optional] [default to nothing]
**summary** | **String** | A short summary of what the process does. | [optional] [default to nothing]
**description** | **String** | Detailed description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. In addition to the CommonMark syntax, clients can convert process IDs that are formatted as in the following example into links instead of code blocks: &#x60;&#x60;&#x60; &#x60;&#x60;process_id()&#x60;&#x60; &#x60;&#x60;&#x60; | [optional] [default to nothing]
**categories** | **Vector{String}** | A list of categories. | [optional] [default to nothing]
**parameters** | [**Vector{ProcessParameter}**](ProcessParameter.md) | A list of parameters.  The order in the array corresponds to the parameter order to be used in clients that don&#39;t support named parameters.  **Note:** Specifying an empty array is different from (if allowed) &#x60;null&#x60; or the property being absent. An empty array means the process has no parameters. &#x60;null&#x60; / property absent means that the parameters are unknown as the user has not specified them. There could still be parameters in the process graph, if one is specified. | [optional] [default to nothing]
**returns** | [***ProcessReturnValue**](ProcessReturnValue.md) |  | [optional] [default to nothing]
**deprecated** | **Bool** | Declares that the specified entity is deprecated with the potential to be removed in any of the next versions. It should be transitioned out of usage as soon as possible and users should refrain from using it in new implementations. | [optional] [default to false]
**experimental** | **Bool** | Declares that the specified entity is experimental, which means that it is likely to change or may produce unpredictable behaviour. Users should refrain from using it in production, but still feel encouraged to try it out and give feedback. | [optional] [default to false]
**exceptions** | [**Dict{String, ProcessExceptions}**](ProcessExceptions.md) | Declares exceptions (errors) that might occur during execution of this process. This list is just for informative purposes and may be incomplete. This list MUST only contain exceptions that stop the execution of a process and MUST NOT contain warnings, notices or debugging messages. It is meant to primarily contain errors that have been caused by the user. It is RECOMMENDED that exceptions are referred to and explained in process or parameter descriptions.  The keys define the error code and MUST match the following pattern: &#x60;^\\w+$&#x60;  This schema follows the schema of the general openEO error list (see errors.json). | [optional] [default to nothing]
**examples** | [**Vector{ProcessExample}**](ProcessExample.md) | Examples, may be used for unit tests. | [optional] [default to nothing]
**links** | [**Vector{Link}**](Link.md) | Links related to this process, e.g. additional external documentation.  It is RECOMMENDED to provide links with the following &#x60;rel&#x60; (relation) types:  1. &#x60;latest-version&#x60;: If a process has been marked as deprecated, a link SHOULD point to the preferred version of the process. The relation types &#x60;predecessor-version&#x60; (link to older version) and &#x60;successor-version&#x60; (link to newer version) can also be used to show the relation between versions.  2. &#x60;example&#x60;: Links to examples of other processes that use this process.  3. &#x60;cite-as&#x60;: For all DOIs associated with the process, the respective DOI links SHOULD be added.  For additional relation types see also the lists of [common relation types in openEO](#section/API-Principles/Web-Linking). | [optional] [default to nothing]
**process_graph** | [**Dict{String, ProcessGraph}**](ProcessGraph.md) | A process graph defines a graph-like structure as a connected set of executable processes. Each key is a unique identifier (node ID) that is used to refer to the process in the graph. | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


