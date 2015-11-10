<!--- 
				********** This part needs some maintenance **********
**Table of Contents**

- [SCIM Overview](#scim-overview)
- [Specification](#specification)
	- [Available Endpoints](#available-endpoints)
	- [Authentications](#authentications)
	- [Data representation formats](#data-representation-formats)
- [SCIM Operations](#scim-operations)
	- [Adding a new User](#adding-a-new-user)
	- [Getting a user](#getting-a-user)
	- [Modifying a user](#modifying-a-user)
	- [Delete a user](#delete-a-user)
	- [Bulk Request](#bulk-request)
	- [Getting list of users](#getting-list-of-users)
- [SCIM Client API](#scim-client-api)
	- [oxAuth Client Creation](#oxauth-client-creation)
	- [Bulk requests from Excel files](#bulk-requests-from-excel-files)
	- [SCIM 1.1 API](#scim-11-api)
	- [SCIM 2.0 API](#scim-20-api)
- [SCIM Developers Guide](#scim-developers-guide)

[SCIM Resource Management](#scim-resource-management) 
	- [SCIM UMA User Authentication](#scim-uma-user-authentication)
		- [Base Configuration: Create oxAuth Clients, Policies](#base-configuration-create-oxauth-clients-policies)
		- [oxTrust configuration (Resource Server)](#oxtrust-configuration-resource-server) 
		- [SCIM Client (Requesting Party) sample code](#scim-client-requesting-party-sample-code)
	- [SCIM oxAuth Authentication](#scim-oxauth-authentication)
		- [Base configuration: create oxAuth client](#base-configuration-create-oxauth-client)
		- [configuration (Resource Server)](#configuration-resource-server)
		- [SCIM Client (Requesting Party) sample code](#scim-client-requesting-party-sample-code)
	
-->

## SCIM Overview

The Simple Cloud Identity Management (SCIM) specification is a standard
REST/JSON API to standardize user and group CRUD (create, read, update,
delete). You can review the detailed specification at
[http://www.simplecloud.info](http://www.simplecloud.info). The standard
got started when coders from Google and Salesforce started wondering if
they could combine their similar endpoints for user management, reducing
the frustration of the community. Identity Management vendors, who were
writing connectors to both (and many other SaaS providers) also liked
the idea and contributed to the effort. The standard has two major
releases: 1.1 and 2.0. As of Gluu Server 2.4, we support both, although
1.1 will be deprecated soon.

## Specification

SCIM is integrated as a service of oxTrust. To start operating with
SCIM’s web service, you need to send a request to one of SCIM’s
endpoints.

### Available Endpoints

| Resource   | Endpoint           | Operations    | Description     				            |
-------------|:------------------:|:-------------:|:--------------------------------------------|
| User       | /Users             | GET           | Retrieve/Add/Modify	Users			        |
|            |                    | POST	      | 		      				                |
|            |                    | PUT           |                 				            |
|            |                    | DELETE	      |                 				            |
| Group      | /Groups            | GET           | Retrieve/Add/Modify	Groups			        |
|            |                    | POST	      | 		    				                |
|            |                    | PUT           |                				                |
|            |                    | DELETE	      |                 				            |
| Bulk       | /Bulk              | 	          | Adding/Modifying resources in bulk          |
|            |                    | 		      | 			                        	    |

### Access Management

SCIM APIs are very powerful. While the SCIM APIs do not specify how you
protect them--its considered to be outside the scope of the document--it
does say that OAuth2 is one of the options. So it made sense for Gluu to
use the UMA APIs to issue tokens which are required to call the SCIM
APIs.

Example:

```
POST https://idp.example.com/identity/seam/resource/restv1/Users/ 
Accept: application/json 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

How do you get one of these bearer tokens? You'll need to read up on the
UMA protocol. Basically, the first time you call the SCIM API, oxTrust
will return both a 403 error code, and permission ticket. Your UMA
client will have to present this permission ticket to the oxAuth UMA
Authorization API endpoints (the rpt_endpoint) to obtain a valid token.

From the Gluu Server admin perspective, you will need to make sure there
is an UMA Scope created, and that this scope is associated with a policy
that enables the client to call the SCIM APIs. For example, out of the
box, the Gluu Server ships with a policy for an client id white list.

For more information, see the Gluu Server UMA documentation. Just
remember for SCIM, oxTrust is the "UMA Resource Server", and the SCIM
client is the UMA Client.

## SCIM REST API Reference

For API documentation, have a look at the reference section:

 * [SCIM 1.1 API Reference](../../reference/api/scim-1.1.md)
 * [SCIM 2.0 API Reference](../../reference/api/scim-2.0.md)

## SCIM Client Library

SCIM Client library is a Java SDK to facilitate SCIM development. It can
be found on Gluu's Github repository:

 * [https://github.com/GluuFederation/SCIM-Client](https://github.com/GluuFederation/SCIM-Client)

### oxAuth Client Creation

It’s possible to create an oxAuth client dynamically using SCIM-Client, this option is available using the 
static *create* method of the class `OxAuthClientCreator`, where `applicationName` is the name of the desired client, 
`registerUrl` is the client registration url example:
`https://idp.example.com/oxauth/seam/resource/restv1/oxauth/register`
and `redirectUris` is a space separated String containing the desired redirect urls.

```
CreationResult response = OxAuthClientCreator.create( applicationName, registerUrl, redirectUris);
response.getStatus(); // the status of the request 200 if successful
response.getClientId(); // the generated clientID
response.getClientSecret(); // the generated clientSecret
response.getExpiresAt(); // the expiration date of the client
```

### Bulk requests from Excel files

Spreadsheets can be handy. Gluu have embedded SCIM-client with methods that can help you turn an Excel file into a 
ScimBulkOperation object. For that reason we made two methods available, one for generation bulk users request 
*mapUsers* method and the other for generating bulk group requests *mapGroups* method, both methods take the path to 
the “XLS” file as a parameter, methods are available at “ExcelMapper” class:

```
ScimBulkOperation usersOperation = ExcelMapper.mapUsers(excelFileLocationUsers);
ScimBulkOperation groupsOperation = ExcelMapper.mapGroups(excelFileLocationGroups);
```

You can download the Excel file models from here: 
https://github.com/GluuFederation/SCIM-Client/tree/master/doc/SampleXLS

Excel files must follow the exact structure, the “Operation” cell defines the type of the operation ”Add, Update, Delete” .
For groups you can always add more groups to the spreadsheet following the same structure.


<!--
				********** This part needs some maintenance **********

## SCIM Developers Guide
SCIM provides the developers and standardize way to retrieve (or update) user profile information from a data source. 
To elaborate, developers have no need to manage connections to the SQL tables at back-end.
Gluu's implementation of SCIM also facilitates the developers in performing User, Group and Bulk CRUD operations. 
Complete developer guide can be found [Here](http://www.gluu.org/docs/reference/lib/using-scim/).

## SCIM Resource Management

Gluu supports SCIM 1.1 and 2.0 for user management. By using SCIM
services, you can create and manage Users as well as Groups for your
organization automatically.

At the moment, SCIM endpoints allow two types of Authentication modes:

1. SCIM UMA Authentication
2. SCIM oxAuth Authentication

To use any of the given authentication mode, we need to create user
instance with specified authentication mode. We'll discuss each of the
methods here:

### SCIM UMA User Authentication

This is step by step guide to configure UMA for oxTrust and SCIM client. 

#### Base Configuration: Create oxAuth Clients, Policies

1. Register oxAuth client with scope “uma_protection”. Property
“oxAuthTokenEndpointAuthMethod” of this client should has value
“client_secret_basic”. It's possible to do that using few methods:
[Client
Registration](http://ox.gluu.org/doku.php?id=oxauth:clientregistration),
using [oxTrust](http://ox.gluu.org/doku.php?id=oxtrust:home) GUI,
manually add entry to LDAP. oxTrust will use this oxAuth client to
obtain PAT. Sample result entry:

        dn: inum=@!1111!0008!F781.80AF,ou=clients,o=@!1111,o=gluu
        objectClass: oxAuthClient
        objectClass: top
        displayName: Resource Server Client
        inum: @!1111!0008!F781.80AF
        oxAuthAppType: web
        oxAuthClientSecret: eUXIbkBHgIM=
        oxAuthIdTokenSignedResponseAlg: HS256
        oxAuthScope: inum=@!1111!0009!6D96,ou=scopes,o=@!1111,o=gluu
        oxAuthTokenEndpointAuthMethod: client_secret_basic

2. Register oxAuth client with scope “uma_authorization”. Property
“oxAuthTokenEndpointAuthMethod” of this client should has value
“client_secret_basic”. It's possible to do that using few methods:
[Client
Registration](http://ox.gluu.org/doku.php?id=oxauth:clientregistration),
using [oxTrust](http://ox.gluu.org/doku.php?id=oxtrust:home) GUI,
manually add entry to LDAP. SCIM Client will use this oxAuth client to
obtain AAT. Sample result entry:

        dn: inum=@!1111!0008!FDC0.0FF5,ou=clients,o=@!1111,o=gluu
        objectClass: oxAuthClient
        objectClass: top
        displayName: Requesting Party Client
        inum: @!1111!0008!FDC0.0FF5
        oxAuthAppType: web
        oxAuthClientSecret: eUXIbkBHgIM=
        oxAuthIdTokenSignedResponseAlg: HS256
        oxAuthScope: inum=@!1111!0009!6D97,ou=scopes,o=@!1111,o=gluu
        oxAuthTokenEndpointAuthMethod: client_secret_basic

3. Create UMA policy. These are list of steps which allows to add new policy: 

 	1. Log with administrative privileges into oxTrust.
 	2. Open menu “Configuration→Manage Custom Scripts”.
 	4. Select “UMA Authorization Policies” tab and click “Add custom script configuration”.
 	5. Select language “Python”.
 	6. Paste this base policy script:


            from org.xdi.model.custom.script.type.uma import AuthorizationPolicyType
            from org.xdi.util import StringHelper, ArrayHelper
            from java.util import Arrays, ArrayList
            from org.xdi.oxauth.service.uma.authorization import AuthorizationContext

            import java

            class AuthorizationPolicy(AuthorizationPolicyType):
                def __init__(self, currentTimeMillis):
                    self.currentTimeMillis = currentTimeMillis

            def init(self, configurationAttributes):
                print "UMA authorization policy. Initialization"
                print "UMA authorization policy. Initialized successfully"

                return True   

            def destroy(self, configurationAttributes):
                print "UMA authorization policy. Destroy"
                print "UMA authorization policy. Destroyed successfully"
                return True   

            def getApiVersion(self):
                return 1

            # Authorize access to resource
            #   authorizationContext is org.xdi.oxauth.service.uma.authorization.AuthorizationContext
            #   configurationAttributes is java.util.Map<String, SimpleCustomProperty>
            def authorize(self, authorizationContext, configurationAttributes):
                print "UMA Authorization policy. Attempting to authorize client"
                client_id = authorizationContext.getGrant().getClientId()
                user_id = authorizationContext.getGrant().getUserId()

                print "UMA Authorization policy. Client: ", client_id
                print "UMA Authorization policy. User: ", user_id
                if (StringHelper.equalsIgnoreCase("@!1111!0008!FDC0.0FF5", client_id)):
                    print "UMA Authorization policy. Authorizing client"
                    return True
                else:
                    print "UMA Authorization policy. Client isn't authorized"
                    return False

                print "UMA Authorization policy. Authorizing client"
                return True
 - Replace in script above client inum "@!1111!0008!FDC0.0FF5" with client inum which were added in step 2.
 - Click "Enabled" check box.
 - Click "Update" button.


4. Add UMA scope. These are list of steps which allows to add new scope.

	 - Log with administrative privileges into oxTrust.
	 - Open menu “OAuth2→UMA”.
	 - Select “Scopes” tab and click “Add Scope Description”.
	 - Select “Internal” type.
	 - Fill the form.
	 - Select policy which we added in previous step.
	 - Click “Add” button. Sample result entry:

            dn: inum=@!1111!D386.9FB1,ou=scopes,ou=uma,o=@!1111,o=gluu
            objectClass: oxAuthUmaScopeDescription
            objectClass: top
            displayName: Access SCIM
            inum: @!1111!D386.9FB1
            owner: inum=@!1111!0000!D9D9,ou=people,o=@!1111,o=gluu
            oxPolicyScriptDn: inum=@!1111!CA0D.1918!2DAF.F995,ou=scripts,o=@!1111,o=gluu
            oxId: access_scim
            oxRevision: 1
            oxType: internal

5. Register UMA resource set. It's possible to do that via Rest API or
via oxTrust GUI. Sample code:
[https://github.com/GluuFederation/oxAuth/blob/master/Client/src/test/java/org/xdi/oxauth/ws/rs/uma/RegisterResourceSetFlowHttpTest.java)
These are list of steps which allows to add new resource set:

	 - Log with administrative privileges into oxTrust.
	 - Open menu “OAuth2→UMA”.
	 - Select “Resources” tab and click “Add Resource Set”.
	 - Fill the form.
	 - Add UMA Scope which we created in previous steps.
	 - Add Client which we created in second step.
	 - Click “Add” button. Sample result entry:

                dn: inum=@!1111!C264.D316,ou=resource_sets,ou=uma,o=@!1111,o=gluu
                objectClass: oxAuthUmaResourceSet
                objectClass: top
                displayName: SCIM Resource Set
                inum: @!1111!C264.D316
                owner: inum=@!1111!0000!D9D9,ou=people,o=@!1111,o=gluu
                oxAuthUmaScope: inum=@!1111!D386.9FB1,ou=scopes,ou=uma,o=@!1111,o=gluu
                oxFaviconImage: http://example.org/scim_resource_set.jpg
                oxId: 1403179695657
                oxRevision: 1

#### oxTrust configuration (Resource Server)

Add next oxTrust UMA related configuration properties to oxTrust.properties:

    # UMA SCIM protection
    uma.issuer=https://ce.gluu.info
    uma.client_id=@!1111!0008!F781.80AF
    uma.client_password=<encrypted_password>
    uma.resource_id=1403179695657
    uma.scope=https://ce.gluu.info/oxauth/seam/resource/restv1/uma/scopes/access_scim

Values of these properties correspond to entries from first section.


#### SCIM Client (Requesting Party) sample code

This is sample SCIM Client code which request user information from server.

    package gluu.scim.client.dev.local;
    
    import gluu.scim.client.auth.UmaScimClientImpl;
    import gluu.scim.client.ScimResponse;

    import javax.ws.rs.core.MediaType;
    
    public class TestUMAScimClient {
	    public static void main(String[] args) {
     
		// public UmaScimClientImpl(String domain, String umaMetaDataUrl, String umaAatClientId, String umaAatClientSecret) 
		
		    final UmaScimClientImpl scimClient = new UmaScimClientImpl ("https://ce.gluu.info/identity/seam/resource/restv1", "https://ce.gluu.info/.well-known/uma-configuration",
				    "@!1111!0008!FDC0.0FF5", "secret");

		    try {
			// public ScimResponse retrievePerson(String uid, String mediaType) throws IOException 

			    ScimResponse response1 = scimClient.retrievePerson("@!1111!0008!FDC0.0FF5", MediaType.APPLICATION_JSON);
			    System.out.println(response1.getResponseBodyString());
			

		    } catch (Exception ex) {
			    ex.printStackTrace();
		    }
	    }
    
    }

Values from these example correspond to entries from first section. 

### SCIM oxAuth Authentication

This is a step by step guide to configure oxTrust and SCIM client for
oxAuth authentication.

#### Base Configuration: Create oxAuth Client
In order to access SCIM endpoints, an oxAuth client should be registered
with scopes "openid" and "user_name". Authentication method (or LDAP
Property “oxAuthTokenEndpointAuthMethod”) of this client should have
value “client_secret_basic”.
 
A new client can be created through various methods: [Client
Registration](http://ox.gluu.org/doku.php?id=oxauth:clientregistration),
using [oxTrust](http://ox.gluu.org/doku.php?id=oxtrust:home) GUI, or
manually adding an entry to LDAP.

Sample result entry:

        dn: inum=@!1111!0008!F781.80AF,ou=clients,o=@!1111,o=gluu
        objectClass: oxAuthClient
        objectClass: top
        displayName: SCIM
        inum: @!1111!0008!F781.80AF
        oxAuthAppType: web
        oxAuthClientSecret: eUXIbkBHgIM=
        oxAuthIdTokenSignedResponseAlg: HS256
        oxAuthScope: inum=@!1111!0009!E4B4,ou=scopes,o=@!1111,o=gluu
        oxAuthScope: inum=@!1111!0009!E4B5,ou=scopes,o=@!1111,o=gluu
        oxAuthTokenEndpointAuthMethod: client_secret_basic

####  Configuration (Resource Server)

It's possible to enable/disable SCIM endpoints in oxTrust under
"Organization Configuration" page.

#### SCIM Client (Requesting Party) Sample Code

This is a sample SCIM Client code which requests user information from
server.

    package gluu.scim.client.dev.local;
    
    import gluu.scim.client.ScimClient;
    import gluu.scim.client.ScimResponse;

    import javax.ws.rs.core.MediaType;
    
    public class TestScimClient {
	    public static void main(String[] args) {
		    final ScimClient scimClient = ScimClient.oAuthInstance("admin", "secret", "@!9BCF.396B.14EB.1974!0001!CA0D.1918!0008!2F06.F0DF", "secret",
				    "https://centos65.gluu.info/identity/seam/resource/restv1", "https://centos65.gluu.info/oxauth/seam/resource/restv1/oxauth/token");
		    try {
			    ScimResponse response1 = scimClient.retrievePerson("@!9BCF.396B.14EB.1974!0001!CA0D.1918!0000!A8F2.DE1E.D7FB", MediaType.APPLICATION_JSON);
			    System.out.println(response1.getResponseBodyString());
		    } catch (Exception ex) {
			    ex.printStackTrace();
		    }
	    }
    
    }

Values in this example are correspond to client entry fields from first
section.
-->
