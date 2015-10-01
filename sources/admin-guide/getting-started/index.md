# Getting Started

This document will show you how to get up and running with the Gluu Server. It is broken down into the following sections:



## Overview

The Gluu Server is an identity and access management suite comprised of free open source software (FOSS) components. Some of the software was written by Gluu (everything with an "ox" prefix, like "oxAuth"), and some of the software we forked from existing open source projects like the Shibboleth SAML identity provider, Forgerock community release of OpenDJ, the Asimba SAML proxy, the CAS authentication server and many more components that are part of the linux distributions. Learn more about each of the open source licenses in use [here](../introduction/index.md#licenses).

The full suite of software is distributed as linux packages that support either single server or clustered deployments. In order to deploy the clustered package to multiple locations, you'll need a commercial license. More about that topic below in [Deployment Models](#deployment-models).


## Deployment
The Gluu Server can be deployed on any physical or virtual server. Both distributions of the Gluu Server--Community Edition and Cluster--are distributed as containers. Community edition uses `chroot` containers, while the Cluster Edition uses `docker` containers. Container distribution enables Gluu to make sure that all the pieces are working together. If you actually had to integrate all the components of the Gluu Server together, it would take you a long time. 

#### Minimum Server Requirements:    
Depending on the size of your data and the number of concurrent authentications you want to be able to support, you may need more or less memory or CPU capacity. For Gluu Server Community Edition, we recommend at least 2 CPU units, 4 GB of RAM, and around 20GB of disk space. Monitor your system performance, and make sure its not swapping, in which case you should add more RAM, and increase the JVM size of tomcat.
 
#### OS Support:     
We currently support and maintain package repositories for [Ubuntu](../deployment/ubuntu.md), [CentOS](../deployment/centos.md). Red Hat packages are in beta and will be available soon. Fedora and Debian packages are on the roadmap.

#### Available Components
Please review our [deployment guide](../deployment/index.md#available-components) for a list of available components.

#### Deployment Models:  
**Single Server:** You can find deployment instructions for a single instance of the Gluu Server by following one of the links above for your preferred operating system. All single server deployments of the Gluu Server can be deployed in production with an unlimited number of users for free. Community support is available on our [public forum](http://support.gluu.org), or you can purchase [Basic Support](http://gluu.org/pricing) to open private tickets and enlist security and support consultations with Gluu engineers.   

**Clusters:**  To get started, you should try the Single Server deployment first. The Gluu Server Cluster packages require a a commercial license when you deploy a cluster in more than one location. There are three licenses:
  
1. **Ecommerce:** This license enables you to run a cluster consisting of two locations--for example, let's say you have one server on Amazon, and one server on Rackspace. For the first location, you'd use the "master" package, which is free. For the second location, you'd need to purchase the ecommerce license. This license does not include support. The [Cluster  Support](http://gluu.org/pricing) package is highly recommended and includes one license for clusters of up to two locations.
2. **Premium:** The premium cluster license includes three licenses for clusters of up to five locations. The premium license is included with [Premium Support](http://gluu.org/pricing).
3. **Enterprise:** The enterprise cluster license includes a site license for unlimited cluster deployments. It makes license management really easy because you can use the same license for all your environments, like development, QA and production.

## Dashboard
The Gluu Server dashboard shows you metrics on the health and activity of your server(s). It also enables you to view logs, and to manage other common Gluu Server administration tasks. 

## Person Authentication
Correctly identifying people--authentication--is fundamental to Web and mobile security. Using the oxTrust web UI, you can configure built-in or custom business logic for authentication. 

#### Basic Authentication
Passwords do not mitigate a lot of risk, but for many organizations, its still the place to start. With the Gluu Server you can use either an existing LDAP V3 respository like Active Directory,  or you can use the embedded Gluu Server OpenDJ server to store passwords. `Basic` is the [default](../configuration/index.md#manage-authentication) authentication mechanism shipped with every Gluu Server. 

#### Custom Authentication
`Custom Authentication` enables an organization to utilize [interception scripts](../../reference/interception-scripts/index.md#overview) to achieve advanced levels of authentication. Using authentication interception scripts, your organization can call third-party APIs to enable multi-factor authentication (MFA), intrusion detection systems, or make use of multiple backend servers for authentication. 

The Gluu Server currently ships with support for the FIDO U2F standard. Instructions for adding additional strong authentication mechanisms can be found [here](../../reference/interception-scripts/index.md#authentication). 


## Identity Management
To keep the Gluu Server up-to-date with the latest user information (a.k.a. attributes or claims), your organization can either "push" or "pull" identity data. In the "pull" mode, otherwise known as [LDAP Syncronization or Cache Refresh](../../articles/cache-refresh.md), the Gluu Server can use an existing LDAP identity source like Microsoft Active Directory as the authoritative source of identity information. If you "push" identities to the Gluu Server, you can use the JSON/REST SCIM 1.1 or 2.0 API. 

[Local user management](../user-management/index.md#local-user-management) can also be performed inside the Gluu Server management interface.


## Single Sign-On (SSO)
Now it's time to connect your endpoints, portals or websites with your Gluu Server. The Gluu Server stack includes both a [SAML](../saml/index.md) and [OpenID Connect Identity Provider](../openid-connect/index.md) which can be configured for single sign-on to any SAML 2.0 or OpenID Connect protected application.

Here are a couple how-to's for creating SSO to popular apps:

- [Using SAML to get SSO with Google Apps](../../articles/google-saml.md)  
- [Using SAML to get SSO with Salesforce.com](../../articles/salesforce-sso.md)  


## Web & API Access Management
The Gluu Server includes an [UMA Authorization Server (AS)](../uma/index.md) that can be used to enforce policies for access to any API or web resource. UMA is a profile of OAuth2 that is complimentary to OpenID Connect. UMA defines RESTful, JSON-based, standardized flows and constructs for access management. 
