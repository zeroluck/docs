# SAML

There are basically three types of Service Providers there:  

* `In-house SP` ( in-house website which will serve as Service Provider aka. SP ). 
* `Non-Federated SP`. That means, they are *not* included in any federation like InCommon or NJEdge. 
* `Federated SP`. Those which are federated with some federation. i.e. Educause is such SP which is federated with InCommon federation. 

All kind of SP can be configured for SSO from Gluu Server. 

* _For `In-house SP`_ : 
       * First, orgnization need to install and configure Shibboleth SP. The base installation of Shibboleth SP can be done by [this](http://www.gluu.org/docs/articles/apache-saml/) way. 
       * Then login to your Gluu IDP and use _Metadata Type: Generate_ . Gluu Server will generate important configuration files which you can place inside of your SP to mostly automate the Trust Relationship with your Gluu Server. Documentation available [here](http://www.gluu.org/docs/admin-guide/saml/outbound-saml/#saml-trust-relationship) [ check out: "Generate" Metadata Type ] 

* _For `Non-Federated SP`_ : SP will provide you metadata and other requirements (i.e: attributes, SSO link etc.) . Such as Desire2Learn. You need to use "File" or "URI" metadata method (to provide SP metdata link / upload ) to create trust relationship from Gluu IDP server. 

* _For `Federated SP`_ : It's pretty straight forward. Create a new trust relationship; Select "Federation", search for your SP's metadata with Gluu Server's in-built feature. Check out: _Federation_ type [here](http://www.gluu.org/docs/admin-guide/saml/outbound-saml/#saml-trust-relationship)

Whatever you have just read are just the into, detailed informations are
available in below links. 


## Contents

- [Outbound SAML](outbound-saml.md)
- [SAML SP Configuration](saml-sp-configuration.md)
- [Inbound SAML](./inbound-saml.md)

