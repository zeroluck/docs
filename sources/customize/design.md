[TOC]

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

In the file `oxauth-config.xml` (as a children of \<configuration\>
node) it looks like that:

```
<cssLocation>https://idp.gluu.org/static/stylesheet</cssLocation>
<jsLocation>=https://idp.gluu.org/static/js<jsLocation>
<imgLocation>=https://idp.gluu.org/static/img<imgLocation>
```

# Page Customizations

To change the content of the pages, you will need to edit the XHTML
files. Be careful not to remove any of the important form elements. 

To meet your needs you can add further HTML elements as '.xhtml' files
inside the two directories `/opt/tomcat/webapps/identity` and
`/opt/tomcat/webapps/oxauth`.

The standard forms in oxAuth are:

- Default login page: `/opt/tomcat/webapps/oxauth/login.xhtml`
- Error page: `/opt/tomcat/webapps/oxauth/error.xhtml`
- Authorization page: `/opt/tomcat/webapps/oxauth/authorize.xhtml`
- Custom authentication scripts: XHTML files in `/opt/tomcat/webapps/oxauth/auth`

The standard forms in oxTrust are:

- Default registration page: `/opt/tomcat/webapps/identity/register.xhtml`

To remove the Gluu copyright icon from your login page, navigate to the
file `template.xhtml` that is located under
`/opt/tomcat/webapps/identity/WEB-INF/incl/layout`. Then, simply remove
this snippet:

```
<s:fragment rendered="#{not isLogin}">
    <div class="footer">
        <p>Copyright <a href="http://www.gluu.org">Gluu</a> All rights reserved.</p>
    </div>
</s:fragment>
```
A new tomcat wrapper variable is added to avoid hard coding or changing application configurations. 
```
wrapper.java.additional.20=-Dgluu.external.resource.base=/var/gluu/webapps
```

## Tomcat Restart Policy
Tomcat Server does not need restart generally when custom pages are added in Gluu Server. However in the following cases, please restart Tomcat.

1. Default Page overriden with custom page as JSF may cache path to original version

2. Removal of page to replace context with empty page to invalidate it

3. New environment variable is introduces

**Note:** There is a 10 second delay on page modification reload
