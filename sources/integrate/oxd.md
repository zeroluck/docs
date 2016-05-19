[TOC]
# OXD
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

## Documentation
The complete documentation for OXD is made available in a separate address. Please see [this link](https://gluu.org/docs-oxd/) for the OXD documentation.
