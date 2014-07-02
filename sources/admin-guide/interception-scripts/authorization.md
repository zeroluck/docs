# Authorization interception scripts

## Introduction

User-Managed Access ([UMA]) is an OAuth-based web-based access management protocol. The protocol is defined in a draft version 1.0 specification. A corresponding specification defines obligations of legally responsible parties that engage in UMA-conforming interactions. Gluu Server implements UMA protocol and use it actively for protecting resources. It's possible to hook up authorization interception script which may contain logic when to grand (or forbid) access. All terminology used by this page is borrowed from UMA and Connect specs.

## Algorithm

Rules:

- Policy protects scopes. If scope is protected by policy then during RPT authorization such policy script must return true in order to authorize access to resource, otherwise authorization is denied.
- Scope can be protected by multiple policies. If one scope is protected by multiple policies then all policies must return true to authorize access. If at least one policy returned false then authorization is denied.

![Alt text](/img/interception_scripts/uma_policy_handling.jpg "UMA policy handling")

## Policy definition in LDAP

Gluu Server uses LDAP for storing information, therefore here we consider Policy definition in LDAP format. Policy may contain authorization interception script coded in Python.

Language support:

- Python - supported
- JavaScript - not supported (Right now we support only Python interception scripts however it's possible to plug-in any interpreter language, e.g. JS, please check Gluu Server release notes for more information).

Policy entries location: ou=policies,ou=uma,o=<your organization id>,o=gluu (e.g. ou=policies,ou=uma,o=@!1111,o=gluu )

    dn: inum=@!1111!0009!BC01!0000,ou=policies,ou=uma,o=@!1111,o=gluu
    displayName: Only people from Austin can login
    description: <some description of the policy>
    oxPolicyScript: <Python or JavaScript or whatever script code here>
    programmingLanguage: Python
    inum: @!1111!0009!BC01!0000
    oxAuthUmaScope: http://photoz.example.com/dev/scopes/view
    oxAuthUmaScope: http://photoz.example.com/dev/scopes/all
    objectClass: oxAuthUmaPolicy
    objectClass: top

## Interception script Java interface

    public interface IPolicyExternalAuthorization {
        public boolean authorize(AuthorizationContext p_authorizationContext);
    }

    public interface IAuthorizationContext {
        String getClientClaim(String claimName);
        String getUserClaim(String claimName);
        String getRequestClaim(String claimName);
        String getUserClaimByLdapName(String ldapName);
        Integer getAuthLevel();
        String getAuthMode();
        String getIpAddress();
        boolean isInNetwork(String cidrNotation);
        RequesterPermissionToken getRPT();
        ResourceSetPermission getPermission();
        AuthorizationGrant getGrant(); // here return unmodifiable version of grant, e.g. to avoid new token creation
        HttpServletRequest getHttpRequest();
    }

## Sample (Python)

Python sample authorization script (authorize only if user location claim equals to Austin)

    from org.xdi.oxauth.service.uma.authorization import IPolicyExternalAuthorization
    from org.xdi.util import StringHelper

    class PythonExternalAuthorization(IPolicyExternalAuthorization):

        def authorize(self, authorizationContext):

            print "authorizing..."

            if StringHelper.equalsIgnoreCase(authorizationContext.getUserClaim("locality"), "Austin"):
                print "authorized"
                return True

            return False

## Sample LDIF of policy LDAP entry

    dn: inum=@!1111!0008!B0DA.6413,ou=policies,ou=uma,o=@!1111,o=gluu
    description: Sample policy
    displayName: Sample policy
    inum: @!1111!0008!B0DA.6413
    objectClass: oxAuthUmaPolicy
    objectClass: top
    oxAuthUmaScope: http://photoz.example.com/dev/scopes/view
    oxPolicyScript: from org.xdi.oxauth.service.uma.authorization import IPolicyExternalAuthorization
    from org.xdi.util import StringHelper

    class PythonExternalAuthorization(IPolicyExternalAuthorization):

        def authorize(self, authorizationContext):

            print "authorizing..."

            if StringHelper.equalsIgnoreCase(authorizationContext.getUserClaim("locality"), "Austin"):
                print "authorized"
                return True

            return False

    programmingLanguage: python

## Sample of RPT LDAP entry

    dn: uniqueIdentifier=2f7600e4-e463-4bae-a76e-de14e74ba98f,ou=uma_requester_permission_token,inum=@!1111!0008!FF81!2D39,ou=clients,o=@!1111,o=gluu
    objectClass: oxAuthUmaRPT
    objectClass: top
    oxAmHost: localhost
    oxAuthClientId: @!1111!0008!FF81!2D39
    oxAuthCreation: 20130221152208.888Z
    oxAuthExpiration: 20130221162208.674Z
    oxAuthTokenCode: 462e2e91-af7f-42cd-94ad-e9c70ca908c9/34E7.FE4E.3FBF.AA26.A4FA.70CF.986A.8E35
    oxAuthUserId: mike
    oxUmaPermission: oxTicket=b3e731a5-c3f0-4bc7-b8f6-d67e34bdb78c,ou=uma_resource_set_permission,inum=@!1111!0008!FF81!2D39,ou=clients,o=@!1111,o=gluu
    uniqueIdentifier: 2f7600e4-e463-4bae-a76e-de14e74ba98f

## Sample of Permission LDAP entry
    dn: oxTicket=b3e731a5-c3f0-4bc7-b8f6-d67e34bdb78c,ou=uma_resource_set_permission,inum=@!1111!0008!FF81!2D39,ou=clients,o=@!1111,o=gluu
    objectClass: top
    objectClass: oxAuthUmaResourceSetPermission
    oxAmHost: localhost
    oxAuthExpiration: 20130221152315.692Z
    oxAuthUmaScope: http://photoz.example.com/dev/scopes/view
    oxConfigurationCode: 9541.39E1.8A64.6366.9F6D.8DC9.318C.CBF9.1361460135693
    oxHost: photoz.example.com
    oxResourceSetId: 1361460127791
    oxTicket: b3e731a5-c3f0-4bc7-b8f6-d67e34bdb78c

## Sample of Resource Set LDAP entry

    dn: oxId=1361460127791,ou=uma_resource_sets,inum=@!1111!0008!FF81!2D39,ou=clients,o=@!1111,o=gluu
    displayName: Photo Album
    objectClass: oxAuthUmaResourceSet
    objectClass: top
    owner: inum=@!1111!0000!D4E7,ou=people,o=@!1111,o=gluu
    oxAuthUmaScope: http://photoz.example.com/dev/scopes/view
    oxAuthUmaScope: http://photoz.example.com/dev/scopes/all
    oxFaviconImage: http://www.example.com/icons/flower.png
    oxId: 1361460127791
    oxRevision: 1

[UMA]: http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol

