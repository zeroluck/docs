# Customizing the look and feel of the Gluu Server 

## Style customization guide

Static style elements like css, js and images are packaged into separate jar named
_\<ProjectName\>_ Static- _\<version\>_ .jar and is added to the deployable
war during the build time.

Post deployment, the structure of the jar allows it's context to be accessible from the Web contextroot.
For example, the default values of the css and js locations are *\<contextPath\>/stylesheet* and
*\<contextPath\>/js* in the configuration file.

It is possible to unpack the contents of the said jar into a folder hosted by a web server
and change the default cssLocation, jsLocation and imgLocation attributes in `oxTrust.properties`

* CSS: The filesystem location is specified using the property `cssLocation`

* Javascript: The filesystem location is specified using the property `jsLocation`

* Images: The filesystem location is specified using the property `imgLocation`

For example, in `oxTrust.properties`

```
cssLocation=https://idp.gluu.org/static/stylesheet
jsLocation=https://idp.gluu.org/static/js
imgLocation=https://idp.gluu.org/static/img
```

## Built-in oxTrust customization

Using the oxTrust Web UI, an administrator can quickly style the Gluu Server Administrator
by customizing the messages, logo, favicon and colors.

In oxTrust, this is under "Configuration" --> "Organization Configuration"

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/WebUI_modification/oxtrust/oxTrust_GUI_mod_configuration_overview.png?raw=true)

* _Title_: Web User Interface title can be modified with this link. 
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/WebUI_modification/oxtrust/Title.png?raw=true)

* _Display name_: Display Name of IDP in ldap. [ This change is not suggested to be done by Gluu Server Administrator. As it will change configuration in our central server. ]
* _Short name_: Short Name of Org in ldap. [ This change is not suggested to be done by Gluu Server Administrator. As it will change configuration in our central server. ]
* _Description_: A little description about Gluu Server.
* _Login page message_: Login page is now using oxAuth, we will more features to support Login page modification through oxAuth. 
* _Welcome Title Text_: Gluu Server Administrator can add custom Welcome Title Text with feature.
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/WebUI_modification/oxtrust/Welcome_text.png?raw=true)
* _Welcome Page Message_: Various message can be included here. Out of the box, Gluu Server includes these 1. Upload SSL Certificate, 2. Active attribute … etc. messages.
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/WebUI_modification/oxtrust/Welcome_page_message.png?raw=true)
* _Organization Logo_: Organization logo can be uploaded and activated from here.
You can upload your logo here, which will be shown in Gluu Server Administrative
Control page. 
* _Organization Favicon_: Organization favicon can be changed with this feature. 
* _Menu Color_: It’s a color picker for Gluu Server. Gluu Server’s Web UI color can be changed with this option.
