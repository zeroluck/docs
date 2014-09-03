## API Document

### /oxauth

#### Overview


#### `/oxauth/end_session`
##### requestEndSession
**GET** `/oxauth/end_session`

End current Connect session.
End current Connect session.

###### URL
    http://gluu.org/oxauth/end_session
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
            <th>id_token_hint</th>
            <td>true</td>
            <td>Previously issued ID Token passed to the logout endpoint as a hint about the End-User&#39;s current authenticated session with the Client. This is used as an indication of the identity of the End-User that the RP is requesting be logged out by the OP. The OP need not be listed as an audience of the ID Token when it is used as an id_token_hint value.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>post_logout_redirect_uri</th>
            <td>false</td>
            <td>URL to which the RP is requesting that the End-User&#39;s User Agent be redirected after a logout has been performed. The value MUST have been previously registered with the OP, either using the post_logout_redirect_uris Registration parameter or via another mechanism. If supplied, the OP SHOULD honor this request following the logout.</td>
            <td>string</td>
        </tr>
        <tr>
            <th>session_id</th>
            <td>false</td>
            <td>Session ID</td>
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
