
[TOC]
#Design Customizations

The look and feel of the Gluu Server can be edited to match your
organizations branding and custom requirements.

# Style Customizations

Static style elements like CSS, JavaScript and images are packaged into
separate jar files. They are named _\<ProjectName\>_ Static-
_\<version\>_ .jar, e.g. 'oxTrustStatic-1.3.0.Final.jar' and
'oxAuthStatic-1.4.0x.Final.jar'. These files are added to the deployable
war during build time.

Post deployment, the structure of the jar allows its context to be
accessible from the Web context root. For example, the default values of
the CSS and JavaScript locations are *\<contextPath\>/stylesheet* and
*\<contextPath\>/js* in the configuration file.

It is possible to unpack the contents of the said jar into a folder
hosted by a web server, and change the default cssLocation, jsLocation
and imgLocation attributes in the file `oxTrust.properties` and/or in
`oxauth-config.xml`.

* CSS: The location is specified using the property `cssLocation`.

* JavaScript: The location is specified using the property `jsLocation`.

* Images: The location is specified using the property `imgLocation`.

For example, in `oxTrust.properties` it looks like that:

```
cssLocation=https://idp.gluu.org/static/stylesheet
jsLocation=https://idp.gluu.org/static/js
imgLocation=https://idp.gluu.org/static/img
```

in `oxauth-config.xml` (as a children of \<configuration\> node) it
looks like that:

```
<cssLocation>https://idp.gluu.org/static/stylesheet</cssLocation>
<jsLocation>=https://idp.gluu.org/static/js<jsLocation>
<imgLocation>=https://idp.gluu.org/static/img<imgLocation>
```

# Page Customizations

To change the content of the pages, you will need to edit the XHTML
files. Be careful not to remove any of the important form elements. But
you can add additional HTML elements to meet your needs as '.xhtml'
files inside `/opt/tomcat/webapps/identity` and
`/opt/tomcat/webapps/oxauth`.

The standard forms in oxAuth are:

- Default login page: `/opt/tomcat/webapps/oxauth/login.xhtml`
- Error page: `/opt/tomcat/webapps/oxauth/error.xhtml`
- Authorization page: `/opt/tomcat/webapps/oxauth/authorize.xhtml`
- Custom authentication scripts: XHTML files in `/opt/tomcat/webapps/oxauth/auth`

The standard forms in oxTrust are:

- Default registration page: `/opt/tomcat/webapps/identity/register.xhtml`

To remove the Gluu Copyright icon from your login page, navigate to
`template.xhtml` under
`/opt/tomcat/webapps/identity/WEB-INF/incl/layout`. Then, simply remove
this snippet:

```
    <s:fragment rendered="#{not isLogin}">
            <div class="footer">
                <p>Copyright <a href="http://www.gluu.org">Gluu</a> All rights reserved.</p>
            </div>
    </s:fragment>
```

# Built-in oxTrust Customization

Using the oxTrust Web UI, an administrator can quickly style the Gluu
Server Administration interface by customizing the messages, the logo,
the favicon, and the colors.

In oxTrust, this is done under Configuration --> Organization Configuration,
and is the last section that is titled Configuration (see image below).

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/WebUI_modification/oxtrust/oxTrust_GUI_mod_configuration_overview.png?raw=true)

- `Title`: Web User Interface title can be modified with this link. 
- `Display name`: Display Name of IdP in LDAP. [ This change is not suggested to be done by Gluu Server Administrator. As it will change configuration in our central server. ]
- `Short name`: Short Name of Org in LDAP. [ This change is not suggested to be done by Gluu Server Administrator. As it will change configuration in our central server. ]
- `Description`: A little description about Gluu Server.
- `Login page message`: Login page is now using oxAuth, we will more features to support Login page modification through oxAuth. 
- `Welcome Title Text`: Gluu Server Administrator can add custom Welcome Title Text with feature.
- `Welcome Page Message`: Various message can be included here. Out of the box, Gluu Server includes these 1. Upload SSL Certificate, 2. Active attribute … etc. messages.
- `Organization Logo`: Organization logo can be uploaded and activated from here.
You can upload your logo here, which will be shown in Gluu Server Administrative Control page. 
- `Organization Favicon`: Organization favicon can be changed with this feature. 
- `Menu Color`: It’s a color picker for Gluu Server. Gluu Server’s Web UI color can be changed with this option.

# How to Add Custom Attributes to Gluu LDAP

The following creates a custom objectclass `svPerson` and an attribute called `svPermission` in the LDAP Schema. This procedure can also be used to create any other custom attribute.

1. Create a file called `102-sv.ldif` in `/opt/opendj/config/schema/` folder with the following content:

```
dn: cn=schema
objectClass: top
objectClass: ldapSubentry
objectClass: subschema
cn: schema
attributeTypes: ( svPermission-oid NAME 'svPermission'
  SUBSTR caseIgnoreSubstringsMatch EQUALITY caseIgnoreMatch
  SYNTAX 1.3.6.1.4.1.1466.115.121.1.15
  X-ORIGIN 'SV custom attribute' )
objectClasses: ( svPerson-oid NAME 'svPerson' SUP top AUXILIARY MAY ( svPermission) X-ORIGIN 'SV - Custom objectclass' )
```
	1. The oxTrust admin can also be used to add the custom attribute. Please see the [Attribute Section](http://www.gluu.org/docs/admin-guide/configuration/#attributes) for more information.
 
2. Restart `opendj` and make sure that there is no error when `opendj` starts.

3. Edit the `oxTrust.properties` file in `/opt/tomcat/conf/` folder and add the following.

	1. Add `svPerson` to `person-objectClass-types`

	2. Add `svPerson` to `person-objectClass-displayNames`

4. Reload the oxTrust properties using `# touch /opt/tomcat/conf/oxtrust.config.reload`.

5. Register this new attribute using the oxTrust admin interface, in the [Attributes](http://www.gluu.org/docs/admin-guide/configuration/#attributes) configuration page. 
For SAML URI, you can use an https URI like `https://sv.com/schema/svPermission...` but it has no importance as SAML will not be used at all.

It is also possible to use the attribute as a scope for OpenID Connect.

1. Create a custom scope `svInfo` for OpenID Connect. Please see [OpenID Conncet Scopes](http://www.gluu.org/docs/admin-guide/openid-connect/#scopes) for instructions about custom scope creation.

2. Add the `svPermission` userclaim to `svInfo` Scope. Make sure you release this scope to your registered clients.
.
