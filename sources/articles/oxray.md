# oxRay

LifeRay OpenID Connect plugin to authenticate users using Gluu IdP.
[TOC]

## Overview

The oxAuth LifeRay plugin is used to authenticate and auto-log users
from Gluu Server into LifeRay with the same credentials. It is built on
top of oxAuth, the OpenID Connect provider by Gluu.

The oxAuth plugin intercepts any attempt to login from anywhere in the
LifeRay and redirects the request and the user to an oxAuth server where
the identification takes place, actually. If the user has authorized the
server to share some of his basic information with the oxAuth plugin,
the user will be redirected back to the LifeRay CMS, and logged in,
automatically.

The goal of this project is to use the LifeRay CMS as the basis for an
organizational personal data store service.

Note: This plugin does not support auto-user creation from information
supplied by the oxAuth Plugin. Instead, it can be implemented by
extending the plugin.

## Deployment

The plugin is provided in two variants--[Maven][maven] and [Ant][ant].
You can either use Maven or the LifeRay plugin SDK to build and deploy
this plugin as a standard LifeRay hot deployable WAR file.

### Deploying WAR file using Maven

This requires a prerequisite: make sure that you have [Maven][maven]
installed on your system to build this plugin from source.

1. Checkout the Maven source from the [oxRay
Repository](https://github.com/Gluufederation/oxRay/6.2.x/maven).

2. Open the file `pom.xml` in `gluu-openid-connect-hook`, and update
your local LifeRay Tomcat bundle path. This is required for building the
WAR file and deploying to the LifeRay Tomcat bundle.

![configure_pom_xml](https://raw.githubusercontent.com/GluuFederation/oxRay/master/img/configure_pom_xml.jpg)

3. Run the following command in `gluu/6.2.x/maven/gluu-openid-connect-hook` directory:

```
mvn clean install package liferay:deploy
```

This will take a few seconds to download the dependency `jar` files, and
generate the LifeRay-compiled deployable WAR file. It will be placed
within your <liferay-bundle-folder>/deploy directory, and the hot
deployable process will start.

### Using LifeRay Plugin SDK With Ant

This requires a prerequisite: we assume that you have the plugin SDK
both installed and configured with LifeRay bundle.

1. Checkout the gluu-openid-connect-hook plugin source from the
repository, and place these files in your local directory for the plugin
SDK. Usually, this is `liferay-plugins-sdk-6.2.0-ce-ga1/hooks`.

2. Run the following command in the folder `liferay-plugins-sdk-6.2.0-ce-ga1/hooks/gluu-openid-connect-hook`:

```
ant clean deploy
```

### Using Binary From Repository

You can also download a compiled binary as a standard LifeRay deployable
WAR file from the following location:

[oxRay LifeRay Deployable War File](https://github.com/Gluufederation/oxRay/6.2.x/binary/gluu-openid-connect-hook-6.2.0.1.war)

Copy this WAR file in your LifeRay bundle. Usually, this is located at
`liferay-portal-6.2.0-ce-ga1/deploy`.

Once the plugin is deployed as a WAR file either using Maven or Ant, you
will see the following success message in your LifeRay Tomcat server:

![deploy_success](https://raw.githubusercontent.com/GluuFederation/oxRay/master/img/deploy_success.jpg)

### Client Registration

A LifeRay application needs to be registered with the Authorization
server before initiating an authentication request/response with OAuth
IdP server.

The following steps are necessary to obtain both a client id and a
client secret. These data will be used within the LifeRay portal
properties.

1. Go to `https://seed.gluu.org/oxauth-rp/home.seam`
2. You will see Dynamic Client Registration Section
3. Enter the Registration Endpoint Url eg: `https://idp.example.org/oxauth/seam/resource/restv1/oxauth/authorize`
	* You can get this url from your idp auto-discovery url
`https://<Your IDP Server Domain>/.well-known/openid-configuration`
	* You can search for registration_endpoint and copy paste that url here.
4. Enter the Redirect URI's as http://localhost:8080/openidconnect/callback
	* Replace your domain name with localhost:8080
	* This would be your liferay handler for autologging user to liferay, when redirect comes back from oAuth server. 
5. Select the Response Types: CODE
6. Select the Application Type: WEB
7. For development purpose use : NATIVE (if your testing on local machine with localhost:8080 domain)
8. Enter Client Name: LifeRay App
	* You can choose any name here. 
9. All other options can be left as DEFAULT
Please see the attached screenshot..  
![client_registration](https://raw.githubusercontent.com/GluuFederation/oxRay/master/img/dynamic_client_registration_screen1.jpg)

10. Click `Submit` and the following `Registration Request` and `Registration Response` will appear.
![json-request-response](https://raw.githubusercontent.com/GluuFederation/oxRay/master/img/json-request-response.jpg)

11. Save the Registration Response to your local system. Parameters `client_id` and `client_secret` is used in LifeRay when configuring `portal-ext.properties`. 
#### Modifying portal.properties

It is necessary to modify `portal-ext.properties` file to reflect oxAuth server client credentials and server's URL. It can accomplished by navigating into `liferay-portal-6.2.0-ce-ga1\` folder , where `portal-ext.properties` resides.

Note: To activate or deactivate oxAuth plugin put `true` to activate and `false` to deactivate.
    
`gluu.openidconnect.auth.enabled=true`
     
* oxAuth client ID and Client Secret.
```
gluu.openidconnect.client.id=@!1111!0008!51CE.1E59
gluu.openidconnect.client.secret=65777eb7-87a8-4d60-9dbc-d31d43971f2b
```
* oAuth Server Domain  
`gluu.openidconnect.idp.domain=https://idp.gluu.org`

* oAuth Server Auto discovery url
`gluu.openidconnect.url.discovery=https://idp.gluu.org/.well-known/openid-configuration`

* Your oAuth Server Logout URL (Typically this will be used to logout user from oAuth when user logout in liferay)
`gluu.openidconnect.idp.logout=https://idp.gluu.org/identity/logout`
     
* LifeRay server callback url that will be handling response by oAuth Server after authentication:
	* Replace the localhost:8080 with your liferay domain name.
`gluu.openidconnect.client.redirect.url=http://localhost:8080/openidconnect/callback`
This page would be invoked when the user does not exist in liferay database but it getting authenticated from oAuth Server.

* Typical create a liferay page with /no-such-user-found or Redirect to liferay registration page url
`gluu.openidconnect.no.such.user.redirect.url=http://localhost:8080/no-such-user-found `

Restart LifeRay Server after editing `portal-ext.properties` 

### Login using LifeRay Front End

* Server Bootup
	* Once liferay server is restarted. Open browser and hit 
`http://localhost:8080`
 
* Login URL
	* Once liferay page successfully loaded paste following url in the browser and hit `enter`.
`http://localhost:8080/openidconnect/login`
 
Note: You can edit the theme code and link the login url as http://localhost:8080/openidconnect/login, so user will always redirect to oAuth Server for authentication.
 
* oAuth Authentication
	* Above liferay login url will redirect users to oAuth IDP server for user authentication, internally passing oAuth client id as following screen 

![oauth-login](https://raw.githubusercontent.com/GluuFederation/oxRay/master/img/oauth_login.jpg)

* Request for Permission
	* This screen is configurable depending upon your oAuth Server Implementation.

![oauth_info_confirm](https://raw.githubusercontent.com/GluuFederation/oxRay/master/img/oauth_info_confirm.jpg)

* oAuth Callback (User auto-login to liferay)
	* After successful authentication with oAuth server, IDP will send callback to liferay with code as parameter
 
`http://localhost:8080/openidconnect/callback?code=xxx`
 
This will intercepted by our oxAuth LifeRay plugin and upon validation of token with Gluu IDP internally, it will auto login user to LifeRay and users will be redirected to respective home page.

![liferay_success_login](https://raw.githubusercontent.com/GluuFederation/oxRay/master/img/liferay_success_login.jpg)

[maven]: https://en.wikipedia.org/wiki/Apache_Maven "Apache Maven, Wikipedia"

[ant]: https://en.wikipedia.org/wiki/Apache_Ant "Apache Ant, Wikipedia"
