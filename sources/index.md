[TOC]
# Gluu Server Administration Docs
Gluu Server is a free open source access management suite of software primarily written in java. The Gluu Server combines best-of-breed open source identity and access management software with easy deployment and administration, and is engineered to support robust enterprise requirements for uptime and availability.

The code is open source, and available on [Github](github.com/GluuFederation/).

Community support can be enlisted either on the [Gluu website](http://gluu.org) or by opening an issue on [Github](github.com/GluuFederation/). Gluu also offers [VIP support and operational services](gluu.org/pricing) and can refer your organization to one of our world-class [integration partners](http://www.gluu.org/partners/current-partners/) for any custom development and integration needs.

# Navigating The Docs
The menu on the left can be used to navigate the docs. However for convenience the following is given.
## Install Gluu Server
|	Operating System	|	Version		|
|-------------------------------|-----------------------|
|	Ubuntu			|**[14.04](./deployment/ubuntu.md)**|
|	CentOS			|**[6.x](./deployment/centos.md) <br/> [7.2](./deployment/centos7.md)**|
|	RHEL			|**[6.x](./deployment/rhel.md)**|

## Configure Cluster
Please use the following to confugure Gluu Server manual cluster.

* [**Cluster with Gluu Server**](./cluster/index.md)
## Gluu Server GUI
The following pages explain the oxTrust GUI

|	oxTrust Tab Menu	|	Sub-menu	|
|-------------------------------|-----------------------|
|**[Configuration](./oxtrust/configuration.md)**| [oxTrust JSON Configuration](./gluu-defaults/oxtrust-properties.md) <br/>[oxAuth JSON Configuration](./gluu-defaults/oxauth-properties.md)<br/> [Cache Refresh/Backend LDAP/AD](./cache-refresh/index.md)|
|SAML|[Outbound](./integrate/outbound-saml.md)<br/> [Inbound](./integrate/inbound-saml.md)|
|**[OpenID Connect](./integrate/openid-connect.md)**|n/a|
|**[UMA](./integrate/uma.md)**|n/a|
|**[Users](./oxtrust/users.md)**|[Import People](./cache-refresh/xlsfile.md)|
|**[Personal](./oxtrust/personal.md)**|n/a|

## Integrate Gluu Server
### Service Provider/Requesting Party Integration
|	SAML SP	|	OpenID Connect RP	|
|---------------|-----------------------|
|[CentOS](./integrate/apache-saml.md)|[CentOS](./integrate/centos-installation.md)|
|[Ubuntu](./integrate/ubuntu-shib-apache.md)|[Ubuntu](./integrate/ubuntu-installation.md)|
|[IIS 7](./integrate/iis-saml.md)|
|[Windows](./integrate/saml-windows.md)|

### Integration Guides

|SSO|Plugin|
|---|------|
|[Google](./integrate/google-saml.md)|[Liferay](./integrate/oxray.md)
|[Hobsons](./integrate/hobsons-saml.md)|
|[Salesforce](./integrate/salesforce-sso.md)|

## Authentication
| Multi Factor Guides|
|--------------------|
|[DUO](./multi-factor/duo.md)|
|[U2F](./multi-factor/u2f.md)|
|[oxPush2](./multi-factor/oxpush2.md)|
|[Wikid](./multi-factor/wikid.md)|
|[Certificate](./multi-factor/cert.md)|

## Support
Please see the [FAQ Page](./faq/troubleshooting.md) for basic troubleshooting, or [open a ticket](http://support.gluu.org) on our support portal for community support. Gluu also offers paid support. Please view our [pricing page](http://gluu.org/pricing) to learn more about our VIP support options. 
