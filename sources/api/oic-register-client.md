# API Document

## /oxauth

## Overview
Any OpenID Client needs to register with the OpenID Provider to utilize OpenID Services, in this case register a user, and acquire a client ID and a shared secret.

## `/oxauth/register`
### registerPost
**POST** `/oxauth/register`

Registers new dynamic client in oxAuth.
#### URL
    http://gluu.org/oxauth/register
#### Parameters
|Parameter|Description|
|---------|--------|
|redirect_uris|Redirection URI values used by the Client. One of these registered Redirection URI values must exactly match the redirect_uri parameter value used in each Authorization Request|
|response_types|A list of the OAuth 2.0 response_type values that the Client is declaring that it will restrict itself to using. If omitted, the default is that the Client will use only the code Response Type. Allowed values are code, token, id_token|
|grant_types|A list of the OAuth 2.0 Grant Types that the Client is declaring that it will restrict itself to using. The Grant Type values used by OpenID Connect are:<ul><li>**authorization_code** The Authorization Code Grant Type</li><li>**implicit** The Implicit Grant Type</li><li>**refresh_token** The Refresh Token Grant Type</li></ul>The following table lists the correspondence between response_type values that the Client will use and grant_type values that MUST be included in the registered grant_types list:<ul><li>code: authorization_code</li><li>id_token: implicit</li><li>token id_token: implicit</li><li>code id_token: authorization_code, implicit</li><li>code token: authorization_code, implicit</li><li>code token id_token: authorization_code, implicit</li></ul>|
|application_type|Kind of the application. The default, if omitted, is web. The defined values are native or web. Web Clients using the OAuth Implicit Grant Type must only register URLs using the https scheme as redirect_uris; they must not use localhost as the hostname. Native Clients must only register redirect_uris using custom URI schemes or URLs using the http: scheme with localhost as the hostname.|
|contacts|e-mail addresses of people responsible for this Client.|
|client_name|Name of the Client to be presented to the End-User.|
|logo_uri|URL that references a logo for the Client application. If present, the server displays this image to the End-User during approval. The value of this field must point to a valid image file.|
|client_uri|URL of the home page of the Client. The value of this field must point to a valid Web page. If present, the server displays this URL to the End-User in a followable fashion.|
|policy_uri|URL that the Relying Party Client provides to the End-User to read about the how the profile data will be used. The value of this field must point to a valid web page. The OpenID Provider displays this URL to the End-User if it is given.|
|tos_uri|URL that the Relying Party Client provides to the End-User to read about the Relying Party's terms of service. The value of this field must point to a valid web page. The OpenID Provider displays this URL to the End-User if it is given.|
|jwks_uri|URL for the Client's JSON Web Key Set (JWK) document. If the Client signs requests to the Server, it contains the signing key(s) the Server uses to validate signatures from the Client. The JWK Set may also contain the Client's encryption keys(s), which are used by the Server to encrypt responses to the Client. When both signing and encryption keys are made available, a use (Key Use) parameter value is required for all keys in the referenced JWK Set to indicate each key's intended usage. Although some algorithms allow the same key to be used for both signatures and encryption, doing so is not recommended, as it is less secure. The JWK x5c parameter MAY be used to provide X.509 representations of keys provided. When used, the bare key values must still be present and must match those in the certificate.|
|jwks|Client's JSON Web Key Set (JWK) document, passed by value. The semantics of the jwks parameter are the same as the jwks_uri parameter, other than that the JWK Set is passed by value, rather than by reference. This parameter is intended only to be used by Clients that, for some reason, are unable to use the jwks_uri parameter, for instance, by native applications that might not have a location to host the contents of the JWK Set. If a Client can use jwks_uri, it must not use jwks. One significant downside of jwks is that it does not enable key rotation (which jwks_uri does). The jwks_uri and jwks parameters must not be used together.|
|sector_identifier_uri|URL using the https scheme to be used in calculating Pseudonymous Identifiers by the OP. The URL references a file with a single JSON array of redirect_uri values. Providers that use pairwise sub (subject) values utilizes the sector_identifier_uri value provided in the Subject Identifier calculation for pairwise identifiers.|
|subject_type|subject_type requested for responses to this Client. The subject_types_supported Discovery parameter contains a list of the supported subject_type values for this server. Valid types include pairwise and public.|

#### Response
Client Identificator or INUM, a client shared secret and the account expiration date in a [JSON[Response]]

#### Errors
<table border="1">
    <tr>
        <th>Status Code</th>
        <th>Reason</th>
    <tr/>
	<tr>
            <td>400</td>
            <td>invalid_request&#10;The request is missing a required parameter, includes an unsupported parameter or parameter value, repeats the same parameter, uses more than one method for including an access token, or is otherwise malformed.  The resource server SHOULD respond with the HTTP 400 (Bad Request) status code.</td>
        </tr>
        <tr>
            <td>401</td>
            <td>invalid_token&#10;The access token provided is expired, revoked, malformed, or invalid for other reasons.  The resource SHOULD respond with the HTTP 401 (Unauthorized) status code.  The client MAY request a new access token and retry the protected resource request.</td>
        </tr>
        <tr>
            <td>403</td>
            <td>insufficient_scope&#10;The request requires higher privileges than provided by the access token.  The resource server SHOULD respond with the HTTP 403 (Forbidden) status code and MAY include the &quot;scope&quot;&#10; attribute with the scope necessary to access the protected resource.</td>
        </tr>
	<tr>
	    <td>302</td>
	    <td>access_denies&#14; The request is denied by the authorization server.</td>
	</tr>

</table>

### registerPut
**PUT** `/oxauth/register`

This operation updates the Client Metadata for a registered client.
#### URL
    http://gluu.org/oxauth/register
#### Parameters
The request is sent as an `HTTP POST` to the client registration endpoint as JSON with the parameters.

|Parameter|Description|
|---------|-----------|
|clientId |The unique client identifier usually INUM|
|authorization| The authorization for the client|
|httpRequest| The HTTP Request object|
|securityContext| Injectable interface providing access to security info|

#### Response
Client Identificator or INUM, a client shared secret and the account expiration date in a [JSON[Response]]

#### Errors
<table border="1">
    <tr>
        <th>Status Code</th>
        <th>Reason</th>
    <tr/>
        <tr>
            <td>400</td>
            <td>invalid_request&#10;The request is missing a required parameter, includes an unsupported parameter or parameter value, repeats the same parameter, uses more than one method for including an access token, or is otherwise malformed.  The resource server SHOULD respond with the HTTP 400 (Bad Request) status code.</td>
        </tr>
        <tr>
            <td>401</td>
            <td>invalid_token&#10;The access token provided is expired, revoked, malformed, or invalid for other reasons.  The resource SHOULD respond with the HTTP 401 (Unauthorized) status code.  The client MAY request a new access token and retry the protected resource request.</td>
        </tr>
        <tr>
            <td>403</td>
            <td>insufficient_scope&#10;The request requires higher privileges than provided by the access token.  The resource server SHOULD respond with the HTTP 403 (Forbidden) status code and MAY include the &quot;scope&quot;&#10; attribute with the scope necessary to access the protected resource.</td>
        </tr>
        <tr>
            <td>302</td>
            <td>access_denies&#14; The request is denied by the authorization server.</td>
        </tr>

</table>


### registerGet
**GET** `/oxauth/register`

This operation retrieves the Client Metadata for a previously registered client.
#### URL
    http://gluu.org/oxauth/register
#### Parameters
The request is sent as an `HTTP POST` to the client registration endpoint as JSON with the parameters.

|Parameter|Description|
|---------|-----------|
|clientId |The unique client identifier usually INUM|
|securityContext|injectable interface that provides access to security related info.|
 
#### Response
Client Identificator or INUM, a client shared secret and the account expiration date in a [JSON[Response]]

#### Errors
<table border="1">
    <tr>
        <th>Status Code</th>
        <th>Reason</th>
    </tr>
        <tr>
            <td>400</td>
            <td>invalid_request&#10;The request is missing a required parameter, includes an unsupported parameter or parameter value, repeats the same parameter, uses more than one method for including an access token, or is otherwise malformed.  The resource server SHOULD respond with the HTTP 400 (Bad Request) status code.</td>
        </tr>
        <tr>
            <td>401</td>
            <td>invalid_token&#10;The access token provided is expired, revoked, malformed, or invalid for other reasons.  The resource SHOULD respond with the HTTP 401 (Unauthorized) status code.  The client MAY request a new access token and retry the protected resource request.</td>
        </tr>
        <tr>
            <td>403</td>
            <td>insufficient_scope&#10;The request requires higher privileges than provided by the access token.  The resource server SHOULD respond with the HTTP 403 (Forbidden) status code and MAY include the &quot;scope&quot;&#10; attribute with the scope necessary to access the protected resource.</td>
        </tr>
        <tr>
            <td>302</td>
            <td>access_denies&#14; The request is denied by the authorization server.</td>
        </tr>
</table>


