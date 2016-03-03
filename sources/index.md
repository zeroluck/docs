[TOC]

# Gluu Server Documentation 
## Overview
The Gluu Server is an identity and access management suite comprised of
free open source software (FOSS) components. Some of the software was
written by Gluu (everything with an "ox" prefix, like "oxAuth"), and
some of the software we forked from existing open source projects like
the Shibboleth SAML identity provider, Forgerock community release of
OpenDJ, the Asimba SAML proxy, the CAS authentication server and many
more components that are part of the Linux distributions.

The full suite of software is distributed as Linux packages that support
either single server or clustered deployments. In order to achieve a highly available, clustered Gluu Server infrastrucutre, you'll need a commercial license for the Gluu Server Enterprise Edition (EE).

## Deployment
The Gluu Server can be deployed on any physical or virtual server. Both
distributions of the Gluu Server--Community Edition and Enterprise Edition--are
distributed as containers. Community Edition uses `chroot` containers,
while the Enterprise Edition uses `docker` containers. Container
distribution enables Gluu to make sure that all the pieces are working
together. If the integration of the components were done manually 
then it would be a lengthy and tiresome process.

### Deployment Models:
**Community Edition (CE):** The Gluu Server Community Edition deploys all 
services in one chroot container and can be deployed in production, with 
an unlimited number of users, for free. Community support is available on our 
[public forum](https://support.gluu.org), or you can purchase a [Basic or 
Growing Business support plan](http://gluu.org/pricing) to open private tickets, 
get an SLA on support responses, and enlist security and support consultations 
with Gluu’s trained support staff.

**Enterprise Edition (EE):** Gluu Enterprise Edition promises scalability,
reliability and a fail-over mechanism through its innovative design
implemented using Docker. The cluster server can also call a DOS
service, like DOSarrest, enabling protection from distributed denial of
service attacks. Because the Enteprise Edition introduces new
operational complexities, we recommend getting familiar with Community
Edition before making the leap to Enterprise
Edition.

## Identity Management

To keep the Gluu Server up-to-date with the latest user information
(a.k.a. attributes or claims), your organization can either "push" or
"pull" identity data. In the "pull" mode, otherwise known as [LDAP
Synchronization or Cache
Refresh](./cache-refresh/index.md), the Gluu Server can
use an existing LDAP identity source like Microsoft Active Directory as
the authoritative source of identity information. If you "push"
identities to the Gluu Server, you can use the JSON/REST SCIM 1.1 or 2.0
API.


