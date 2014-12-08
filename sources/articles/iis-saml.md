# IIS SAML Configuration

## IIS Configuration in Windows 7

1. Start --> Control Panel --> Programs --> "Turn Windows features on or off"

2. Select (i) IIS (ii) Web Management Tools (iii) II6 Management Compatiability (iv) IIS Management Console (v) IIS Management Scripts and Tools (vi) IIS Management Service

3. Select (i) World Wide Web Services (ii) CGI (iii) ISAPI Filters (iv) ISAPI Extensions --> Press OK.
![IIS 7 Setup](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_iis7setup.png)

4. Test IIS to see if it is installed in your system with "127.0.0.1" in the web browser. For our test case, we used IIS7.
![Test IIS](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_iis7test.png)

## ISAPI Filter Configuration

1. Open IIS Manager (Start --> Administrative Tools --> Internet Information Service/IIS Manager)

2. Double click on "ISAPI and CGI Restrictions"
![ISAPI and CGI](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_isapicgi.png)

3. Add a new Filter

  a. Click Actions --> Add (upper right corner)

  b. Select "\opt\shibboleth-sp\lib\shibboleth\isapi_shib.dll"

  c. Description: "Shibboleth"

  d. Click "Allow" (from the right hand side)

![ISAPI Path](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/apache_sp_isapipath.png)

  e. Back to IIS Manager --> ISAPI Filters

![ISAPI Filters](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/apache_sp_isapifilter.png)

        1. Click "Add" (upper right corner)

        2. Filter Name: Shibboleth

        3. Executable: "\opt\shibboleth-sp\lib\shibboleth\isapi_shib.dll"

![ISAPI Edit](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/apache_sp_isapiedit.png)

  f. SSO file extension mapping

        1. Click on "Handler Mapping" from main page

![SP Handler](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_handlermapping.png)

        2. Click "Add Script Map" from Action
![Script Map](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_addscriptmap.png)

        3. Request Path :".sso"

        4. Executable should be pointed to "isapi_shib.dll"
![Executable](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_executable.png)

  g. Restart IIS

  h. Check Status

  Check Status by typing in "http://127.0.0.1/Shibboleth.sso/Status" in the web browser. If it displays an XML document, then the Shibboleth SP Installation in Windows IIS7 in complete.
![Status Check](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_checkstatus.png)

## Shibboleth SP Setup in Windows 2008 R2 with IIS7

1. Open up "Server Manager", scroll down and click on "Add Roles".

![Add Role](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup_addrole.png)

2. Hit "Next"

![Next](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup_next.png)

3. Select "Web Server (IIS)", hit "Next"

![Web Server](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup.png)

4. Select (i) CGI

(ii) ISAPI Extensions

(iii) ISAPI Filters

(iv) Management Tools

  (a) IIS Management Console

  (b) IIS Management Scripts and Tools

  (c) Management Service

(v) All IIS6 Management Compatibility

![Selection](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup_selection.png)

![Selection](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup_selection1.png)

5. Hit "Next", for the confirmation, check the list of plugins.

![Plugin](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup_plugin.png)

![Management Tools](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup_managementtools.png)

6. Hit "Install" and Windows 2008 will complete the installation. A confirmation window shall appear which resembles the screenshot below.

![Confirmation](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup_confirmation.png)

7.Test IIS7 setup from the Internet.

![Test](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup_test.png)

### Shibboleth SP 2.5.x Setup

1. Down the [Shibboleth SP 2.5.x](http://www.shibboleth.net/downloads/service-provider/latest/)

2. Start the installation, keep the default path, Select "Install ISAPI modules into IIS", IIS Script Extension must be ".sso" and Hit "Next".

![Shib Setup](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup_shibsetup.png)

3. After the completion of the installation, the system will ask to reboot the system; hit "Yes".

![Restart](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup_restart.png)

4. Test the Shibboleth SP installation from the SP VM using the URL "localhost/Shibboleth.sso/Status" in the address bar of the Web Browser.

![Status](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup_status.png)

### Trust Relationship in IdP

1. Create a Trust Relationship for the new SP in the IdP. It is necessary to upload the Public Certificate of the new SP in teh IdP. Please note that the CN of the public certificate MUST BE the same as _Hostname_ of the SP. Hit "Add".

![Add TR](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup_addtr.png)

2. Download the IdP generated configuration files for Shib SP modification.

![Download](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup_download.png)

### SP Configuration

1. The files from the IdP must be placed in the SP Configuration.

2. Before placing them inside the SP Configuration please check

  (a) The "spcert.crt" file has the CN same as the SP hostname.

  (b) The "spcert.crt" and "spkey.key" has the same _md5sum_ value.

  (c) The IdP-metadata is perfectly placed inside the SP Configuration.

  (d) The downloaded "shibboleth2.xml" file has values resembling the file content below.

3. For testing purpose, we are going to protect a directory named "secure" with the IdP.  Create a folder/directory in the IIS Root Directory and restart Shibd and IIS.

![Secure](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/iis_setup_secure.png)

### SSO Testing

1. Place the following URL in the web browser: "https://SP_Name/secure"

2. It will redirect the user to the IdP for authentication.

3. After the authentication is complete, the user will be shown the protected page. For this case, the page is the IIS7 index page.
