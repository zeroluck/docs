# Certificates 

**If you're using the Gluu Server CE binaries,** you need to manually update certificates and keys from `/etc/certs/`. The `httpd.crt` and `httpd.key` are respectively SSL cert and key for your Gluu Server CE. Here is how you can update the SSL httpd key and cert in Gluu CE:

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
