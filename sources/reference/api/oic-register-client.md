## API Document

### /oxauth

#### Overview


#### `/oxauth/register`
##### requestClientRead
**GET** `/oxauth/register`

Reads client info.
Reads client info.

###### URL
    http://gluu.org/oxauth/register
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
            <th>client_id</th>
            <td>true</td>
            <td>Client ID that identifies client.</td>
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
##### requestRegister
**POST** `/oxauth/register`

Registers new client dynamically.
Registers new client dynamically.

###### URL
    http://gluu.org/oxauth/register
###### Parameters
- body

    <table border="1">
        <tr>
            <th>Parameter</th>
            <th>Required</th>
            <th>Description</th>
            <th>Data Type</th>
        </tr>
        <tr>
            <th>body</th>
            <td>true</td>
            <td>Request parameters as JSON object with data described by Connect Client Registration Specification.</td>
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
#### `/oxauthregister`
##### requestClientUpdate
**PUT** `/oxauthregister`

Updates client info.
Updates client info.

###### URL
    http://gluu.org/oxauthregister
###### Parameters
- body

    <table border="1">
        <tr>
            <th>Parameter</th>
            <th>Required</th>
            <th>Description</th>
            <th>Data Type</th>
        </tr>
        <tr>
            <th>body</th>
            <td>true</td>
            <td>Request parameters as JSON object with data described by Connect Client Registration Specification.</td>
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
            <th>client_id</th>
            <td>true</td>
            <td>Client ID that identifies client that must be updated by this request.</td>
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
