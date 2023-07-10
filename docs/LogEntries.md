# LogEntries


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**level** | **String** | The minimum severity level for log entries that the back-end returns. This property MUST reflect the effective lowest &#x60;level&#x60; that may appear in the document, which is (if implemented) the highest level of: 1. the &#x60;log_level&#x60; specified by the user for the processing request. 2. the &#x60;level&#x60; specified by the user for the log request.  The order of the levels is as follows (from low to high severity): &#x60;debug&#x60;, &#x60;info&#x60;, &#x60;warning&#x60;, &#x60;error&#x60;. That means if &#x60;warning&#x60; is set, the logs will only contain entries with the level &#x60;warning&#x60; and &#x60;error&#x60;. | [optional] [default to debug]
**logs** | [**Vector{LogEntry}**](LogEntry.md) | A chronological list of logs. | [default to nothing]
**links** | [**Vector{Link}**](Link.md) | Links related to this list of resources, for example links for pagination or alternative formats such as a human-readable HTML version. The links array MUST NOT be paginated.  If pagination is implemented, the following &#x60;rel&#x60; (relation) types apply:  1. &#x60;next&#x60; (REQUIRED): A link to the next page, except on the last page.  2. &#x60;prev&#x60; (OPTIONAL): A link to the previous page, except on the first page.  3. &#x60;first&#x60; (OPTIONAL): A link to the first page, except on the first page.  4. &#x60;last&#x60; (OPTIONAL): A link to the last page, except on the last page.  For additional relation types see also the lists of [common relation types in openEO](#section/API-Principles/Web-Linking). | [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


