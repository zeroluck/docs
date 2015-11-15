# SAML Certificate Management in Gluu Server

SAML Certificate is being used for SAML protocol based SSO. In general,
this is a self-signed certificate with longer validity (1 year up to 10
years).

In order to get this feature open the menu entry Configuration -->
Manage Certificates.

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/Manage_SSL_cert.png?raw=true)

The Gluu Server administrator needs to use both the private key and
the certificate to update the SAML certificate. Use "DA..-SHIB.crt"
section (the lower box) of "Manage server SSL certificates" to perform
this operation.

A private key cannot be password protected, and the certificate should
be base64. The certificate file name has to have a `.crt` extension.

Upload the private key and public certificate with the button "Upload
Key", and "Upload Cert", respectively. Update the configuration and wait
for about 10 minutes. Our configuration management system
([puppet][Puppet]) will perform the rest of the operation to configure
the certificate inside IDP.

[puppet]: https://en.wikipedia.org/wiki/Puppet_%28software%29 "Puppet, Wikipedia"

