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



