# Certificates 

**Gluu Server's certificate management has changed in Community Edition(CE) and latest Gluu Server bits.** All certificates are available in `/etc/certs/`. Here is a quick intro of those certificates: 

- *asimba.crt, asimba.csr, asimba.key, asimba.key.orig, asimba.pkcs12 and asimbaIDP.jks*: These are associated with Asimba Proxy Server. If you install SAML Proxy Server ( Asimba ) in your Gluu Server, you have to deal with these cert and key. 
- *httpd.crt, httpd.csr, httpd.key, httpd.key.orig*: These are SSL Apache related cert and key. Don't worry about CSR and .key.orig here if you want to update your Apache SSL cert. Just follow the doc which I provided you before. 
- *opendj.crt*: This cert is being used by Gluu Server's internal Gluu-LDAP.
- *oxauth-web-keys.json*: This key is using by Gluu Server's OpenID Connect Server. 
- *shibIDP.crt, shibIDP.csr, shibIDP.jks, shibIDP.key, shibIDP.key.orig, shibIDP.pkcs12*: These are required if you use Gluu Server's Shibboleth SAML server for any kind of SAML transactions. 

_If you're using the Gluu Server CE binaries or latest Gluu Servers,_ you need to manually update certificates and keys from `/etc/certs/`. 

As for example, in order to update Apache SSL cert:

- Push latest SSL httpd key and cert in `/etc/certs`.
- Rename them to `httpd.key` and `httpd.crt` respectively.
- Import the DER format of your cert in "cacert" ( location: `/etc/pki/java/` ).
- Restart your Gluu-server from outside the chroot container.

Many of the components of the Gluu Server have cyrpto keys and 
X.509 certificates. There are many key formats, and keystore
formats. Navigate to the sections above to find what you need for 
each of the Gluu Server components.

**If you're using a previous version of the Gluu Server,** you may have interfaces inside your server admin application to configure the followig certs:
- [HTTPS](./https.md)
- [SAML](./saml.md)
- [OpenID Connect](./openid.md)
