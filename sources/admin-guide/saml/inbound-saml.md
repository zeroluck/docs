# Inbound SAML in Gluu Server

For customers who need to support inbound SAML authentication for partners or
other organizations, we can deploy the Asimba SAML proxy.

The main use case for Asimba is to enable websites to use a single IDP for SSO,
even when the organization may have a number of IDPs that are trusted. For more
information, please contact us.

## Requirement to setup Inbound SAML 

* Metadata of authentication server
* Metadata of websites who will work as servcie provider
* SAML certificate of websites
* SSL certificate of authentication server 
* Required attributes

Above points are described breifly below. 

### Metadata of authentication server

Authentication server can be any remote / native Shibboleth IDP or Microsoft AD
FS. We need metadata of these servers to configure Asimba. After configuration
end user will be able to select their desired authentication server from
Asimba's discovery page. Or, we can configure the "selector" which will
automatically redirect user to desired IDP / ADFS. 

### Metadata of websites who will work as servcie provider

Just like authentication server metadata, Gluu Server - Asimba suite require
metadaa from all websites ( SPs ) which will be connected. 

### SAML certificate of websites

Base64 encoded certificates require to configure the trust store of Asimba
server as it can connect / allow the inbound SAML request from remote SP. 

### SSL certificate of authentication server

Base64 encoded certificates of authentication server is also a requirement. 

### Required attributes

Every organization has their own policy to release / pass few attributes. It can
be standard attribute like UID or email address or can be any custom attribute.
Gluu Engineers need a list of required attributes from organization which they
want to pass between their authentication server and target websites ( SP ). 
