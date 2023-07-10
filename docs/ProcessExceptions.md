# ProcessExceptions


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**description** | **String** | Detailed description to explain the error to client users and back-end developers. This should not be shown in the clients directly, but MAY be linked to in the errors &#x60;url&#x60; property.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. | [optional] [default to nothing]
**message** | **String** | Explains the reason the server is rejecting the request. This message is intended to be displayed to the client user. For \&quot;4xx\&quot; error codes the message SHOULD explain shortly how the client needs to modify the request.  The message MAY contain variables, which are enclosed by curly brackets. Example: &#x60;{variable_name}&#x60; | [default to nothing]
**http** | **Int64** | HTTP Status Code, following the [error handling conventions in openEO](#section/API-Principles/Error-Handling). Defaults to &#x60;400&#x60;. | [optional] [default to 400]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


