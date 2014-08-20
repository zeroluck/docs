# Apache OAuth2 using mod_ox

mod_ox is an access control module implementing OIC+UMA and acts as Resource
Server side.

* OIC is implementing Implicit Flow of OpenID Connect specifications.
* UMA is implementing an User-Managed Access (UMA)

## Big picture

Solution consists of two parts:

* mod_ox - new apache module written in C which is loaded by httpd.
* oxd - mediator between mod_ox and UMA Authorization server. oxd is java application.

mod_ox defines set of custom directives for correct module configuration.

Communication between mod_ox and oxd is made via sockets on port 8099 (Port
should be configurable, 8099 should be used as default and fallback port).

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/openid_connect/oxd_overview.png?raw=true)

## Installation

These docs assume that you have Apache2/HTTPD installed and running already. Both of
Linux and Windows are supported.

### Prerequisites

* [memcached](http://memcached.org/) - An in-memory key-value store for small chunks of arbitrary data (strings, objects)
* oxd - It's a mediator betweenApache plugins (mod_ox, mod_uma) and OIC/UMA Authorization server. If you are interested to know more, a full documentation is available [here](http://ox.gluu.org/doku.php?id=oxd:home)

### Source collection

`mod_ox` development release can be collected from Gluu SVN
[link](https://svn.gluu.info/repository/oauth2ApacheHTTPD/MOD_OX/Package/mod_ox-0.1.tar.gz). 

_Note that if you download a development release you will need current versions
of the autotools installed, and you must run ./autogen.sh first before following
these instructions._ 
