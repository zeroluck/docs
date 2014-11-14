# SAML

There are basically three types of Service Providers:  

* `In-house SP`: ( in-house website which will serve as a Service Provider a.k.a. SP ). 
* `Non-Federated SP`: That means the SP is *not* associated with a federation like InCommon or NJEdge. 
* `Federated SP`: Those which are associated with a federation. For example, Educause is such SP which is included in the InCommon federation. 

All kinds of SP can be configured for SSO from the Gluu Server. 

* _For `In-house SP`_ : 
       * First, the target application needs to have installed and configured the Shibboleth SP software. Instructions for completing a base installation of the Shibboleth SP can be found [here](http://www.gluu.org/docs/articles/apache-saml/). 
       * Then login to your Gluu IDP, navigate to the `SAML Trust Relationships` page, create a new Trust Relationship and use _Metadata Type: Generate_ . Gluu Server will generate important configuration files which you can place inside of your SP to mostly automate the Trust Relationship with your Gluu Server. Documentation is available [here](http://www.gluu.org/docs/admin-guide/saml/outbound-saml/#saml-trust-relationship) [ check out: "Generate" Metadata Type ] 

* _For `Non-Federated SP`_ : SP will provide you their metadata and other requirements (i.e: attributes, SSO link etc.) In the SAML Trust Relationship GUI, you need to use _Metadata Type: "File" or "URI"_ (to provide SP metdata link / upload ). 

* _For `Federated SP`_ : Once you have established trust with a Federation, this method is the most straight forward. Navigate to the Trust Relationship GUI, create a new trust relationship; Select _Metadata Type: "Federation"_, and then search for the correct SP metadata. Check out more instructions  [here](http://www.gluu.org/docs/admin-guide/saml/outbound-saml/#saml-trust-relationship)

These contents are just for introduction, please see the links below for more details.


## Contents

- [Outbound SAML](outbound-saml.md)
- [SAML SP Configuration](saml-sp-configuration.md)
- [Inbound SAML](./inbound-saml.md)

