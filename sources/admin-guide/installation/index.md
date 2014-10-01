# Gluu Server Installation

The easiest sway to install the Gluu Server is to use the [Centos binary distribution](/centos.md). 

## Hardware Guidance

The Gluu Server is very flexible, and can be used for a wide array
of authentication requirements. Depending on the size of your data,
and the number of concurrent authentications you want to be able to 
support, you may need more or less memory or CPU capacity. 

With that said, if you want a place to start to deploy a test server,
we would recommend at least 2 CPU units, 4 GB of RAM and around 30GB of
disk space. 

From there, you may need to adjust the resources based on the
requirements.

## Java
The Gluu Server components have been tested with OpenJDK version 1.7 or later.

## LDAP

The Gluu Server uses LDAP for persistence. The pre-compiled binaries include 
an the Gluu LDAP, which is based on the OpenDJ open source LDAP distribution.
However, it is possible to use OpenLDAP or 389DS, as long as you update the schema
and manage the security permissions in those platforms as appropriate. 
