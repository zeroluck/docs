[TOC]
# OpenID Connect Libraries

## Gluu Core Libraries

The Gluu Server's OpenID Connect components are all MIT open source.
That means you can use either our server or client libraries in your
project, even if it is a part of a commercial product! 

So far, these components are available:

- oxAuth-Server: [Source Code](https://github.com/GluuFederation/oxAuth/tree/master/Server).
- oxAuth-Client: Download [Binary Packages](http://ox.gluu.org/maven/org/xdi/oxauth-client/)
[Source Code](https://github.com/GluuFederation/oxAuth/tree/master/Client).
- oxAuth-RP: A sample Web based OpenID Connect Relying Party developed using our oxAuth Client libraries.
Download [Binary Packages](http://ox.gluu.org/maven/org/xdi/oxauth-rp/)
[Source Code](https://github.com/GluuFederation/oxAuth/tree/master/RP).
- Core JavaDocs are [here](http://ox.gluu.org/oxauth-javadocs/apidocs/)

## OXD

For developers who want to enable OpenID Connect authentication on their
website with a minimal amount of programming, Gluu has developed a
"mediator" called Oxd. Actually, Oxd is a web server--it contains
jetty--and it handles much of the communication with the OpenID
Provider.

![oxd overview](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxd/oxd-rp.png)

Oxd has a very simple web API, which enables either a java, python or
php app to use OpenID connect by implementing only a small number of
methods. For more information, have a look here:

- [oxd-python](https://github.com/GluuFederation/oxd-python)
- [oxd-php](https://github.com/GluuFederation/oxd-php)
- [oxd-java](https://github.com/GluuFederation/oxd/tree/master/oxd-client)

