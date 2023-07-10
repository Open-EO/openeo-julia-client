# Billing


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**currency** | **String** | The currency the back-end is billing in. The currency MUST be either a valid currency code as defined in ISO-4217 or a back-end specific unit that is used for billing such as credits, tiles or CPU hours. If set to &#x60;null&#x60;, budget and costs are not supported by the back-end and users can&#39;t be charged. | [default to nothing]
**default_plan** | **String** | Name of the plan the back-end uses for billing in case  1. the user has not subscribed to a specific plan    (see &#x60;default_plan&#x60; in &#x60;GET /me&#x60;) and 2. also did not provide a specific plan with the    processing request.  If a free plan is available at the back-end, it is  probably most useful to provide this as the back-end wide default plan and override it with paid plans through the user-specific default plan in &#x60;GET /me&#x60;. Otherwise, users that have not set up payment yet MAY receive an error for each processing requests where they did not provide a free plan specifically. | [optional] [default to nothing]
**plans** | [**Vector{BillingPlan}**](BillingPlan.md) | Array of plans | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


