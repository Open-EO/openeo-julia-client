# ProgrammingLanguageLibrary


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**version** | **String** | Version number of the library. | [default to nothing]
**deprecated** | **Bool** | Declares that the specified entity is deprecated with the potential to be removed in any of the next versions. It should be transitioned out of usage as soon as possible and users should refrain from using it in new implementations. | [optional] [default to false]
**experimental** | **Bool** | Declares that the specified entity is experimental, which means that it is likely to change or may produce unpredictable behaviour. Users should refrain from using it in production, but still feel encouraged to try it out and give feedback. | [optional] [default to false]
**links** | [**Vector{Link}**](Link.md) | Additional links related to this library, e.g. external documentation for this library.  It is highly RECOMMENDED to provide links with the following &#x60;rel&#x60; (relation) types:  1. &#x60;about&#x60;: A resource that further explains the library, e.g. a user guide or the documentation. It is RECOMMENDED to  add descriptive titles for a better user experience.  2. &#x60;latest-version&#x60;: If a library has been marked as deprecated, a link SHOULD point to either a new library replacing the deprecated library or a latest version of the library available at the back-end.  For additional relation types see also the lists of [common relation types in openEO](#section/API-Principles/Web-Linking). | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


