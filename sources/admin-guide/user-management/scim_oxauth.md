Enable SCIM oxAuth Authentication
============

This is step by step guide to configure oxTrust and SCIM client for oxAuth authentication. 

##Base configuration: create oxAuth client

In order to use access SCIM enpoint new oxAuth should be registered  with scopes "openid" and "user_name". Property “oxAuthTokenEndpointAuthMethod” of this client should has value “client_secret_basic”. It's possible to do that using few methods: [Client Registration](http://ox.gluu.org/doku.php?id=oxauth:clientregistration), using [oxTrust](http://ox.gluu.org/doku.php?id=oxtrust:home) GUI, manually add entry to LDAP. Sample result entry:


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

##oxTrust configuration (Resource Server)

oxTrust allows to enable/disable SCIM endpoints. It's possible to change current state in oxTrust on "Oragnization Configuration" page.

##SCIM Client (Requesting Party) sample code

This is sample SCIM Client code which request user information from server.

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

Values in this example are correspond to client entry fields from  first section.
