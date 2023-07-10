# UDFRuntimes


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **String** | A human-readable short title to be displayed to users **in addition** to the names specified in the keys. This property is only for better user experience so that users can understand the names better. Example titles could be &#x60;GeoTiff&#x60; for the key &#x60;GTiff&#x60; (for file formats) or &#x60;OGC Web Map Service&#x60; for the key &#x60;WMS&#x60; (for service types). The title MUST NOT be used in communication (e.g. in process graphs), although clients MAY translate the titles into the corresponding names. | [optional] [default to nothing]
**description** | **String** | Detailed description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. | [optional] [default to nothing]
**type** | **String** | The type of the UDF runtime.  Predefined types are: * &#x60;language&#x60; for Programming Languages and * &#x60;docker&#x60; for Docker Containers.  The types can potentially be extended by back-ends. | [default to nothing]
**default** | **String** |  | [default to nothing]
**deprecated** | **Bool** | Declares that the specified entity is deprecated with the potential to be removed in any of the next versions. It should be transitioned out of usage as soon as possible and users should refrain from using it in new implementations. | [optional] [default to false]
**experimental** | **Bool** | Declares that the specified entity is experimental, which means that it is likely to change or may produce unpredictable behaviour. Users should refrain from using it in production, but still feel encouraged to try it out and give feedback. | [optional] [default to false]
**links** | [**Vector{Link}**](Link.md) | Links related to this runtime, e.g. external documentation.  It is highly RECOMMENDED to provide at least links with the following &#x60;rel&#x60; (relation) types:  1. &#x60;about&#x60;: A resource that further explains the runtime, e.g. a user guide or the documentation. It is RECOMMENDED to  add descriptive titles for a better user experience.  For additional relation types see also the lists of [common relation types in openEO](#section/API-Principles/Web-Linking). | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


