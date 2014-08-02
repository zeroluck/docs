# Customizing the look and feel of the Gluu Server 

<!---
- [Default Style](defaults.md)
- [Authentication](authentication.md)
- [Registration](registration.md)
- [Other Pages - XHTML howto](xhtml.md)
- [User Profile Management](user-profile.md)
- [SAML Discovery](saml-discovery.md)
-->

## oxAuth Login page customization

We're still working on getting to a point where you can self-service the login
skin design. For now, the easiest way to do it is send us the html/css files (
including images and target design ) and we'll get it implemented for you within
a few days.

If you want to do the skinning by yourself, there are couple of files and
locations which needes to be considered.

* login.xhtml: This is the base oxAuth login page which require modification if you want to change the look and feel of your Loging page.
The location of this file is: ~/tomcat/webapps/oxauth/

* CSS: Location of required CSS are: ~/tomcat/webapps/oxauth/stylesheet/

* img: There is a directory for images. Location: ~/tomcat/webapps/oxauth/


## oxTrust customization

This feature provides options to add various changes in Gluu Server User
Interface. Gluu Server Administrator can add Title, Display name or can even
modify Web User Interface colors here. 

Gluu Server Administrator need to log into IDP control panel to get this
feature. This is under "Configuration" --> "Organization Configuration"

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


