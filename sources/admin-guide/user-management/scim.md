Enable SCIM UMA Authentication
============

This is step by step guide to configure UMA for oxTrust and SCIM client. High level architecture overview is available in article [OX SCIM Architecture Overview](http://ox.gluu.org/doku.php?id=oxtrust:scim:uma_authentication#ox_scim_architecture_overview)

##Base configuration: create oxAuth clients, policies, ...

1. Register oxAuth client with scope [“http://docs.kantarainitiative.org/uma/scopes/prot.json”](http://docs.kantarainitiative.org/uma/scopes/prot.json). Property “oxAuthTokenEndpointAuthMethod” of this client should has value “client_secret_basic”. It's possible to do that using few methods: [Client Registration](http://ox.gluu.org/doku.php?id=oxauth:clientregistration), using [oxTrust](http://ox.gluu.org/doku.php?id=oxtrust:home) GUI, manually add entry to LDAP. oxTrust will use this oxAuth client to obtain PAT. Sample result entry:

        dn: inum=@!1111!0008!F781.80AF,ou=clients,o=@!1111,o=gluu
        objectClass: oxAuthClient
        objectClass: top
        displayName: Resource Server Client
        inum: @!1111!0008!F781.80AF
        oxAuthAppType: web
        oxAuthClientSecret: eUXIbkBHgIM=
        oxAuthIdTokenSignedResponseAlg: HS256
        oxAuthScope:
        inum=@!1111!0009!6D96,ou=scopes,o=@!1111,o=gluu
        oxAuthTokenEndpointAuthMethod: client_secret_basic
        oxAuthTrustedClient: true

2. Register oxAuth client with scope [“http://docs.kantarainitiative.org/uma/scopes/authz.json”](http://docs.kantarainitiative.org/uma/scopes/authz.json). Property “oxAuthTokenEndpointAuthMethod” of this client should has value “client_secret_basic”. It's possible to do that using few methods: [Client Registration](http://ox.gluu.org/doku.php?id=oxauth:clientregistration), using [oxTrust](http://ox.gluu.org/doku.php?id=oxtrust:home) GUI, manually add entry to LDAP. SCIM Client will use this oxAuth client to obtain AAT. Sample result entry:

        dn: inum=@!1111!0008!FDC0.0FF5,ou=clients,o=@!1111,o=gluu
        objectClass: oxAuthClient
        objectClass: top
        displayName: Requesting Party Client
        inum: @!1111!0008!FDC0.0FF5
        oxAuthAppType: web
        oxAuthClientSecret: eUXIbkBHgIM=
        oxAuthIdTokenSignedResponseAlg: HS256
        oxAuthScope:
        inum=@!1111!0009!6D97,ou=scopes,o=@!1111,o=gluu
        oxAuthTokenEndpointAuthMethod: client_secret_basic
        oxAuthTrustedClient: true

3. Add UMA scope. These are list of steps which allows to add new scope.
 * Log with administrative privileges into oxTrust.
 * Open menu “OAuth2→UMA”.
 * Select “Scopes” tab and click “Add Scope Description”.
 * Select “Internal” type.
 * Fill the form.
 * Click “Add” button. Sample result entry:

            dn: inum=@!1111!D386.9FB1,ou=scopes,ou=uma,o=@!1111,o=gluu
            objectClass: oxAuthUmaScopeDescription
            objectClass: top
            displayName: Access SCIM
            inum: @!1111!D386.9FB1
            owner: inum=@!1111!0000!D9D9,ou=people,o=@!1111,o=gluu
            oxId: access_scim
            oxRevision: 1
            oxType: internal

4. Create UMA policy. These are list of steps which allows to add new policy.
 * Log with administrative privileges into oxTrust.
 * Open menu “OAuth2→UMA”.
 * Select “Policies” tab and click “Add Policy”.
 * Select language “Python”.
 * Paste this base policy script:


            from org.xdi.oxauth.service.uma.authorization import IPolicyExternalAuthorization
            class PythonExternalAuthorization(IPolicyExternalAuthorization):
            def authorize(self, authorizationContext):
            print "SCIM policy. Attempting to authorize SCIM client"
            client_id = authorizationContext.getGrant().getClientId()
            print "SCIM policy. SCIM client:", client_id
            print "SCIM policy. Client is authorized"
            return True
 
 * Add UMA Scope which we created in previous step.
 * Click “Add” button. Sample result entry:

                dn: inum=@!1111!EE9C.A253,ou=policies,ou=uma,o=@!1111,o=gluu
                objectClass: oxAuthUmaPolicy
                objectClass: top
                displayName: SCIM policy
                inum: @!1111!EE9C.A253
                oxAuthUmaScope: inum=@!1111!D386.9FB1,ou=scopes,ou=uma,o=@!1111,o=gluu
                oxPolicyScript:: ZnJvbSBvcmcueGRpLm94YXV0aC5zZXJ2aWNlLnVtYS5hdXRob3JpemF0aW9
                uIGltcG9ydCBJUG9saWN5RXh0ZXJuYWxBdXRob3JpemF0aW9uDQogDQpjbGFzcyBQeXRob25FeH
                Rlcm5hbEF1dGhvcml6YXRpb24oSVBvbGljeUV4dGVybmFsQXV0aG9yaXphdGlvbik6DQogDQogI
                CAgZGVmIGF1dGhvcml6ZShzZWxmLCBhdXRob3JpemF0aW9uQ29udGV4dCk6DQogICAgICAgIHBy
                aW50ICJTQ0lNIHBvbGljeS4gQXR0ZW1wdGluZyB0byBhdXRob3JpemUgU0NJTSBjbGllbnQiDQo
                gICAgICAgIGNsaWVudF9pZCA9IGF1dGhvcml6YXRpb25Db250ZXh0LmdldEdyYW50KCkuZ2V0Q2
                xpZW50SWQoKQ0KIA0KICAgICAgICBwcmludCAiU0NJTSBwb2xpY3kuIFNDSU0gY2xpZW50OiIsI
                GNsaWVudF9pZA0KIA0KICAgICAgICBwcmludCAiU0NJTSBwb2xpY3kuIENsaWVudCBpcyBhdXRo
                b3JpemVkIg0KICAgICAgICByZXR1cm4gVHJ1ZQ==
                programmingLanguage: python

5. Register UMA resource set. It's possible to do that via Rest API or via oxTrust GUI. Sample code: [https://svn.gluu.info/repository/openxdi/oxAuth/trunk/Client/src/test/java/org/xdi/oxauth/ws/rs/uma/RegisterResourceSetFlowHttpTest.java.](https://svn.gluu.info/repository/openxdi/oxAuth/trunk/Client/src/test/java/org/xdi/oxauth/ws/rs/uma/RegisterResourceSetFlowHttpTest.java) These are list of steps which allows to add new resource set.
 * Log with administrative privileges into oxTrust.
 * Open menu “OAuth2→UMA”.
 * Select “Resources” tab and click “Add Resource Set”.
 * Fill the form.
 * Add UMA Scope which we created in previous steps.
 * Add Client which we created in second step.
 * Click “Add” button. Sample result entry:

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

##oxTrust configuration (Resource Server)

oxTrust UMA related configuration properties from oxTrust.properties:

    uma.issuer=http://localhost:8080/oxauth/seam/resource/restv1/oxauth/uma-configuration
    uma.client_id=@!1111!0008!F781.80AF
    uma.client_password=<encrypted_password>
    uma.resource_id=1403179695657
    uma.scope=http://localhost:8080/oxTrust/ws/scope/access_scim

Values of these properties correspond to entries from first section.

##SCIM Client (Requesting Party) sample code

This is sample SCIM Client code which request user information from server.

    package gluu.scim.client.dev;
 
    import gluu.scim.client.ScimClient;
    import gluu.scim.client.ScimResponse;
 
    import javax.ws.rs.core.MediaType;
     public class TestScimClient {
    public static void main(String[] args) {
    ScimClient scimClient = ScimClient.umaInstance("http://localhost:8080/oxTrust/seam/resource/restv1", "http://localhost:8080/oxauth/seam/resource/restv1/oxauth/uma-configuration", "@!1111!0008!FDC0.0FF5", "client_password");
    try {
    ScimResponse response1 = scimClient.retrievePerson("@!1111!0000!D9D9", MediaType.APPLICATION_JSON);
            System.out.println(response1.getResponseBodyString());
    } catch (Exception ex) {
    ex.printStackTrace();
    }
    }
 
    }

Values from these example correspond to entries from first section.
