# Gluu Server UI ( oxTrust ) configuration 

oxTrust is a JBoss Seam application that provides organizational cloud identity
management services, including REST service endpoints and a user friendly cloud
identity management console (aka a GUI). 

oxTrust is tightly coupled with oxAuth. oxAuth configuration is stored in LDAP,
and it would be hard to generate the right configuration entries without
oxTrust. The projects are separate projects because in a high throughput cluster
deployment, many oxAuth servers are needed versus a few oxTrust instances.

In this page we are trying to highlight various features of Gluu oxTrust. 

## Configuration

### Organization Configuration

#### System Configuration:
System Configuration allows the Gluu Server administrator to choose various
options like “Authentication Mode” or “SCIM Support” to be enabled or disabled
system wide.

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/Configuration/System_configuration.png?raw=true)

* _Authentication Mode_ : Various types of authentication methods can be chosen from this interface. Out of the box, the Gluu Server allows ‘basic’ username/password authentication against the server’s local LDAP or any remote Active Directory/LDAP. In addition to passwords, various commercial or custom strong authentication mechanisms can be enabled as well.

### Manage Certificate

### Manage Authentication

### Manage Registration

### SCIM Configuration

### Import People

### Attributes

### Cache Refresh

### Configurate log viewer

### View log file

### Configure Linktrack API

### Status

## SAML

### Trust Relationships

## OAuth2

### Scopes

### Clients

### UMA

### oxPush Applications

### oxPush Devices

## Users

### Manage Groups

### Manage People

## Personal

### Profile

### Manage Registration Links

### Registration Requests

## Logout
