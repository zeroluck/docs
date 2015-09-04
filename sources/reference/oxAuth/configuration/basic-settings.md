
### Basic settings

```
<appliance-inum>%(inumAppliance)s</appliance-inum>
<issuer>https://%(hostname)s</issuer>
<login-page>https://%(hostname)s/oxauth/login.seam</login-page>
<authorization-page>https://%(hostname)s/oxauth/authorize.seam</authorization-page>
<base-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1</base-endpoint>
<authorization-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/authorize</authorization-endpoint>
<token-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/token</token-endpoint>
<userinfo-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/userinfo</userinfo-endpoint>
<clientinfo-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/clientinfo</clientinfo-endpoint>
<check-session-iframe>https://%(hostname)s/oxauth/opiframe.seam</check-session-iframe>
<end-session-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/end_session</end-session-endpoint>
<jwks-uri>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/jwks</jwks-uri>
<registration-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/register</registration-endpoint>
<validate-token-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/validate</validate-token-endpoint>
<federation-metadata-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/federationmetadata</federation-metadata-endpoint>
<federation-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/federation</federation-endpoint>
<openid-discovery-endpoint>https://%(hostname)s/.well-known/webfinger</openid-discovery-endpoint>
<openid-configuration-endpoint>https://%(hostname)s/.well-known/openid-configuration</openid-configuration-endpoint>
<id-generation-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/id</id-generation-endpoint>
<introspection-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/introspection</introspection-endpoint>
<uma-configuration-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/uma-configuration</uma-configuration-endpoint>
```
