# LogEntry


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | An unique identifier for the log message, could simply be an incrementing number. | [default to nothing]
**code** | **String** | The code is either one of the standardized error codes or a custom code, for example specified by a user in the &#x60;inspect&#x60; process. | [optional] [default to nothing]
**level** | [***LogLevel**](LogLevel.md) |  | [default to nothing]
**message** | **String** | A concise message explaining the log entry. Messages do *not* explicitly support [CommonMark 0.29](http://commonmark.org/) syntax as other descriptive fields in the openEO API do, but the messages MAY contain line breaks or indentation. It is NOT RECOMMENDED to add stacktraces to the &#x60;message&#x60;. | [default to nothing]
**time** | **ZonedDateTime** | The date and time the event happened, in UTC. Formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time. | [optional] [default to nothing]
**data** | **Any** | Data of any type. It is the back-ends task to decide how to best present passed data to a user.  For example, a datacube passed to the &#x60;inspect&#x60; SHOULD return the metadata similar to the collection metadata, including &#x60;cube:dimensions&#x60;. There are implementation guidelines available for the &#x60;inspect&#x60; process. | [optional] [default to nothing]
**path** | [**Vector{LogEntryPathInner}**](LogEntryPathInner.md) | Describes where the log entry originates from.  The first element of the array is the process that has triggered the log entry, the second element is the parent of the process that has triggered the log entry, etc. This pattern is followed until the root of the process graph. | [optional] [default to nothing]
**usage** | [***Usage**](Usage.md) |  | [optional] [default to nothing]
**links** | [**Vector{Link}**](Link.md) | Links related to this log entry / error, e.g. to a resource that provides further explanations.  For relation types see the lists of [common relation types in openEO](#section/API-Principles/Web-Linking). | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


