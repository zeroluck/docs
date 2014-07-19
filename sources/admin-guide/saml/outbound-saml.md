# Outbound SAML

## Requirement for Outbound SAML from Gluu Server

Outbound SAML setup from Gluu Server is pretty easy with Gluu Server oxTrust GUI.
Gluu Server require couple of points from that website which will create the
SAML connection with Gluu Server. Here are some points stated below: 

* Metadata of website. 
* Required attributes of website.  
* SSO testing endpoint of website. 

Above three points are described briefly below. 

### Metadata of website: 

Metadata is a XML file which has configuration data used to provision any
website ( SP ) or IDP ( Gluu Server ) to communicate with each other. It's
interchangeable between IDP and SP. 

Websites ( SP ) can provide metadata via URL or as a standalone separate file.
If SP provide an XML separate file, Gluu Server can check the integrity of that
metadata with it's own mechanism, which can be shown and tested from Gluu Server
oxTrust GUI. 

### Required attribute of website: 

Every organization has their own policy to release / share attributes with any
IDP or SP. Gluu Server support and can be configured for standard or custom
attribute. All can be done from Gluu Server oxTrust GUI. 

### SSO testing endpoint of website: 

Every website ( SP ) should have staging and production URL endpoint which can
be checked for SSO, where user will hit to log into that SP. 



