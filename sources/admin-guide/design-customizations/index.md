**Table of Contents** 

- [Design Customizations](#design-customization)
- [Style customizations](#style-customizations)
- [Page customizations](#page-customizations)
- [Built-in oxTrust customization](#built-in-oxtrust-customization)

#Design Customizations
The look and feel of the Gluu Server can be edited to match your organizations branding and custom requirements.

# Style customizations

Static style elements like css, js and images are packaged into separate jar named
_\<ProjectName\>_ Static- _\<version\>_ .jar (e.g. oxTrustStatic-1.3.0.Final.jar and oxAuthStatic-1.4.0x.Final.jar) and is added to the deployable war during the build time.

Post deployment, the structure of the jar allows its context to be accessible from the Web contextroot.
For example, the default values of the css and js locations are *\<contextPath\>/stylesheet* and
*\<contextPath\>/js* in the configuration file.

It is possible to unpack the contents of the said jar into a folder hosted by a web server
and change the default cssLocation, jsLocation and imgLocation attributes in `oxTrust.properties` and/or in `oxauth-config.xml`

* CSS: The location is specified using the property `cssLocation`   

* Javascript: The location is specified using the property `jsLocation` 

* Images: The location is specified using the property `imgLocation`    

For example, in `oxTrust.properties`

```
cssLocation=https://idp.gluu.org/static/stylesheet
jsLocation=https://idp.gluu.org/static/js
imgLocation=https://idp.gluu.org/static/img
```

in `oxauth-config.xml`
(as a children of \<configuration\> node)

```
<cssLocation>https://idp.gluu.org/static/stylesheet</cssLocation>
<jsLocation>=https://idp.gluu.org/static/js<jsLocation>
<imgLocation>=https://idp.gluu.org/static/img<imgLocation>
```

# Page customizations

To change the content of the pages, you will need to edit the xhtml files. Be careful
not to remove any of the important form elements. But you can add additional html
elements to meet your needs. (.xhtml files inside `/opt/tomcat/webapps/identity` and
`/opt/tomcat/webapps/oxauth`)

Standard forms in oxAuth:    
- Default login page: `/opt/tomcat/webapps/oxauth/login.xhtml`      
- Error page: `/opt/tomcat/webapps/oxauth/error.xhtml`      
- Authorization page: `/opt/tomcat/webapps/oxauth/authorize.xhtml`      
- Custom authentication scripts: xhtml files in `/opt/tomcat/webapps/oxauth/auth`       

Standard forms in oxTrust:      
- Default registration page: `/opt/tomcat/webapps/identity/register.xhtml`      

To remove the Gluu Copyright icon from your login page, navigate to:    
`template.xhtml` under `/opt/tomcat/webapps/identity/WEB-INF/incl/layout`   

And simply remove this snippet:    

    <s:fragment rendered="#{not isLogin}">
            <div class="footer">
                <p>Copyright <a href="http://www.gluu.org">Gluu</a> All rights reserved.</p>
            </div>
    </s:fragment>

# Built-in oxTrust customization

Using the oxTrust Web UI, an administrator can quickly style the Gluu Server Administration interface
by customizing the messages, logo, favicon and colors.

In oxTrust, this is under Configuration > Organization Configuration, and is the last section, titled Configuration. 

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/WebUI_modification/oxtrust/oxTrust_GUI_mod_configuration_overview.png?raw=true)

- `Title`: Web User Interface title can be modified with this link. 
- `Display name`: Display Name of IDP in ldap. [ This change is not suggested to be done by Gluu Server Administrator. As it will change configuration in our central server. ]
- `Short name`: Short Name of Org in ldap. [ This change is not suggested to be done by Gluu Server Administrator. As it will change configuration in our central server. ]
- `Description`: A little description about Gluu Server.
- `Login page message`: Login page is now using oxAuth, we will more features to support Login page modification through oxAuth. 
- `Welcome Title Text`: Gluu Server Administrator can add custom Welcome Title Text with feature.
- `Welcome Page Message`: Various message can be included here. Out of the box, Gluu Server includes these 1. Upload SSL Certificate, 2. Active attribute … etc. messages.
- `Organization Logo`: Organization logo can be uploaded and activated from here.
You can upload your logo here, which will be shown in Gluu Server Administrative Control page. 
- `Organization Favicon`: Organization favicon can be changed with this feature. 
- `Menu Color`: It’s a color picker for Gluu Server. Gluu Server’s Web UI color can be changed with this option.
