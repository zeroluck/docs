## API Document

### /oxauth

#### Overview


#### `/oxauth/userinfo`
##### requestUserInfoGet
**GET** `/oxauth/userinfo`

Returns Claims about the authenticated End-User.
The Access Token obtained from an OpenID Connect Authentication Request is sent as a Bearer Token.

###### URL
    http://gluu.org/oxauth/userinfo
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
            <th>access_token</th>
            <td>true</td>
            <td>OAuth 2.0 Access Token.</td>
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
[JSON[Response]](#JSON[Response])


###### Errors
<table border="1">
    <tr>
        <th>Status Code</th>
        <th>Reason</th>
    </tr>
</table>


- - -
##### requestUserInfoPost
**POST** `/oxauth/userinfo`

Returns Claims about the authenticated End-User.
The Access Token obtained from an OpenID Connect Authentication Request is sent as a Bearer Token.

###### URL
    http://gluu.org/oxauth/userinfo
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
            <th>access_token</th>
            <td>true</td>
            <td>OAuth 2.0 Access Token.</td>
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
