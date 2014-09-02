## API Document

### /oxauth

#### Overview


#### `/oxauth/authorize`
##### requestAuthorizationPost
**POST** `/oxauth/authorize`

Performs authorization.
Performs authorization.

###### URL
    http://gluu.org/oxauth/authorize
###### Parameters
- form

    <table border="1">
        <tr>
            <th>Parameter</th>
            <th>Required</th>
            <th>Description</th>
            <th>Data Type</th>
        </tr>
        <tr>
            <th>scope</th>
            <td>true</td>
            <td>OpenID Connect requests MUST contain the openid scope value. If the openid scope value is not present, the behavior is entirely unspecified. Other scope values MAY be present. Scope values used that are not understood by an implementation SHOULD be ignored.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>response_type</th>
            <td>true</td>
            <td>OAuth 2.0 Response Type value that determines the authorization processing flow to be used, including what parameters are returned from the endpoints used. When using the Authorization Code Flow, this value is code.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>client_id</th>
            <td>true</td>
            <td>OAuth 2.0 Client Identifier valid at the Authorization Server.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>redirect_uri</th>
            <td>true</td>
            <td>Redirection URI to which the response will be sent. This URI MUST exactly match one of the Redirection URI values for the Client pre-registered at the OpenID Provider</td>
            <td>string</td>
        </tr>
        <tr>
            <th>state</th>
            <td>false</td>
            <td>Opaque value used to maintain state between the request and the callback. Typically, Cross-Site Request Forgery (CSRF, XSRF) mitigation is done by cryptographically binding the value of this parameter with a browser cookie.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>nonce</th>
            <td>false</td>
            <td>String value used to associate a Client session with an ID Token, and to mitigate replay attacks. The value is passed through unmodified from the Authorization Request to the ID Token. Sufficient entropy MUST be present in the nonce values used to prevent attackers from guessing values.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>display</th>
            <td>false</td>
            <td>ASCII string value that specifies how the Authorization Server displays the authentication and consent user interface pages to the End-User. The defined values are: page, popup, touch, wap</td>
            <td>string</td>
        </tr>
        <tr>
            <th>prompt</th>
            <td>false</td>
            <td>Space delimited, case sensitive list of ASCII string values that specifies whether the Authorization Server prompts the End-User for reauthentication and consent. The defined values are: none, login, consent, select_account</td>
            <td>string</td>
        </tr>
        <tr>
            <th>max_age</th>
            <td>false</td>
            <td>Maximum Authentication Age. Specifies the allowable elapsed time in seconds since the last time the End-User was actively authenticated by the OP. If the elapsed time is greater than this value, the OP MUST attempt to actively re-authenticate the End-User. (The max_age request parameter corresponds to the OpenID 2.0 PAPE [OpenID.PAPE] max_auth_age request parameter.) When max_age is used, the ID Token returned MUST include an auth_time Claim Value.</td>
            <td>int</td>
        </tr>
        <tr>
            <th>ui_locales</th>
            <td>false</td>
            <td>End-User&#39;s preferred languages and scripts for the user interface, represented as a space-separated list of BCP47 [RFC5646] language tag values, ordered by preference. For instance, the value &quot;fr-CA fr en&quot; represents a preference for French as spoken in Canada, then French (without a region designation), followed by English (without a region designation). An error SHOULD NOT result if some or all of the requested locales are not supported by the OpenID Provider.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>id_token_hint</th>
            <td>false</td>
            <td>ID Token previously issued by the Authorization Server being passed as a hint about the End-User&#39;s current or past authenticated session with the Client. If the End-User identified by the ID Token is logged in or is logged in by the request, then the Authorization Server returns a positive response; otherwise, it SHOULD return an error, such as login_required. When possible, an id_token_hint SHOULD be present when prompt=none is used and an invalid_request error MAY be returned if it is not; however, the server SHOULD respond successfully when possible, even if it is not present. The Authorization Server need not be listed as an audience of the ID Token when it is used as an id_token_hint value.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>login_hint</th>
            <td>false</td>
            <td>Hint to the Authorization Server about the login identifier the End-User might use to log in (if necessary). This hint can be used by an RP if it first asks the End-User for their e-mail address (or other identifier) and then wants to pass that value as a hint to the discovered authorization service. It is RECOMMENDED that the hint value match the value used for discovery. This value MAY also be a phone number in the format specified for the phone_number Claim. The use of this parameter is left to the OP&#39;s discretion.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>acr_values</th>
            <td>false</td>
            <td>Requested Authentication Context Class Reference values. Space-separated string that specifies the acr values that the Authorization Server is being requested to use for processing this Authentication Request, with the values appearing in order of preference. The Authentication Context Class satisfied by the authentication performed is returned as the acr Claim Value, as specified in Section 2. The acr Claim is requested as a Voluntary Claim by this parameter.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>amr_values</th>
            <td>false</td>
            <td>AMR Values</td>
            <td>string</td>
        </tr>
        <tr>
            <th>request</th>
            <td>false</td>
            <td>This parameter enables OpenID Connect requests to be passed in a single, self-contained parameter and to be optionally signed and/or encrypted. The parameter value is a Request Object value, as specified in Section 6.1. It represents the request as a JWT whose Claims are the request parameters.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>request_uri</th>
            <td>false</td>
            <td>This parameter enables OpenID Connect requests to be passed by reference, rather than by value. The request_uri value is a URL using the https scheme referencing a resource containing a Request Object value, which is a JWT containing the request parameters.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>request_session_id</th>
            <td>false</td>
            <td>Request session id</td>
            <td>string</td>
        </tr>
        <tr>
            <th>session_id</th>
            <td>false</td>
            <td>Session id of this call</td>
            <td>string</td>
        </tr>
        <tr>
            <th>access_token</th>
            <td>false</td>
            <td>Access token</td>
            <td>string</td>
        </tr>
        <tr>
            <th>auth_level</th>
            <td>false</td>
            <td>The minimum authentication level of authentication plugin</td>
            <td>string</td>
        </tr>
        <tr>
            <th>auth_mode</th>
            <td>false</td>
            <td>The name of authentication plugin</td>
            <td>string</td>
        </tr>
        <tr>
            <th>origin_headers</th>
            <td>false</td>
            <td>Origin headers. Used in custom workflows.</td>
            <td>string</td>
        </tr>
    </table>
- query

    <table border="1">
        <tr>
            <th>Parameter</th>
            <th>Required</th>
            <th>Description</th>
            <th>Data Type</th>
        </tr>
        <tr>
            <th>response_mode</th>
            <td>false</td>
            <td>Informs the Authorization Server of the mechanism to be used for returning parameters from the Authorization Endpoint. This use of this parameter is NOT RECOMMENDED when the Response Mode that would be requested is the default mode specified for the Response Type.</td>
            <td>string</td>
        </tr>
    </table>

###### Response
[JSON[Response]](#JSON[Response])


###### Errors
<table border="1">
    <tr>
        <th>Status Code</th>
        <th>Reason</th>
    </tr>
</table>


- - -
##### requestAuthorizationGet
**GET** `/oxauth/authorize`

Performs authorization.
Performs authorization.

###### URL
    http://gluu.org/oxauth/authorize
###### Parameters
- query

    <table border="1">
        <tr>
            <th>Parameter</th>
            <th>Required</th>
            <th>Description</th>
            <th>Data Type</th>
        </tr>
        <tr>
            <th>scope</th>
            <td>true</td>
            <td>OpenID Connect requests MUST contain the openid scope value. If the openid scope value is not present, the behavior is entirely unspecified. Other scope values MAY be present. Scope values used that are not understood by an implementation SHOULD be ignored.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>response_type</th>
            <td>true</td>
            <td>OAuth 2.0 Response Type value that determines the authorization processing flow to be used, including what parameters are returned from the endpoints used. When using the Authorization Code Flow, this value is code.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>client_id</th>
            <td>true</td>
            <td>OAuth 2.0 Client Identifier valid at the Authorization Server.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>redirect_uri</th>
            <td>true</td>
            <td>Redirection URI to which the response will be sent. This URI MUST exactly match one of the Redirection URI values for the Client pre-registered at the OpenID Provider</td>
            <td>string</td>
        </tr>
        <tr>
            <th>state</th>
            <td>false</td>
            <td>Opaque value used to maintain state between the request and the callback. Typically, Cross-Site Request Forgery (CSRF, XSRF) mitigation is done by cryptographically binding the value of this parameter with a browser cookie.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>response_mode</th>
            <td>false</td>
            <td>Informs the Authorization Server of the mechanism to be used for returning parameters from the Authorization Endpoint. This use of this parameter is NOT RECOMMENDED when the Response Mode that would be requested is the default mode specified for the Response Type.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>nonce</th>
            <td>false</td>
            <td>String value used to associate a Client session with an ID Token, and to mitigate replay attacks. The value is passed through unmodified from the Authorization Request to the ID Token. Sufficient entropy MUST be present in the nonce values used to prevent attackers from guessing values.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>display</th>
            <td>false</td>
            <td>ASCII string value that specifies how the Authorization Server displays the authentication and consent user interface pages to the End-User. The defined values are: page, popup, touch, wap</td>
            <td>string</td>
        </tr>
        <tr>
            <th>prompt</th>
            <td>false</td>
            <td>Space delimited, case sensitive list of ASCII string values that specifies whether the Authorization Server prompts the End-User for reauthentication and consent. The defined values are: none, login, consent, select_account</td>
            <td>string</td>
        </tr>
        <tr>
            <th>max_age</th>
            <td>false</td>
            <td>Maximum Authentication Age. Specifies the allowable elapsed time in seconds since the last time the End-User was actively authenticated by the OP. If the elapsed time is greater than this value, the OP MUST attempt to actively re-authenticate the End-User. (The max_age request parameter corresponds to the OpenID 2.0 PAPE [OpenID.PAPE] max_auth_age request parameter.) When max_age is used, the ID Token returned MUST include an auth_time Claim Value.</td>
            <td>int</td>
        </tr>
        <tr>
            <th>ui_locales</th>
            <td>false</td>
            <td>End-User&#39;s preferred languages and scripts for the user interface, represented as a space-separated list of BCP47 [RFC5646] language tag values, ordered by preference. For instance, the value &quot;fr-CA fr en&quot; represents a preference for French as spoken in Canada, then French (without a region designation), followed by English (without a region designation). An error SHOULD NOT result if some or all of the requested locales are not supported by the OpenID Provider.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>id_token_hint</th>
            <td>false</td>
            <td>ID Token previously issued by the Authorization Server being passed as a hint about the End-User&#39;s current or past authenticated session with the Client. If the End-User identified by the ID Token is logged in or is logged in by the request, then the Authorization Server returns a positive response; otherwise, it SHOULD return an error, such as login_required. When possible, an id_token_hint SHOULD be present when prompt=none is used and an invalid_request error MAY be returned if it is not; however, the server SHOULD respond successfully when possible, even if it is not present. The Authorization Server need not be listed as an audience of the ID Token when it is used as an id_token_hint value.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>login_hint</th>
            <td>false</td>
            <td>Hint to the Authorization Server about the login identifier the End-User might use to log in (if necessary). This hint can be used by an RP if it first asks the End-User for their e-mail address (or other identifier) and then wants to pass that value as a hint to the discovered authorization service. It is RECOMMENDED that the hint value match the value used for discovery. This value MAY also be a phone number in the format specified for the phone_number Claim. The use of this parameter is left to the OP&#39;s discretion.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>acr_values</th>
            <td>false</td>
            <td>Requested Authentication Context Class Reference values. Space-separated string that specifies the acr values that the Authorization Server is being requested to use for processing this Authentication Request, with the values appearing in order of preference. The Authentication Context Class satisfied by the authentication performed is returned as the acr Claim Value, as specified in Section 2. The acr Claim is requested as a Voluntary Claim by this parameter.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>amr_values</th>
            <td>false</td>
            <td>AMR Values</td>
            <td>string</td>
        </tr>
        <tr>
            <th>request</th>
            <td>false</td>
            <td>This parameter enables OpenID Connect requests to be passed in a single, self-contained parameter and to be optionally signed and/or encrypted. The parameter value is a Request Object value, as specified in Section 6.1. It represents the request as a JWT whose Claims are the request parameters.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>request_uri</th>
            <td>false</td>
            <td>This parameter enables OpenID Connect requests to be passed by reference, rather than by value. The request_uri value is a URL using the https scheme referencing a resource containing a Request Object value, which is a JWT containing the request parameters.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>request_session_id</th>
            <td>false</td>
            <td>Request session id</td>
            <td>string</td>
        </tr>
        <tr>
            <th>session_id</th>
            <td>false</td>
            <td>Session id of this call</td>
            <td>string</td>
        </tr>
        <tr>
            <th>access_token</th>
            <td>false</td>
            <td>Access token</td>
            <td>string</td>
        </tr>
        <tr>
            <th>auth_level</th>
            <td>false</td>
            <td>The minimum authentication level of authentication plugin</td>
            <td>string</td>
        </tr>
        <tr>
            <th>auth_mode</th>
            <td>false</td>
            <td>The name of authentication plugin</td>
            <td>string</td>
        </tr>
        <tr>
            <th>origin_headers</th>
            <td>false</td>
            <td>Origin headers. Used in custom workflows.</td>
            <td>string</td>
        </tr>
    </table>

###### Response
[JSON[Response]](#JSON[Response])


###### Errors
<table border="1">
    <tr>
        <th>Status Code</th>
        <th>Reason</th>
    </tr>
</table>


- - -

## Data Types
