# Manage SSL certificate for Apache 

The Gluu Server has different certificates for Apache and SSO handling. For
Apache HTTPS the certificate must be a well known CA certified certificate. For
SSO handling, it can be either a self signed certificate or a CA certified
certificate, there is no hard rule. But in either case, the CN of the
certificate MUST follow the HOSTNAME of the Gluu Server. 

In order to access this feautre, go to Configuration --> Manage Certificate

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/Manage_SSL_cert.png?raw=true)


To update the Gluu Server's SSL certificate, Server admin need to upload both
private key and certificate in upper section ( DA….-JAVA.crt ) of the "Manage
sever SSL certificates" section.

Please note that, private key cannot be password protected and certificate
should be base64 with "crt" extension.  

Upload private key and certificate with "Upload Key" and "Upload cert"
respectively. "Update" the configuration and wait for 10 mins. Our configuration
management system ( Puppet )  will place certificate in corresponding location
automatically. 
