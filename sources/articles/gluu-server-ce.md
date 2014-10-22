# Gluu Server CE QuickStart 

So you want to try out the Gluu Server. The Community Edition (CE) is a great place to start. This article will provide an overview of deployment and testing so you'll be ready to start using your new Gluu Server ASAP. 

## What's included in CE?

Currently CE includes the following components:

* **oxAuth:** an inter-op leading [OpenID Connect](http://www.gluu.org/docs/admin-guide/openid-connect/) Provider and a production ready implementation of [UMA](http://www.gluu.org/docs/admin-guide/uma/), a new profile of OAuth2 that defines RESTful, JSON-based, standardized flows and constructs for coordinating the protection of any API or web resource.
* **oxTrust:** the server management interface.
* **LDAP:** included for local storage of user information and configuration data.

Inclusion of Shibboleth and Asimba SAML components is in progress. Stay tuned for updated packages. 

##Licenses

Each component of the Gluu Server is free to use in production. All OX products are MIT License. Learn more  [here](http://www.gluu.org/docs/admin-guide/introduction/licenses/). 

## Installation

Gluu will publish binaries for as many OS's as possible. Currently, the 
easiest installation option is:  

- [CentOS](../admin-guide/installation/centos.md)
- [Ubuntu](../admin-guide/installation/ubuntu.md)


## Installation of mod_ox for testing

mod_ox is an access control apache module that enables an application server to support OpenID Connect and UMA endpoints. mod_ox is written in C.  Installation instructions for Apache on Windows, Ubuntu, and CentOS can be found [here](../admin-guide/mod-ox/index.md)

## Test Use cases

-  Login to oxTrust: test SSO to protected apache folder
-  Login to apache folder: test SSO to oxTrust
-  Logout from apache folder: test logout of oxTrust
-  Logout from oxTrust: test logout of index.html
  

## Support

If you have questions or issues, you can browse our [public knowledge base](http://support.gluu.org) and [register](https://idp.gluu.org/identity/register?redirectUri=https://support.gluu.org) to create public tickets. [VIP support](http://gluu.org/pricing) can be purchased for priority assistance, private support and ad hoc consultations. 

