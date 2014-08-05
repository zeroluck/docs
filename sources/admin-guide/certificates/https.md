# Manage SSL certificate for Apache 

The Gluu Server has different certificates for Apache and SSO handling. For
Apache HTTPS the certificate must be a well known CA certified certificate. For
SSO handling, it can be either a self signed certificate or a CA certified
certificate, there is no hard rule. But in either case, the CN of the
certificate MUST follow the HOSTNAME of the Gluu Server. 

In order to access this feautre, go to Configuration --> Manage Certificate

This feature of oxTrust allows the Gluu Server Administrator to manage both
types of certificates. The first box which has “DA….-JAVA.crt” operates the SSL
/ Apache / HTTPS functionality of Gluu Server. The second box where there are
“DA…-SHIB.crt” is relevant to the SAML transaction. 

In order to update / install Gluu Server certificates, both Private Key and
Public Certificates are required. Make sure to upload both private and public
keys whenever there is any kind of update required for the server

