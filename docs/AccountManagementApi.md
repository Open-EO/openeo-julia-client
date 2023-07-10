# AccountManagementApi

All URIs are relative to *https://openeo.example/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authenticate_basic**](AccountManagementApi.md#authenticate_basic) | **GET** /credentials/basic | HTTP Basic authentication
[**authenticate_oidc**](AccountManagementApi.md#authenticate_oidc) | **GET** /credentials/oidc | OpenID Connect authentication
[**describe_account**](AccountManagementApi.md#describe_account) | **GET** /me | Information about the authenticated user


# **authenticate_basic**
> authenticate_basic(_api::AccountManagementApi; _mediaType=nothing) -> HTTPBasicAccessToken, OpenAPI.Clients.ApiResponse <br/>
> authenticate_basic(_api::AccountManagementApi, response_stream::Channel; _mediaType=nothing) -> Channel{ HTTPBasicAccessToken }, OpenAPI.Clients.ApiResponse

HTTP Basic authentication

Checks the credentials provided through [HTTP Basic Authentication according to RFC 7617](https://www.rfc-editor.org/rfc/rfc7617.html) and returns an access token for valid credentials.  The credentials (username and password) MUST be sent in the HTTP header `Authorization` with type `Basic` and the Base64 encoded string consisting of username and password separated by a double colon `:`. The header would look as follows for username `user` and password `pw`: `Authorization: Basic dXNlcjpwdw==`.  The access token has to be used in the Bearer token for authorization in subsequent API calls (see also the information about Bearer tokens in this document). The access token returned by this request MUST NOT be provided with `basic//` prefix, but the Bearer Token sent in subsequent API calls to protected endpoints MUST be prefixed with `basic//`. The header in subsequent API calls would look as follows: `Authorization: Bearer basic//TOKEN` (replace `TOKEN` with the actual access token).  It is RECOMMENDED to implement this authentication method for non-public services only.

### Required Parameters
This endpoint does not need any parameter.

### Return type

[**HTTPBasicAccessToken**](HTTPBasicAccessToken.md)

### Authorization

[Basic](../README.md#Basic)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **authenticate_oidc**
> authenticate_oidc(_api::AccountManagementApi; _mediaType=nothing) -> OpenIDConnectProviders, OpenAPI.Clients.ApiResponse <br/>
> authenticate_oidc(_api::AccountManagementApi, response_stream::Channel; _mediaType=nothing) -> Channel{ OpenIDConnectProviders }, OpenAPI.Clients.ApiResponse

OpenID Connect authentication

Lists the supported [OpenID Connect](http://openid.net/connect/) providers (OP). OpenID Connect Providers MUST support [OpenID Connect Discovery](http://openid.net/specs/openid-connect-discovery-1_0.html).  It is highly RECOMMENDED to implement OpenID Connect for public services in favor of Basic authentication.  openEO clients MUST use the **access token** as part of the Bearer token for authorization in subsequent API calls (see also the information about Bearer tokens in this document). Clients MUST NOT use the id token or the authorization code. The access token provided by an OpenID Connect Provider does not necessarily provide information about the issuer (i.e. the OpenID Connect provider) and therefore a prefix MUST be added to the Bearer Token sent in subsequent API calls to protected endpoints. The Bearer Token sent to protected endpoints MUST consist of the authentication method (here `oidc`), the provider ID and the access token itself. All separated by a forward slash `/`. The provider ID corresponds to the value specified for `id` for each provider in the response body of this endpoint.  The header in subsequent API calls for a provider with `id` `ms` would look as follows: `Authorization: Bearer oidc/ms/TOKEN` (replace `TOKEN` with the actual access token received from the OpenID Connect Provider).  Back-ends MAY request user information ([including Claims](https://openid.net/specs/openid-connect-core-1_0.html#Claims)) from the [OpenID Connect Userinfo endpoint](https://openid.net/specs/openid-connect-core-1_0.html#UserInfo) using the access token (without the prefix described above). Therefore, both openEO client and openEO back-end are relying parties (clients) to the OpenID Connect Provider.

### Required Parameters
This endpoint does not need any parameter.

### Return type

[**OpenIDConnectProviders**](OpenIDConnectProviders.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

# **describe_account**
> describe_account(_api::AccountManagementApi; _mediaType=nothing) -> UserData, OpenAPI.Clients.ApiResponse <br/>
> describe_account(_api::AccountManagementApi, response_stream::Channel; _mediaType=nothing) -> Channel{ UserData }, OpenAPI.Clients.ApiResponse

Information about the authenticated user

Lists information about the authenticated user, e.g. the user id. The endpoint MAY return the disk quota available to the user. The endpoint MAY also return links related to user management and the user profile, e.g. where payments are handled or the user profile could be edited. For back-ends that involve accounting, this service MAY also return the currently available money or credits in the currency the back-end is working with. This endpoint MAY be extended to fulfil the specification of the [OpenID Connect UserInfo Endpoint](http://openid.net/specs/openid-connect-core-1_0.html#UserInfo).

### Required Parameters
This endpoint does not need any parameter.

### Return type

[**UserData**](UserData.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#api-endpoints) [[Back to Model list]](../README.md#models) [[Back to README]](../README.md)

