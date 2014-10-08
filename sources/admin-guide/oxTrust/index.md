# oxTrust Section Index 

Please use these shortcuts to navigate the reference guide.

 * [OAuth2](./oauth2.md)
 * [SAML](./saml.md)
 * [Configuration](./configuration.md)

When you login to oxTrust for the first time with the bootstrap'd admin account, you should see something like this:

![Figure 2](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_home_screen.png)

oxTrust is the Policy Administration Point (PAP) for the Gluu Server. Because the Gluu Server stack has several components, we thought it would be useful for domain adminstrators to have one convenient Web interface where they manage the configuration of the Gluu Server components. oxTrust is really needed for the configuration of oxAuth, which provides OAuth2 Authorization Server APIs for OpenID Connect and UMA. It would be really hard to configure the LDAP data correctly in order to get oxAuth to work without oxTrust. oxTrust also provides some identity management capabilities. For example, it publishes SCIM 1.1 API's for JSON/REST user management, it also can synchronize with an external LDAP directory server, like Active Directory.

This part of the Gluu documentation seeks to provide base documentation for everything that you can do in oxTrust. In many parts of the Gluu Server docs, you will see oxTrust screenshots. But this section seeks to be a reverse index, where if you have a question about oxTrust, you can start by looking it up here.

