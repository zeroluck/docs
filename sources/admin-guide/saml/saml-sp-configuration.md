# Install Shibolleth SP Package
The Shibboleth Service Provider(SP) software runs a system service, and it is configured via an apache module. For CentOS it is necessary to add shib.repo to /etc/yum/repos.d and install with yum.

*$ yum install shibboleth*

*$ service shibd start*

*$ chkconfig shibd on*

For other systems, please follow the instructions on the [Shibboleth SP Installation](https://spaces.internet2.edu/display/SHIB2/NativeSPLinuxInstall) page.

## Copy Files From Archive

Please copy the following files to the */etc/shibboleth* folder.

*$ cp attribute-map.xml /etc/shibboleth/attribute-map.xml*

*$ cp shibboleth2.xml /etc/shibboleth/shibboleth2.xml*

*$ cp idp-metadata.xml /etc/shibboleth/idp-metadata.xml*

*$ cp sp-metadata.xml /etc/shibboleth/sp-metadata.xml*

> **Note**

> IdP and SP metadata filenames are unique for each IdP and SP. The SP metadata is based on the i-number for the trust relationship.
> The IdP metadata is based on the i-number for the organization.

## Add Server Certificate to Metadata

Please update the server certificate in shibboleth2.xml at the following location.

*$ vi /etc/shibboleth/shibboleth2.xml*

	< ds:X509Certificate >

	* * * * * * * * * * * * * * * 

	Insert pem format of the key 

	* * * * * * * * * * * * * * * 

	< / ds: X509Certificate >

## Update Hostnames and Ports in Configuration File

Please edit the hostname in secure session section in _shibboleth2.xml_ file.

*$ vi /etc/shibboleth/shibboleth2.xml*

	< Host Name="hostname" >

	< Path name="secure" authType="shibboleth" requireSession="true"/ >

	< /Host >

> **Note**

> Hostname and port should match the ServerName and Port directives of Apache

Edit the _httpd.conf_ file to set UseCanonicalName On:

	UseCanonicalName: On

## Protect Folder with Shibboleth SSO

Add the following to _httpsd.conf_ file to protect directories.

*$ vi /etc/httpd/conf/httpd.conf*

	< Directory "_path to directories_" >

	 AuthType shibboleth

	 ShibRequestSetting requireSession 1

	 ShibUseHeaders On

	 require valid-user

	< / Directory >

## Restart shibd and apache httpd

*$ service httd restart*

*$ service shibd restart*

Try to access _https://hostname/Shibboleth.sso/Status_

# Shibboleth SP for Windows

1. Download the MSI of [Shibboleth-SP](http://www.shibboleth.net/downloads/service-provider/latest)

2. Start installation by double clicking the MSI.
![Click Screen](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_click.png)

3.Agree the License Agreement

4. Select the destination folder; by default it is **c:\opt\shibboleth-sp\.** A different directory can be selected from this screen, but it is recommended to follow the tree **\opt\shibboleth-sp\.**
![Destination](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_destination.png).

5. Select Shibboleth Daemon port: default is **1600**, you can keep it for local testing.
![Port](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_port.png)

6. Now, there are two options here, and you have to follow any one (not both) for your existing infrastructure.

  1. Option 1: Installaiton for Microsoft IIS Web Server.
![Microsoft IIS Server](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_microsoft.png)
> For Microsoft IIS Web Server, you have to Check "Install ISAPI filter and configure IIS", and remember to put the file Extension ".sso". This is very important.

 2. Option 2: Installation for Apache Web Server.
![Apache Server](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_apachesetup.png)
> For Apache Web Server, you have to Uncheck "Install ISAPI filter and configure IIS".

UAC of Windows 7 may block the program, so accept it.
![UAC](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_uac.png)

# Apache2 Installation

1. Download [Apache HTTP Server](http://httpd.apache.org/download.cgi#apache22) MSI with OpenSSL.

2. Start installation by double clicking the MSI.
![Apache Click](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_apacheclick.png)

3. Select Destination. You can keep the default destination for your local testing. But, please make sure that there is no other "Apache Software Foundation" directory in your current "C:\Program Files\" location.
![Apache Location](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_apachedestination.png)

4. Insert Server Informations. For local testing, **localdomain/localhost** can be used.
![Server info](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_serverinfo.png)

5. Test if Apache is installed or not. Open your web browser and use **localhost** as the address. If the screen resembles the screenshot below, then you are done.
![Apache test](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_apachetest.png)

# Shibboleth and Apache Configuration

1. Change the permission of Apache Installation Directory, provide **write** access.

2. httpd.conf configuration

  1. Change: **"ServerName localhost:80"** (for your local testing)

  2. Copy apache22.conf from Shibboleth directory to **~/apache/conf/extra/**

3. Shibboleth2.xml configuration

  1. Change: Host name = **"localhost"** (for local testing)

  2. Change: entityID = **"https://localhost/shibboleth"** (for local testing)

  3. Change: ApplicationOverride id = **"admin"**

4. Reboot your Windows box

Test SP installation with Windows and Apache.

Open Web browser and insert the address : _localhost/Shibboleth.sso/Status_

If the screen below resembles the screen on your browser, then you are done with your SP installation in Windows through Apache2
![SP Apache](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_spapache.png)

# IIS7 Installation

1. Start --> Control Panel --> Programs --> **"Turn Windows Features on or off"**

Select (i) IIS, (ii) Web Management Tools, (iii) II6 Management Compatiability, (iv) IIS Management Console, (v) IIS Management Scripts and Tools, (vi) IIS Management Service

Select (i) World Wide Web Service, (ii) CGI, (iii) ISAPI Filters, (iv) ISAPI Extenstions and press **OK**.
![IIS Setup](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_iis7setup.png)

2. Test if IIS7 is installed in your system with **127.0.0.1** in the web browser.
![IIS7 test](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_iis7test.png)

3. Reboot the system.

# ISAPI Filter Configuration

1. Open IIS Manager [Start --> Administrative Tools --> Internet Information Service (IIS) Manager]

2. Double click on **"ISAPI and CGI Restrictions"**
![ISAPI CGI](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_isapicgi.png)

3. Add New Filter

	a.  	1.Click Actions --> Add (upper right corner)
		2.Select **\opt\shibboleth-sp\lib\shibboleth\isapi_shib.dll**
		3.Description: **"Shibboleth"**
		4.Click **"Allow"** (from right hand side)
		![Apache ISAPI filter](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/apache_sp_isapipath.png)

	b.  Back to IIS Manager --> ISAPI Filters.
	![ISAPI Filter](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/apache_sp_isapifilter.png)
	Click **"Add"** (upper right corner)

	Filter name: Shibboleth

	Executable: **\opt\shibboleth-sp\lib\shibboleth\isapi_shib.dll**
	![ISAPI Edit](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/apache_sp_isapiedit.png)

4. SSO file extension mapping
  a. Click on **"Handling Mapping"** from main page
![Handler Mapping](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_handlermapping.png)
  1.  1.Click Actions --> Add (upper right corner)
  b. Click **"Add Script Map"** from Action
![Add Script Map](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_addscriptmap.png)
  c. Request Path **"*.sso"**
  d. Executable should be pointed to **"isapi_shib.dll"**
![Executable Path](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_executable.png)

5. Restart IIS

6. Check Status

Check your status by typing **"http://127.0.0.1/Shibboleth.sso/Status"** in the Web Browser. If it diplays an XML document, then the Shibboleth SP Installation in Windows IIS7 is complete.
![Check Status](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_checkstatus.png)

> If you want to establish SSO with your site, then you need an Identity Provider, their metadata and certificates.
