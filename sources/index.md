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
The Gluu Server can be deployed on any physical or virtual server. The Gluu Server Community Edition (CE) is distributed in a `chroot` container. Container distribution enables Gluu to ensure that all the pieces are working together. 

### Deployment Models:
**Community Edition (CE):** The Gluu Server CE deploys all services in one `chroot` container and can be deployed in production, with an unlimited number of users, for free. Community support is available on our [public forum](https://support.gluu.org), or you can purchase one of our [support plans](http://gluu.org/pricing) to open private tickets, get an SLA on support responses, and enlist security and support consultations with Gluu’s trained support staff.

**Docker Edition (DE):** Gluu Server Docker Edition promises scalability, reliability and a fail-over mechanism through its innovative design implemented using Docker. We are still fine tuning the Docker Edition distribution, and anticipate it's official release in June, 2016. To learn more, please [schedule a meeting with us](http://gluu.org/booking).

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


