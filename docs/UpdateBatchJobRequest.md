# UpdateBatchJobRequest


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **String** | A short description to easily distinguish entities. | [optional] [default to nothing]
**description** | **String** | Detailed multi-line description to explain the entity.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. | [optional] [default to nothing]
**process** | [***ProcessGraphWithMetadata**](ProcessGraphWithMetadata.md) |  | [optional] [default to nothing]
**plan** | **String** | The billing plan to process and charge the job or service with.  Billing plans MUST be accepted in a *case insensitive* manner. Back-ends MUST resolve the billing plan in the following way if billing is supported:  * If a value is given and it is not &#x60;null&#x60;: Persist the &#x60;plan&#x60; that has been provided in the request. * Otherwise, don&#39;t change the billing plan.  Billing plans not on the list of available plans MUST be rejected with openEO error &#x60;BillingPlanInvalid&#x60;. | [optional] [default to nothing]
**budget** | **Float64** | Maximum amount of costs the request is allowed to produce. The value MUST be specified in the currency of the back-end. No limits apply, if the value is &#x60;null&#x60;. | [optional] [default to nothing]
**log_level** | [***MinLogLevelUpdate**](MinLogLevelUpdate.md) |  | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


