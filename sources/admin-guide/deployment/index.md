**Table of Contents** 

- [Gluu Server Installation](#gluu-server-installation) 
- [Hardware Guidance](#hardware-guidance) 
- [Java](#java) 
- [LDAP](#ldap) 
- [Licenses](#licenses) 

# Gluu Server Installation

For a **one server deployment**, the easiest way to install the Gluu Server is via one of our [Centos](./centos.md) or [Ubuntu](./ubuntu.md) packages.

*Note:* Commercial Gluu Server Cluster Packages are currently under development. You can learn more about the clustering project [here](http://www.gluu.org/docs-cluster/). 

# Support 

Gluu offers both community and VIP support. Anyone can browse and open tickets on our [support portal](http://support.gluu.org). For private support, expedited assistance, and strategic consultations, please [schedule a meeting with us](http://gluu.org/booking) to discuss VIP support options.  

# Hardware Guidance

The Gluu Server is very flexible, and can be used for a wide array of access management requirements. Depending on the size of your data, and the number of concurrent transactions you want to support, you may need more or less memory or CPU capacity. 

With that said, if you are running all the Gluu Server services on one server (i.e. SAML, OAuth2, LDAP), we would recommend at least 2 CPU units, 4 GB of RAM and around 30GB of disk space. Not enough memory may produce some really weird bugs. 

From there, you may need to adjust the resources based on the requirements.  For an overview of Gluu performance considerations, see this [Gluu blog](http://www.gluu.co/so-fast).  

# Java
The Gluu Server components have been tested with OpenJDK version 1.7 or later.

# LDAP

The Gluu Server uses LDAP for persistence to store oxTrust and oxAuth data, and to cache user entries.  The Gluu Server packages include "Gluu OpenDJ", which is our [fork](https://github.com/GluuFederation/gluu-opendj) of OpenDJ 2.6.0, the last open source release by Forgerock.  It is possible to use any LDAP server, as long as you have the schema and security under control. 

We publish the [latest schema](https://github.com/GluuFederation/community-edition-setup/tree/master/static) in our community-edition-setup project. The schema that we publish for Gluu OpenDJ should also work for Forgerock OpenDJ, UnboundID LDAP server, and Oracle Directory Server Enterprise Edition (ODSEE). 

# Licenses

All software used in the Gluu Server is free to use in production. All software developed by Gluu, including oxTrust and oxAuth, are held under an MIT License. Visit [licenses](../../admin-guide/introduction/index.md#licenses) to learn more about the various licenses in use. 

