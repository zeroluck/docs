# SAML certificate management in Gluu Server

SAML Certificate is being used for SAML protocol based SSO. 
Generally this is a self signed certificate with longer validity ( 1 year to 10
years ). 

In order to get this feature: Configuration --> Manage Certificates. 

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/Manage_SSL_cert.png?raw=true)

Gluu Server Administrator need to use both private key and certificate to
update the SAML cert. Use "DA..-SHIB.crt" section (the lower box) of "Manage
server SSL certificates"  to perform this operation. 

Private key cannot be password protected and certificate should be base64 with
"crt" extension. 

Upload the private key and public certificate with "Upload Key" and "Upload
Cert" button respectively. Update the configuration and wait for 10 mins. Our
configuration management system ( Puppet ) will perform the rest of the
operation to configure certificate inside IDP. 

