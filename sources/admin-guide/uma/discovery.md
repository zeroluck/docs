# Discovery

Gluu Server provides configuration data as JSON document under:

```
https://gluuserver.org/.well-known/uma-configuration
```

Gluu Server response for UMA configuration MAY contain standard properties (defined by UMA specification) as well as custom properties (extension that is out of scope of this document). Gluu Server guarantees property name uniqueness within response.

Typical response looks as following:

``` json
{
  "version": "1.0",
  "issuer": "https://gluuserver.org",
  "pat_profiles_supported": [
    "bearer"
  ],
  "aat_profiles_supported": [
    "bearer"
  ],
  "rpt_profiles_supported": [
    "bearer"
  ],
  "pat_grant_types_supported": [
    "authorization_code"
  ],
  "aat_grant_types_supported": [
    "authorization_code"
  ],
  "claim_profiles_supported": [
    "openid"
  ],
  "dynamic_client_endpoint": "https://gluuserver.org/oxauth/seam/resource/restv1/oxauth/register",
  "token_endpoint": "https://gluuserver.org/oxauth/seam/resource/restv1/oxauth/token",
  "user_endpoint": "https://gluuserver.org/oxauth/seam/resource/restv1/oxauth/authorize",
  "introspection_endpoint": "https://gluuserver.org/oxauth/seam/resource/restv1/host/status",
  "resource_set_registration_endpoint": "https://gluuserver.org/oxauth/seam/resource/restv1/host/rsrc",
  "permission_registration_endpoint": "https://gluuserver.org/oxauth/seam/resource/restv1/host/rsrc_pr",
  "rpt_endpoint": "https://gluuserver.org/oxauth/seam/resource/restv1/requester/rpt",
  "authorization_request_endpoint": "https://gluuserver.org/oxauth/seam/resource/restv1/requester/perm",
  "scope_endpoint": "https://gluuserver.org/oxauth/seam/resource/restv1/uma/scopes"
}
```

## References
- [UMA Specifications](http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol)
- [UMA Requestion Party Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RP/)
- [UMA Resource Server Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RS/)
- [Gluu Server](http://gluu.org)
- [Juju Application Security Framework (JASF) Overview](http://www.gluu.co/juju-draft-overview)

[UMA]: http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol
