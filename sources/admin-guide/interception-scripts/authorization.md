# Authorization interception scripts

## Introduction

UMA


## Algorithm

Rules:

- Policy protects scopes. If scope is protected by policy then during RPT authorization such policy script must return true in order to authorize access to resource, otherwise authorization is denied.
- Scope can be protected by multiple policies. If one scope is protected by multiple policies then all policies must return true to authorize access. If at least one policy returned false then authorization is denied.
/sources/img/interception_scripts/uma_policy_handling.jpg
![Alt text](/img/interception_scripts/uma_policy_handling.jpg "UMA policy handling")

## Policy definition

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

## Interception script

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

[UMA]: http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol

