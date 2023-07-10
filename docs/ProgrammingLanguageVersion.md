# ProgrammingLanguageVersion


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**deprecated** | **Bool** | Declares that the specified entity is deprecated with the potential to be removed in any of the next versions. It should be transitioned out of usage as soon as possible and users should refrain from using it in new implementations. | [optional] [default to false]
**experimental** | **Bool** | Declares that the specified entity is experimental, which means that it is likely to change or may produce unpredictable behaviour. Users should refrain from using it in production, but still feel encouraged to try it out and give feedback. | [optional] [default to false]
**libraries** | [**Dict{String, ProgrammingLanguageLibrary}**](ProgrammingLanguageLibrary.md) | Map of installed libraries, modules, packages or extensions for the programming language. The names of them are used as the property keys. | [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


