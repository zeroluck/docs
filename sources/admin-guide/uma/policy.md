# UMA Policies

UMA Policy - object that protects UMA Resources. Protection of resources are made via scopes. Gluu server evaluates all policies (identified by scopes) in order to grant access.

UMA Policy main properties are:

  - scopes - policy protects resources by scopes.
  - authorization script - script that is evaluated in order to grant or deny access (script basically returns true of false to server).
  - name - it's better to give good name to policy to understand what exactly it protects.

## Define policy in oxTrust

There two ways to define UMA Policy for Gluu Server:

- Define via oxTrust (Gluu Server admin application)
- Define in LDAP Server directly (advanced users only)

![Alt text](../img/uma/uma_oxtrust_policies.png "UMA Policies")

![Alt text](../img/uma/uma_oxtrust_policy_add.png "UMA Policy Add")


## Algorithm

Rules:

- Policy protects resources based on scopes. If scope is protected by policy then during RPT authorization such policy script must return true in order to authorize access to resource, otherwise authorization is denied.
- Scope can be protected by multiple policies. If one scope is protected by multiple policies then all policies must return true to authorize access. If at least one policy returned false then authorization is denied.
/sources/img/interception_scripts/uma_policy_handling.jpg
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

## References
- [UMA Specifications](http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol)
- [UMA Requestion Party Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RP/)
- [UMA Resource Server Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RS/)
- [Gluu Server](http://gluu.org)
- [Juju Application Security Framework (JASF) Overview](http://www.gluu.co/juju-draft-overview)

[UMA]: http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol
