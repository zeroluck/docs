## API Document

### /rpt/status

#### Overview


#### `/rpt/status`
##### requestRptStatusGet
**GET** `/rpt/status`

Not allowed


###### URL
    http://gluu.org/rpt/status
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
            <th>token</th>
            <td>false</td>
            <td></td>
            <td>string</td>
        </tr>
        <tr>
            <th>token_type_hint</th>
            <td>false</td>
            <td></td>
            <td>string</td>
        </tr>
    </table>
- header

    <table border="1">
        <tr>
            <th>Parameter</th>
            <th>Required</th>
            <th>Description</th>
            <th>Data Type</th>
        </tr>
        <tr>
            <th>Authorization</th>
            <td>false</td>
            <td></td>
            <td>string</td>
        </tr>
    </table>

###### Response
[](#)


###### Errors
<table border="1">
    <tr>
        <th>Status Code</th>
        <th>Reason</th>
    </tr>
        <tr>
            <td>405</td>
            <td>Introspection of RPT is not allowed by GET HTTP method.</td>
        </tr>
</table>


- - -
##### requestRptStatus
**POST** `/rpt/status`

The resource server MUST determine a received RPT&#39;s status, including both whether it is active and, if so, its associated authorization data, before giving or refusing access to the client. An RPT is associated with a set of authorization data that governs whether the client is authorized for access. The token&#39;s nature and format are dictated by its profile; the profile might allow it to be self-contained, such that the resource server is able to determine its status locally, or might require or allow the resource server to make a run-time introspection request of the authorization server that issued the token.
The endpoint MAY allow other parameters to provide further context to
   the query.  For instance, an authorization service may need to know
   the IP address of the client accessing the protected resource in
   order to determine the appropriateness of the token being presented.

   To prevent unauthorized token scanning attacks, the endpoint MUST
   also require some form of authorization to access this endpoint, such
   as client authentication as described in OAuth 2.0 [RFC6749] or a
   separate OAuth 2.0 access token such as the bearer token described in
   OAuth 2.0 Bearer Token Usage [RFC6750].  The methods of managing and
   validating these authentication credentials are out of scope of this
   specification.


###### URL
    http://gluu.org/rpt/status
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
            <th>token</th>
            <td>true</td>
            <td>The string value of the token.  For access tokens,&#10;      this is the &quot;access_token&quot; value returned from the token endpoint&#10;      defined in OAuth 2.0 [RFC6749] section 5.1.  For refresh tokens,&#10;      this is the &quot;refresh_token&quot; value returned from the token endpoint&#10;      as defined in OAuth 2.0 [RFC6749] section 5.1.  Other token types&#10;      are outside the scope of this specification.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>token_type_hint</th>
            <td>false</td>
            <td>A hint about the type of the token&#10;      submitted for introspection.  The protected resource re MAY pass&#10;      this parameter in order to help the authorization server to&#10;      optimize the token lookup.  If the server is unable to locate the&#10;      token using the given hint, it MUST extend its search across all&#10;      of its supported token types.  An authorization server MAY ignore&#10;      this parameter, particularly if it is able to detect the token&#10;      type automatically.  Values for this field are defined in OAuth&#10;      Token Revocation [RFC7009].</td>
            <td>string</td>
        </tr>
    </table>
- header

    <table border="1">
        <tr>
            <th>Parameter</th>
            <th>Required</th>
            <th>Description</th>
            <th>Data Type</th>
        </tr>
        <tr>
            <th>Authorization</th>
            <td>false</td>
            <td></td>
            <td>string</td>
        </tr>
    </table>

###### Response
[](#)


###### Errors
<table border="1">
    <tr>
        <th>Status Code</th>
        <th>Reason</th>
    </tr>
        <tr>
            <td>401</td>
            <td>Unauthorized</td>
        </tr>
</table>


- - -

## Data Types
