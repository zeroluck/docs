## API Document

### /.well-known/uma-configuration

#### Overview


#### `/oxauth/uma-configuration`
##### getConfiguration
**GET** `/oxauth/uma-configuration`

Provides configuration data as json document. It contains options and endpoints supported by the authorization server.


###### URL
    http://gluu.org/oxauth/uma-configuration
###### Parameters

###### Response
[UmaConfiguration](#UmaConfiguration)


###### Errors
<table border="1">
    <tr>
        <th>Status Code</th>
        <th>Reason</th>
    </tr>
        <tr>
            <td>500</td>
            <td>Failed to build Uma configuration json object.</td>
        </tr>
</table>


- - -

## Data Types


## <a name="UmaConfiguration">UmaConfiguration</a>

<table border="1">
    <tr>
        <th>type</th>
        <th>required</th>
        <th>access</th>
        <th>description</th>
        <th>notes</th>
    </tr>
        <tr>
            <td>Array[string]</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>string</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>Array[string]</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>Array[string]</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>string</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>string</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>Array[string]</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>string</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>string</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>string</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>string</td>
            <td>required</td>
            <td>-</td>
            <td>A URI indicating the party operating the authorization server.</td>
            <td>A URI indicating the party operating the authorization server.</td>
        </tr>
        <tr>
            <td>string</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>string</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>Array[string]</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>string</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>string</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>Array[string]</td>
            <td>optional</td>
            <td>-</td>
            <td>-</td>
            <td>-</td>
        </tr>
        <tr>
            <td>string</td>
            <td>required</td>
            <td>-</td>
            <td>The version of the UMA core protocol to which this authorization server conforms. The value MUST be the string "1.0".</td>
            <td>The version of the UMA core protocol to which this authorization server conforms. The value MUST be the string "1.0".</td>
        </tr>
</table>

