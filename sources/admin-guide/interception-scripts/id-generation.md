# ID Generation Script

The Gluu Server allows the generation of different types of IDs for internal objects. It's 
possible to hook your own id generation script, if you would perfer another algorithm to provide
unique identifiers, such as a GUID. By default, the Gluu Server returns an XRI i-number, 
which is sort of like a IPv6 address. The reason we do this is because this scheme enables us to 
know what kind of object it is, and what IDP it belongs to, just based on the stable identifier.
But this format sometimes confuses people. So if it bothers you, just write your own script to
provide a different type of identifier. 

The script MUST return a unique identifier, never to be issued again. This is a requirement for
OpenID Connect, and in general its a good LDAP practice to use stable RDN identifiers. 

Like other transformation scripts, oxTrust and oxAuth use Jython to interpret the Python code.
The ID Generation Script MUST implement IdGenerator Java interface.

Interface:


        public interface IdGenerator {

            /**

             * Generates id.
             *
             * @param p_idType   id type : use to specify entity type, i.e. person, client
             * @param p_idPrefix id prefix : If you want to prefix all ids, use this, otherwise pass ""
             * @return generated id as string
             */
            public String generateId(String p_idType, String p_idPrefix);
        }


Sample Script on Python :


        import uuid

        class ExampleDomainUniqueIdPolicyClass(IdGenerator):
            def generateId(self, entityType, prefix):
                print "Generating %s ID for prefix %s" % entityType, prefix
                # make a UUID using an MD5 hash of a namespace UUID and a name
                id = uuid.uuid3(uuid.NAMESPACE_DNS, 'example.co')
                return "%s%s" % (prefix, id)

In the Gluu Server, the ID Generation script is stored in:

        /opt/tomcat/conf/oxauth-id-gen.py

## API Document


### /id

#### Overview


#### `/id/{prefix}/{type}/`
##### generateHtmlInum
**GET** `/id/{prefix}/{type}/`

Generates ID for given prefix and type.
Generates ID for given prefix and type.

###### URL
    http://gluu.org/id/{prefix}/{type}/
###### Parameters
- path

    <table border="1">
        <tr>
            <th>Parameter</th>
            <th>Required</th>
            <th>Description</th>
            <th>Data Type</th>
        </tr>
        <tr>
            <th>prefix</th>
            <td>true</td>
            <td>Prefix for id. E.g. if prefix is @!1111 and server will generate id: !0000 then ID returned by service would be: @!1111!0000</td>
            <td>string</td>
        </tr>
        <tr>
            <th>type</th>
            <td>true</td>
            <td>Type of id</td>
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
[String[Response]](#String[Response])


###### Errors
<table border="1">
    <tr>
        <th>Status Code</th>
        <th>Reason</th>
    </tr>
</table>


- - -
##### generateXmlInum
**GET** `/id/{prefix}/{type}/`

Generates ID for given prefix and type.
Generates ID for given prefix and type.

###### URL
    http://gluu.org/id/{prefix}/{type}/
###### Parameters
- path

    <table border="1">
        <tr>
            <th>Parameter</th>
            <th>Required</th>
            <th>Description</th>
            <th>Data Type</th>
        </tr>
        <tr>
            <th>prefix</th>
            <td>true</td>
            <td>Prefix for id. E.g. if prefix is @!1111 and server will generate id: !0000 then ID returned by service would be: @!1111!0000</td>
            <td>string</td>
        </tr>
        <tr>
            <th>type</th>
            <td>true</td>
            <td>Type of id</td>
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
[String[Response]](#String[Response])


###### Errors
<table border="1">
    <tr>
        <th>Status Code</th>
        <th>Reason</th>
    </tr>
</table>


- - -
##### generateTextInum
**GET** `/id/{prefix}/{type}/`

Generates ID for given prefix and type.
Generates ID for given prefix and type.

###### URL
    http://gluu.org/id/{prefix}/{type}/
###### Parameters
- path

    <table border="1">
        <tr>
            <th>Parameter</th>
            <th>Required</th>
            <th>Description</th>
            <th>Data Type</th>
        </tr>
        <tr>
            <th>prefix</th>
            <td>true</td>
            <td></td>
            <td>string</td>
        </tr>
        <tr>
            <th>type</th>
            <td>true</td>
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
[String[Response]](#String[Response])


###### Errors
<table border="1">
    <tr>
        <th>Status Code</th>
        <th>Reason</th>
    </tr>
</table>


- - -
##### generateJsonInum
**GET** `/id/{prefix}/{type}/`

Generates ID for given prefix and type.
Generates ID for given prefix and type.

###### URL
    http://gluu.org/id/{prefix}/{type}/
###### Parameters
- path

    <table border="1">
        <tr>
            <th>Parameter</th>
            <th>Required</th>
            <th>Description</th>
            <th>Data Type</th>
        </tr>
        <tr>
            <th>prefix</th>
            <td>true</td>
            <td>Prefix for id. E.g. if prefix is @!1111 and server will generate id: !0000 then ID returned by service would be: @!1111!0000</td>
            <td>string</td>
        </tr>
        <tr>
            <th>type</th>
            <td>true</td>
            <td>Type of id</td>
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
[String[Response]](#String[Response])


###### Errors
<table border="1">
    <tr>
        <th>Status Code</th>
        <th>Reason</th>
    </tr>
</table>


- - -

## Data Types
