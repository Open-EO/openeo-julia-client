# StoreBatchJobRequest


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **String** | A short description to easily distinguish entities. | [optional] [default to nothing]
**description** | **String** | Detailed multi-line description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. | [optional] [default to nothing]
**process** | [***ProcessGraphWithMetadata**](ProcessGraphWithMetadata.md) |  | [default to nothing]
**plan** | **String** | The billing plan to process and charge the job or service with.  Billing plans MUST be accepted in a *case insensitive* manner. Back-ends MUST resolve the billing plan in the following way:  * If a non-&#x60;null&#x60; value is given: Persist the &#x60;plan&#x60; that has been provided in the request. * Otherwise:   1. Persist the &#x60;default_plan&#x60; exposed through &#x60;GET /me&#x60;, if available.   2. Persist the &#x60;default_plan&#x60; exposed through &#x60;GET /&#x60;, if available.   3. If a single plan is exposed by the back-end, persist it.   4. Otherwise, the back-end MUST throw a &#x60;BillingPlanMissing&#x60; error.  The resolved plan MUST be persisted permanently, regardless of any  changes to the exposed billing plans in &#x60;GET /&#x60; in the future.  Billing plans not on the list of available plans MUST be rejected with openEO error &#x60;BillingPlanInvalid&#x60;. | [optional] [default to nothing]
**budget** | **Float64** | Maximum amount of costs the request is allowed to produce. The value MUST be specified in the currency of the back-end. No limits apply, if the value is &#x60;null&#x60; or the back-end has no currency set in &#x60;GET /&#x60;. | [optional] [default to nothing]
**log_level** | [***MinLogLevelDefault**](MinLogLevelDefault.md) |  | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


