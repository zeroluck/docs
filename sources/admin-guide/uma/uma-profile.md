
# 3.5.1.1. UMA profile for requesting party trust elevation

This section defines the OX claim profile for UMA. Following is a summary:

  - Identifying URI: http://gluu.org/uma/profiles/uma-claim-gluu-1.0
  - Profile author and contact information: Michael Schwartz and Yuriy Zabrovarnyy (info@gluu.org)
  - Updates or obsoletes: None; this profile is new.
  - Syntax and semantics of claim data: As defined below.
  - Claims gathering method: As defined below.
  - Error states: "need_reauthentication" in case AAT is not "strong" enough.
  - Security and privacy considerations: None additional.
  - Binding obligations: None additional.

If an authorization server supports the OX claim profile, it MUST supply the "ox" value for one of its "claim_profiles_supported" values in its configuration data.

To conform to this option, the authorization server MUST do the following:

  - send "need_reauthentication" error in case AAT doesn't correspond to authentication level and (or) mode of authorization policy. Together with error authorization server MUST provide:
      - domain_auth_level - REQUIRED. authentication level required to satisfy authorization policy
      - domain_auth_mode - REQUIRED. authentication mode required to satisfy authorization policy
      - authentication_uri - OPTIONAL. authorization server authentication uri for re-authentication with required authentication level and mode

For example:

```
HTTP/1.1 403 Forbidden
Content-Type: application/json
Cache-Control: no-store
{
  "status": "error",
  "error": "need_reauthentication",
  "domain_auth_level":20,
  "domain_auth_mode":"duo",
  "required_acr_level":2,
  "required_acr_uri":"http://example.com/global_acr",
  "authentication_uri":"http://seed.gluu.org/oxauth?auth_level=20&auth_mode=duo&client_id=..."
}
```

AS with UMA profile MAY also support providing claims in advance directly in authorization request. It may be useful if RP capability is provided implicitly (e.g. Apache module - mod_uma in UMA_NO_RP mode).

Example of authorization request with claims:

```
POST /rpt_authorization HTTP/1.1
Host: as.gluu.org
Authorization: Bearer jwfLG53^sad$#f
...

{
   "rpt": "sbjsbhs(/SSJHBSUSSJHVhjsgvhsgvshgsv",
   "ticket": "016f84e8-f9b9-11e0-bd6f-0021cc6004de",
   "claims":{"uid":["user1"],"email":["user1@gluu.org","user1@gmail.com"]}
}
```

## References
- [UMA Specifications](http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol)
- [UMA Requestion Party Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RP/)
- [UMA Resource Server Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RS/)
- [Gluu Server](http://gluu.org)
- [Juju Application Security Framework (JASF) Overview](http://www.gluu.co/juju-draft-overview)

[UMA]: http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol