# System Requirements

## Hardware

The Gluu Server is very flexible, and can be used for a wide array
of authentication requirements. Depending on the size of your data,
and the number of concurrent authentications you want to be able to 
support, you may need more or less memory or CPU capacity. 

With that said, if you want a place to start to deploy a test server,
we would recommend at least 2 CPU units, 4 GB of RAM and around 30GB of
disk space. 

From there, you may need to adjust the resources based on the
requirements.

## Software

You can build the Gluu Server from source for almost any platform, as 
the components are Java. If you want to use pre-compiled binaries, you'll
probably want to stick with Centos or Ubuntu. See the 
[install instructions](http://www.gluu.org/docs/admin-guide/installation/)
for more information.

## Java
The Gluu Server components have been tested with OpenJDK version 1.7 or later.

## LDAP

The Gluu Server uses LDAP for persistence. The pre-compiled binaries include an OpenDJ server that Gluu compiled from the nightly community build. However,
it is possible to use OpenLDAP or 389DS, as long as you update the schema
and manage the security permissions in those platforms as appropriate. 

