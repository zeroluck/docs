#Home
Please use these shortcuts to navigate the reference guide.
 * [OAuth2](./oauth2.md)
 * [Personal](./personal.md)
 * [SAML](./saml.md)
 * [Users](./users.md)

## oxTrust
OxTrust an application written in JBoss Seam to provide organizational cloud identiy management service including REST service endpoints and a *user friendly* cloud identity management console (GUI). It is loosely based on the commercial Gluu Trust software by Gluu Inc.
OxTrust is tightly coupled with oxAuth. OxAuth configuration is stored in LDAP and it would be hard to generate the right configuration entries without oxTrust. The projects are separated because, in a high throughput cluster deployment many oxAuth servers are required along with a few oxTrust instances. In a small deployment, however, all services may run within one server VM.
![Figure 1](img/oxTrust-system.png)
## Home Screen
![Figure 2](img/admin_home_screen.png)
The home screen above contains the different features of the Gluu Appliance. This bar is always visible for quick access for the users. The different functions of the menu are explained in detail in this reference guide.
