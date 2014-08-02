# Customizing the look and feel of the Gluu Server 

<!---
- [Default Style](defaults.md)
- [Authentication](authentication.md)
- [Registration](registration.md)
- [Other Pages - XHTML howto](xhtml.md)
- [User Profile Management](user-profile.md)
- [SAML Discovery](saml-discovery.md)
-->

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

