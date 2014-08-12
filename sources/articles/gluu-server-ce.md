# Gluu Server CE QuickStart 

So you want to try out the Gluu Server. The Community Edition (CE) 
is a great place to start. This article will provide an overview of
deployment and testing so you'll be ready to start integrating apps ASAP. 

## Installation

Gluu will publish binaries for as many OS's as possible. Currently, the 
easiest installation options are:  
- [CentOS](http://www.gluu.org/docs/admin-guide/installation/centos)
- [Ubuntu](http://www.gluu.org/docs/admin-guide/installation/ubuntu)

## Installation of mod_ox for testing

mod_ox is an access control apache module that enables an application server to support OpenID Connect and UMA endpoints. mod_ox is written in C.  Installation instructions for Apache on Windows, Ubuntu, and CentOS can be found in the following [pdf document](http://www.gluu.co/modox-pdf)

## Test Use cases

-  Login to oxTrust: test SSO to protected apache folder
-  Login to apache folder: test SSO to oxTrust
-  Logout from apache folder: test logout of oxTrust
-  Logout from oxTrust: test logout of index.html
  
## Next steps

After you try the above use cases, you may want to configure plugins that supports OpenID Connect, such as the [OpenID Conect Wordpress Plugin](http://www.gluu.co/wordpress-connect). 

## Community Support

If you have questions or issues, you can browse our [public knowledge base](http://support.gluu.org) and [register](https://idp.gluu.org/identity/register?redirectUri=https://support.gluu.org) to create public tickets



