# Gluu Server CE QuickStart 

So you want to try out the Gluu Server. The Community Edition (CE) is a great place to start. This article will provide an overview of deployment and testing so you'll be ready to start using your new Gluu Server ASAP. 

## What's included in CE?

When you deploy CE, you have the option to include the following components:

* **CAS** is an enterprise Single Sign-On solution for web services. CAS should only be used to connect legacy applications. OpenID Connect and SAML are preferred for new application integrations.
* **Shibboleth** one of the most dependable and heavily tested open source SAML single sign-on servers available. Shibboleth is used in production environments at more than 5,000 organization’s worldwide.
* **oxAuth:** an inter-op leading [OpenID Connect](http://www.gluu.org/docs/admin-guide/openid-connect/) Provider and a production ready implementation of [UMA](http://www.gluu.org/docs/admin-guide/uma/), a new profile of OAuth2 that defines RESTful, JSON-based, standardized flows and constructs for coordinating the protection of any API or web resource.
* **oxTrust:** the server management interface.
* **LDAP:** included for local storage of user information and configuration data.

Inclusion of the Asimba SAML proxy is in progress. 

##Licenses

Each component of the Gluu Server is free to use in production. All OX products are MIT License. Learn more  [here](http://www.gluu.org/docs/admin-guide/introduction/licenses/). 

## Installation

Gluu will publish binaries for as many OS's as possible. Currently, the 
easiest installation option is:  

- [CentOS](../admin-guide/deployment/centos.md)
- [Ubuntu](../admin-guide/deployment/ubuntu.md)

## OpenID Connect RP Libraries

In order to protect your app with OpenID Connect, you will need to call the OpenID Connect APIs from within your application. Depending on what language your using, you'll need to implement those [client libraries](http://openid.net/developers/libraries/). Here's Gluu's [java libraries](https://github.com/GluuFederation/oxAuth).
  

## Support

If you have questions or issues, you can browse our [public knowledge base](http://support.gluu.org) and [register](https://idp.gluu.org/identity/register?redirectUri=https://support.gluu.org) to create public tickets. [VIP support](http://gluu.org/pricing) can be purchased for priority assistance, private support and ad hoc consultations. 

