# SAML

During deployment of the Gluu Server, you can choose to install up to two SAML IDPs. The two options are Shibboleth and Asimba.  Whether or not you want one or both of these SAML IDPs is dependant upon your SAML requirements.

# Outbound vs. Inbound SAML
- [Outbound SAML](./outbound-saml.md): Shibboleth is a thoroughly tested and stable SAML IDP. The main use case for Shibboleth is outbound SAML, which is the most typical flow for single sign-on (SSO). For example, if you wanted to create SSO to an app like Google Mail or Salesforce, you would use outbound SAML. 

- [Inbound SAML](./inbound-saml.md): Asimba is a well tested and stable SAML Proxy that can be used to support inbound SAML requirements. The main use case for Asimba is to enable websites to use a single IDP for SSO, even when the organization may have a number of IDPs that are trusted. 

*Note:* The Gluu Server GUI has interfaces for managing outbound SAML (Shibboleth). To manage Inbound SAML (Asimba), you will need to manually edit XML files as needed.   

# SP Configuration

The Shibboleth Service Provider (SP) software is used to protect applications and is configured via an apache module. Use [this guide](./saml-sp-configuration.md) to install the SP software. 





