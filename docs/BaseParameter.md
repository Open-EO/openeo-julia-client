# BaseParameter


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** | A unique name for the parameter.   It is RECOMMENDED to use [snake case](https://en.wikipedia.org/wiki/Snake_case) (e.g. &#x60;window_size&#x60; or &#x60;scale_factor&#x60;). | [default to nothing]
**description** | **String** | Detailed description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. In addition to the CommonMark syntax, clients can convert process IDs that are formatted as in the following example into links instead of code blocks: &#x60;&#x60;&#x60; &#x60;&#x60;process_id()&#x60;&#x60; &#x60;&#x60;&#x60; | [default to nothing]
**optional** | **Bool** | Determines whether this parameter is optional to be specified even when no default is specified. Clients SHOULD automatically set this parameter to &#x60;true&#x60;, if a default value is specified. Back-ends SHOULD NOT fail, if a default value is specified and this flag is missing. | [optional] [default to false]
**deprecated** | **Bool** | Declares that the specified entity is deprecated with the potential to be removed in any of the next versions. It should be transitioned out of usage as soon as possible and users should refrain from using it in new implementations. | [optional] [default to false]
**experimental** | **Bool** | Declares that the specified entity is experimental, which means that it is likely to change or may produce unpredictable behaviour. Users should refrain from using it in production, but still feel encouraged to try it out and give feedback. | [optional] [default to false]
**default** | **Any** | The default value for this parameter. Required parameters SHOULD NOT specify a default value. Optional parameters SHOULD always specify a default value. | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


