# Certificates 

Many of the components of the Gluu Server have cyrpto keys and X.509
certificates. There are many key formats, and keystore formats. Navigate
to the sections below to find what you need for each of the Gluu Server
components.

- [Asimba](#asimba)
- [Apache](#apache)
- [OpenDJ](#opendj)
- [oxAuth](#oxauth)
- [Shibboleth IDP](#shibboleth-idp)

## Asimba
`asimba.crt`, `asimba.csr`, `asimba.key`, `asimba.key.orig`,
`asimba.pkcs12 and asimbaIDP.jks` are associated with the
[asmiba][Asimba SAML Proxy Server]. If you install the SAML Proxy Server
(Asimba) in your Gluu Server, you have to deal with these certificate
and key.

## Apache
`httpd.crt`, `httpd.csr`, `httpd.key`, `httpd.key.orig` are SSL Apache
related certs and keys. If you want to update your Apache SSL cert don't
worry about the `.csr` and `.key.orig`.

If you are using the Gluu Server CE binaries or latest Gluu Servers, you
need to manually update certificates and keys from `/etc/certs/`. Please
note that your private key cannot be password protected, and the public
key should be base64 X.509. For example, follow these steps in order to
update the Apache SSL cert:

- push latest SSL httpd key and certificate in the file `/etc/certs`.
- rename them to `httpd.key` and `httpd.crt`, respectively.
- restart tomcat service with command `service tomcat restart`.

_Installing Intermediate Certificates_

To install intermediate certificates follow these steps:

1. log into your Gluu Server container
2. keep your intermediate certificate in the file `/etc/certs/`
3. modify `/etc/httpd/conf.d/https_gluu.conf`, and add
   `SSLCertificateChainFile /etc/certs/name_of_your_interm_root_cert.crt`
4. restart the service of the httpd server

_Older Gluu Server Versions_

**If you are using a previous version of the Gluu Server,** you may have interfaces inside your server admin application to configure the followig certs:

- [HTTPS](./https.md)   
- [SAML](./saml.md)   
- [OpenID Connect](./openid-connect.md)   

[asimba]: http://sourceforge.net/projects/asimba/ "Access Management and Single Signon platform (Asimba), Sourceforge"

## OpenDJ
`opendj.crt` is the public cert being used by oxAuth to make a
connection to the internal Gluu-LDAP.

## oxAuth
`oxauth-web-keys.json` is being used by Gluu's OpenID Connect & UMA
server.

## Shibboleth IDP
`shibIDP.crt`, `shibIDP.csr`, `shibIDP.jks`, `shibIDP.key`,
`shibIDP.key.orig`, `shibIDP.pkcs12` are required if you use the Gluu
Server's Shibboleth SAML server for SAML transactions.
