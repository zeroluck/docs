# Default Configuation wihtin Gluu Server
This page contains the default configurations for Gluu Server Community Edition. The defaults are not recommended and can be changed according to the internal policy of the organization. This page will also be helpful in understanding the defaults and changing them.

## OpenID Connect

|Attribute|Description|Default|
|---------|-----------|-------|
|clientSecretExpiresAt | The expiration of client secret|24 hours|

This parameter is used to determine the expiration time of the client secret while registring any client with Gluu Server. This parameter sent along with the register request to Gluu Server.
