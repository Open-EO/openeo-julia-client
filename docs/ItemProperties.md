# ItemProperties


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**datetime** | **ZonedDateTime** | The searchable date/time of the data, in UTC. Formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time.  If this field is set to &#x60;null&#x60; (usually for larger time ranges), it is STRONGLY RECOMMENDED to specify both &#x60;start_datetime&#x60; and &#x60;end_datetime&#x60; for STAC compliance. | [default to nothing]
**start_datetime** | **ZonedDateTime** | For time series: The first or start date and time for the data, in UTC. Formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time. | [optional] [default to nothing]
**end_datetime** | **ZonedDateTime** | For time series: The last or end date and time for the data, in UTC. Formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time. | [optional] [default to nothing]
**title** | **String** | A short description to easily distinguish entities. | [optional] [default to nothing]
**description** | **String** | Detailed multi-line description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. | [optional] [default to nothing]
**license** | **String** | License(s) of the data as a SPDX [License identifier](https://spdx.org/licenses/). Alternatively, use &#x60;proprietary&#x60; if the license is not on the SPDX license list or &#x60;various&#x60; if multiple licenses apply. In these two cases links to the license texts SHOULD be added, see the &#x60;license&#x60; link relation type.  Non-SPDX licenses SHOULD add a link to the license text with the &#x60;license&#x60; relation in the links section. The license text MUST NOT be provided as a value of this field. If there is no public license URL available, it is RECOMMENDED to host the license text and link to it. | [optional] [default to nothing]
**providers** | [**Vector{Provider}**](Provider.md) | A list of providers, which MAY include all organizations capturing or processing the data or the hosting provider. Providers SHOULD be listed in chronological order with the most recent provider being the last element of the list. | [optional] [default to nothing]
**created** | **ZonedDateTime** | Date and time of creation, formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time. | [optional] [default to nothing]
**updated** | **ZonedDateTime** | Date and time of the last status change, formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time. | [optional] [default to nothing]
**expires** | **ZonedDateTime** | Time until which the assets are accessible, in UTC. Formatted as a [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html) date-time. | [optional] [default to nothing]
**var&quot;openeo:status&quot;** | [***ResultStatus**](ResultStatus.md) |  | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


