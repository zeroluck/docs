# Manage SSL certificate for Apache 

The Gluu Server has different certificates for Apache and SSO handling.
For Apache HTTPS the certificate must be a certificate signed by a well
known Certification Authority (CA). For SSO handling, it can be either a
self signed certificate or a CA certified certificate, there is no hard
rule. But in either case, the CN of the certificate MUST follow the
HOSTNAME of the Gluu Server.

In order to access this feature, go to Configuration --> Manage
Certificate.

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/Manage_SSL_cert.png?raw=true)

To update the Gluu Server's SSL certificate, Server admin need to upload
both private key and certificate in upper section (DA….-JAVA.crt) of the
"Manage sever SSL certificates" section.

Please note that the private key cannot be password protected. The
certificate file should be base64, and its filename has to have a `.crt`
extension.

Upload both the private key and the certificate with "Upload Key" and
"Upload cert", respectively. "Update" the configuration and wait for
about 10 minutes. Our configuration management system ([Puppet][puppet])
will place your certificate in the corresponding location,
automatically.

[puppet]: https://en.wikipedia.org/wiki/Puppet_%28software%29 "Puppet, Wikipedia"

