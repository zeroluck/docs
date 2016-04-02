# Navigate the Docs
This page is added to make basic navigation of the docs easier.

# Install Gluu Server

|	Operating System	|	Version		|
|-------------------------------|-----------------------|
|	Ubuntu			|**[14.04](./deployment/ubuntu.md)**|
|	CentOS			|**[6.x](./deployment/centos.md) <br/> [7.2](./deployment/centos7.md)**|
|	RHEL			|**[6.x](./deployment/rhel.md)**|

## Configure Cluster
Use the following guide to configure cluster
#### [Cluster](./cluster/index.md)

# Gluu Server GUI
The following pages explain the oxTrust GUI

|	oxTrust Tab Menu	|	Sub-menu	|
|-------------------------------|-----------------------|
|**[Configuration](./oxtrust/configuration.md)**| [oxTrust JSON Configuration](./gluu-defaults/oxtrust-properties.md) <br/>[oxAuth JSON Configuration](./gluu-defaults/oxauth-properties.md)<br/> [Cache Refresh/Backend LDAP/AD](./cache-refresh/index.md)|
|SAML|[Outbound](./integrate/outbound-saml.md)<br/> [Inbound](./integrate/inbound-saml.md)|
|**[OpenID Connect](./integrate/openid-connect.md)**|n/a|
|**[UMA](./integrate/uma.md)**|n/a|
|**[Users](./oxtrust/users.md)**|[Import People](./cache-refresh/xlsfile.md)|
|**[Personal](./oxtrust/personal.md)**|n/a|

# Integrate Gluu Server
## Service Provider/Requesting Party Integration
|	SAML SP	|	OpenID Connect RP	|
|---------------|-----------------------|
|[CentOS](./integrate/apache-saml.md)|[CentOS](./integrate/centos-installation.md)|
|[Ubuntu](./integrate/ubuntu-shib-apache.md)|[Ubuntu](./integrate/ubuntu-installation.md)|
|[IIS 7](./integrate/iis-saml.md)|
|[Windows](./integrate/saml-windows.md)|

## Integration Guides

|SSO|Plugin|
|---|------|
|[Google](./integrate/google-saml.md)|[Liferay](./integrate/oxray.md)
|[Hobsons](./integrate/hobsons-saml.md)|
|[Salesforce](./integrate/salesforce-sso.md)|

# Authentication
| Multi Factor Guides|
|--------------------|
|[DUO](./multi-factor/duo.md)|
|[U2F](./multi-factor/u2f.md)|
|[oxPush2](./multi-factor/oxpush2.md)|
|[Wikid](./multi-factor/wikid.md)|
|[Certificate](./multi-factor/cert.md)|

# Questions
Please see the [FAQ Page](./faq/troubleshooting.md) for basic troubleshooting, or [open a ticket](http://support.gluu.org) on our support portal for community support.
