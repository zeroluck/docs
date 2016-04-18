# API Document

## /oxauth

## Overview


## `/oxauth/register`
### registerPost
**POST** `/oxauth/register`

Registers new dynamic client in oxAuth.
#### URL
    http://gluu.org/oxauth/register
#### Parameters
|Parameter|Required|Description|Data Type|
|---------|--------|-----------|---------|
|applicationName|true|Application Name|string|
|redirectUris|true|Redirect URIs separated by space|string|

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
</table>

### registerGet
**GET** `/oxauth/register`

Registers new dynamic client in oxAuth.
#### URL
    http://gluu.org/oxauth/register
#### Parameters
|Parameter|Required|Description|Data Type|
|---------|--------|-----------|---------|
|applicationName|true|Application Name|string|
|redirectUris|true|Redirect URIs separated by space|string|

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
</table>


