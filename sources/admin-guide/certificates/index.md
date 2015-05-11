# Certificates 

Many of the components of the Gluu Server have cyrpto keys and X.509 certificates. There are many key formats, and keystore formats. Navigate to the sections below to find what you need for each of the Gluu Server components.

- [Asimba](#asimba)   
- [Apache](#apache)   
- [OpenDJ](#opendj)     
- [oxAuth](#oxauth)   
- [Shibboleth IDP](#shibboleth-idp)   

## Asimba 
`asimba.crt`, `asimba.csr`, `asimba.key`, `asimba.key.orig`, `asimba.pkcs12 and asimbaIDP.jks` are associated with the Asimba SAML Proxy Server. If you install SAML Proxy Server ( Asimba ) in your Gluu Server, you have to deal with these cert and key. 

## Apache 
`httpd.crt`, `httpd.csr`, `httpd.key`, `httpd.key.orig` are SSL Apache related certs and keys. If you want to update your Apache SSL cert don't worry about the `.csr` and `.key.orig`.  

## OpenDJ
`opendj.crt` is the public cert being used by oxAuth to make a connection to the internal Gluu-LDAP.

## oxAuth
`oxauth-web-keys.json` is being used by Gluu's OpenID Connect & UMA server. 

## Shibboleth IDP
`shibIDP.crt`, `shibIDP.csr`, `shibIDP.jks`, `shibIDP.key`, `shibIDP.key.orig`, `shibIDP.pkcs12` are required if you use the Gluu Server's Shibboleth SAML server for SAML transactions. 

# Updating Certs

If you're using the Gluu Server CE binaries or latest Gluu Servers, you need to
manually update certificates and keys from `/etc/certs/`. Please note that your
private key `can not be password protected` and public key should be base64
X.509. For example, in order to update Apache SSL cert:

- Push latest SSL httpd key and cert in `/etc/certs`.   
- Rename them to `httpd.key` and `httpd.crt` respectively.    
- Import the DER format of your cert in "cacert" ( location in RHEL/CentOS CE: `/etc/pki/java/`, location in Ubuntu CE: `/etc/ssl/certs/java` ).    
- Restart your Gluu-server from outside the chroot container.   

# Installing Intermediate Certificates

1. Log into your Gluu Server container
2. Keep your intermediate cert in `/etc/certs/`
3. `https_gluu.conf` modification ( location: `/etc/httpd/conf.d` )
    3.1 Add `SSLCertificateChainFile /etc/certs/name_of_your_interm_root_cert.crt`
4. Restart `httpd`

# Older Gluu Server Versions

**If you are using a previous version of the Gluu Server,** you may have interfaces inside your server admin application to configure the followig certs:

- [HTTPS](./https.md)   
- [SAML](./saml.md)   
- [OpenID Connect](./openid-connect.md)   
