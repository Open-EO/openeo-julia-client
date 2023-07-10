# OpenIDConnectProvider


## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** | A per-backend **unique** identifier for the OpenID Connect Provider to be as prefix for the Bearer token. | [default to nothing]
**issuer** | **String** | The [issuer location](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfig) (also referred to as &#39;authority&#39; in some client libraries) is the URL of the OpenID Connect provider, which conforms to a set of rules: 1. After appending &#x60;/.well-known/openid-configuration&#x60; to the URL, a [HTTP/1.1 GET request](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfigurationRequest) to the concatenated URL MUST return a [OpenID Connect Discovery Configuration Response](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfigurationResponse). The response provides all information required to authenticate using OpenID Connect. 2. The URL MUST NOT contain a terminating forward slash &#x60;/&#x60;. | [default to nothing]
**scopes** | **Vector{String}** | A list of OpenID Connect scopes that the client MUST at least include when requesting authorization. Clients MAY add additional scopes such as the &#x60;offline_access&#x60; scope to retrieve a refresh token. If scopes are specified, the list MUST at least contain the &#x60;openid&#x60; scope. | [optional] [default to nothing]
**title** | **String** | The name that is publicly shown in clients for this OpenID Connect provider. | [default to nothing]
**description** | **String** | A description that explains how the authentication procedure works.  It should make clear how to register and get credentials. This should include instruction on setting up &#x60;client_id&#x60;, &#x60;client_secret&#x60; and &#x60;redirect_uri&#x60;.  [CommonMark 0.29](http://commonmark.org/) syntax MAY be used for rich text representation. | [optional] [default to nothing]
**default_clients** | [**Vector{DefaultOpenIDConnectClient}**](DefaultOpenIDConnectClient.md) | List of default OpenID Connect clients that can be used by an openEO client for OpenID Connect based authentication.  A default OpenID Connect client is managed by the back-end implementer. It MUST be configured to be usable without a client secret, which limits its applicability to OpenID Connect grant types like \&quot;Authorization Code Grant with PKCE\&quot; and \&quot;Device Authorization Grant with PKCE\&quot;  A default OpenID Connect client is provided without availability guarantees. The back-end implementer CAN revoke, reset or update it any time. As such, openEO clients SHOULD NOT store or cache default OpenID Connect client information for long term usage. A default OpenID Connect client is intended to simplify authentication for novice users. For production use cases, it is RECOMMENDED to set up a dedicated OpenID Connect client. | [optional] [default to nothing]
**links** | [**Vector{Link}**](Link.md) | Links related to this provider, for example a help page or a page to register a new user account.  For relation types see the lists of [common relation types in openEO](#section/API-Principles/Web-Linking). | [optional] [default to nothing]


[[Back to Model list]](../README.md#models) [[Back to API list]](../README.md#api-endpoints) [[Back to README]](../README.md)


