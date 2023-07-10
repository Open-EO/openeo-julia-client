# File


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**path** | **String** | Path of the file, relative to the root directory of the user&#39;s server-side workspace. MUST NOT start with a slash &#x60;/&#x60; and MUST NOT be url-encoded.  The Windows-style path name component separator &#x60;\\&#x60; is not supported, always use &#x60;/&#x60; instead.  Note: The pattern only specifies a minimal subset of invalid characters. The back-ends MAY enforce additional restrictions depending on their OS/environment. | [default to nothing]
**size** | **Int64** | File size in bytes. | [optional] [default to nothing]
**modified** | **ZonedDateTime** | Date and time the file has lastly been modified, formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time. | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


