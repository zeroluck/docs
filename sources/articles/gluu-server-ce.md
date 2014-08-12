# Gluu Server CE QuickStart 

So you want to try out the Gluu Server. The Community Edition (CE) 
is a great place to start. This article will provide an overview of
deployment and testing so you'll be ready to start integrating apps ASAP. 

## Installation

Gluu will publish binaries for as many OS's as possible. Currently, the 
easiest installation option is  
[CENTOS](http://www.gluu.org/docs/admin-guide/installation/centos)

## Installation of the mod_ox for testing

mod_ox is an access control module that enables a server to support OpenID Connect and UMA endpoints. It is written in C.  Right now the instructions can be found in the following [pdf document](http://www.gluu.co/modox-pdf) Instructions are available for Apache on Windows, Ubuntu, and CentOS.

## Test Use cases

-  Login to oxTrust: test SSO to protected apache folder
-  Login to apache folder: test SSO to oxTrust
-  Logout from apache folder: test logout of oxTrust
-  Logout from oxTrust: test logout of index.html
  
## Next steps

After you try these, you may want to configure open source software
that supports OpenID Connect. 
-  Restart


