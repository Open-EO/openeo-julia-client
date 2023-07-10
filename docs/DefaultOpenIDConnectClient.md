# DefaultOpenIDConnectClient


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | The OpenID Connect Client ID to be used in the authentication procedure. | [default to nothing]
**grant_types** | **Vector{String}** | List of authorization grant types (flows) supported by the OpenID Connect client. A grant type descriptor consist of a OAuth 2.0 grant type, with an additional &#x60;+pkce&#x60; suffix when the grant type should be used with the PKCE extension as defined in [RFC 7636](https://www.rfc-editor.org/rfc/rfc7636.html).  Allowed values: - &#x60;implicit&#x60;: Implicit Grant as specified in [RFC 6749, sec. 1.3.2](https://www.rfc-editor.org/rfc/rfc6749.html#section-1.3.2) - &#x60;authorization_code&#x60; / &#x60;authorization_code+pkce&#x60;: Authorization Code Grant as specified in [RFC 6749, sec. 1.3.1](https://www.rfc-editor.org/rfc/rfc6749.html#section-1.3.1), with or without PKCE extension. - &#x60;urn:ietf:params:oauth:grant-type:device_code&#x60; / &#x60;urn:ietf:params:oauth:grant-type:device_code+pkce&#x60;: Device Authorization Grant (aka Device Code Flow) as specified in [RFC 8628](https://www.rfc-editor.org/rfc/rfc8628.html), with or without PKCE extension. Note that the combination of this grant with the PKCE extension is *not standardized* yet. - &#x60;refresh_token&#x60;: Refresh Token as specified in [RFC 6749, sec. 1.5](https://www.rfc-editor.org/rfc/rfc6749.html#section-1.5) | [default to nothing]
**redirect_urls** | **Vector{String}** | List of redirect URLs that are whitelisted by the OpenID Connect client. Redirect URLs MUST be provided when the OpenID Connect client supports the Implicit Grant or the Authorization Code Grant (with or without PKCE extension). | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


