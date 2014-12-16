# Gluu Server Installation

The easiest way to install the Gluu Server is via one of our binary distributions for Linux. 
You can use our `yum` repository for [Centos](./centos.md) or `apt-get` for 
[Ubuntu](./ubuntu.md)

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
"Gluu OpenDJ", which is our fork of the OpenDJ open source LDAP distribution (which 
we try to keep very closely aligned with the current updates of the main project).
However, it is possible to use OpenLDAP or 389DS. The Gluu Server setup.py installation 
script assumes OpenDJ, so you'd also have to take a close look at that script to make 
sure the same things happen. For example, installing the right schema, index creation, 
read/write permissions, and other configuration is needed.

## Licenses

All software used in the Gluu Server is free to use in production. The core components published by Gluu, oxAuth and oxTrust, are held under an MIT License. Visit [licenses](./introduction/licenses/) to learn more about the various licenses in use. 
