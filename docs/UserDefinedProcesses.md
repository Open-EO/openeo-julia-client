# UserDefinedProcesses


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**processes** | [**Vector{UserDefinedProcessMeta}**](UserDefinedProcessMeta.md) | Array of user-defined processes | [default to nothing]
**links** | [**Vector{Link}**](Link.md) | Links related to this list of resources, for example links for pagination or alternative formats such as a human-readable HTML version. The links array MUST NOT be paginated.  If pagination is implemented, the following &#x60;rel&#x60; (relation) types apply:  1. &#x60;next&#x60; (REQUIRED): A link to the next page, except on the last page.  2. &#x60;prev&#x60; (OPTIONAL): A link to the previous page, except on the first page.  3. &#x60;first&#x60; (OPTIONAL): A link to the first page, except on the first page.  4. &#x60;last&#x60; (OPTIONAL): A link to the last page, except on the last page.  For additional relation types see also the lists of [common relation types in openEO](#section/API-Principles/Web-Linking). | [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


