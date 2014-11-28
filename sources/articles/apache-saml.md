# Apache SAML

## Configuring Apache Shibboleth SP in CentOS

### System preparation: 

1. Add Shibboleth repo for CentOS6

* Contents of "shib.repo":

    	[security_shibboleth]
    	name=Shibboleth (CentOS_CentOS-6)
    	type=rpm-md
    	baseurl=http://download.opensuse.org/repositories/security:/shibboleth/CentOS_CentOS-6/
    	gpgcheck=1
    	gpgkey=http://download.opensuse.org/repositories/security:/shibboleth/CentOS_CentOS-6/repodata/repomd.xml.key
    	enabled=1

* http://download.opensuse.org/repositories/security:/shibboleth/CentOS_CentOS-6/security:shibboleth.repo

### Shibboleth SP installation

* yum install shibboleth
* service shibd start
* chkconfig shibd on

### Install and Configure httpd


### Installation: 

* yum install httpd
* service httpd start
* Stop firewall

### Configuration: 

* Change ServerName directive to the server name of SP
* UseCanonicalName = On
* Restart httpd

### Httpd testing:

* Create a "index.html" inside /var/www/html
* Restart httpd
* Check from your browser

### SP key cert

* Create private key and certificate and place those in /etc/shibboleth
* Change permission

### Shibboleth SP configuration: 

This section is mirroring how to configure "shibboleth2.xml" file. 

* Provide "entityID" of SP in: 
    * <ApplicationDefaults entityID="http://sp.example.org/Shibboleth" section
* Provide the "entityID of IDP" in: 
    * <SSO entityID="https://idp.gluu.org/idp/shibboleth" section 
* Point the metadata provider, in most cases it is Gluu IDP metadata link: 
    * <MetadataProvider type="XML" uri="https://idp.gluu.org/idp/shibboleth" section
* Provide the key and cert of SP in: 
    * <CredentialResolver type="File" key="spkey.key" certificate="spcrt.crt" section

## Configuring Apache Shibboleth SP in Ubuntu

### System preparation:

1.apt-get install curl

2.Grab Shibboleth repository from SWITCH:

* curl -k -O http://pkg.switch.ch/switchaai/SWITCHaai-swdistrib.asc

* gpg --with-fingerprint  SWITCHaai-swdistrib.asc

* apt-key add SWITCHaai-swdistrib.asc

* echo 'deb http://pkg.switch.ch/switchaai/ubuntu precise main' | sudo tee /etc/apt/sources.list.d/SWITCHaai-swdistrib.list > /dev/null

* apt-get update

### Shibboleth SP installation:

* apt-get install shibboleth
* Quick test:
` shibd -t  [ Important is the last line: overall configuration is loadable, check console for non-fatal problems ]`

### Apache testing:

`apache2ctl configtest`

### Test Shibboleth:

* https://hostname_of_sp/Shibboleth.sso/Session

`It will say: "A valid session was not found."`

### Shibboleth Manual configuration ( one Physical SP ):

* Create a directory named "secure" under /var/www/
* Change permission for directory "secure" to www-data:www-data
* httpd.conf:
    * ServerName `<hostname_of_server>`
    * Set Location:

                <Location /secure>
                    AuthType shibboleth
                    ShibRequestSetting requireSession 1
                    ShibUseHeaders on
                    Require valid-user
                </Location>


* shibboleth2.xml configuration:
    * EntityID of SP: `ApplicationDefaults entityID="http://hostname/secure"`
    * Provide EntityID of IDP: `SSO entityID="https://idp.gluu.org/idp/shibboleth"`
    * Metadata Provider, IDP: `MetadataProvider type="XML" uri="https://idp.gluu.org/idp/shibboleth"`


* Restart shibd and apache2
* Create Trust Relationship for this SP in your desired IDP. 


## Configuring Apache Shibboleth SP in Windows

### Shibboleth SP Installation

* Download the MSI of Shibboleth-SP from: http://www.shibboleth.net/downloads/service-provider/latest/
* Start the installation

* Destination folder (by default it is: C:\opt\shibboleth-sp\). You can select any directory, but it is best to follow the tree \opt\shibboleth-sp\
* Select Shibboleth Daemon port: default is 1600, you can keep it for local testing
* Now, there are two options here. You have to follow either one (but not both) according to your target.
    * Option 1: If you are installing Shibboleth for Apache Web server
    * Option 2: If you are installing Shibboleth for Microsoft IIS Web server
    * For Apache Web Server, UNCHECK “Install ISAPI filter and configure IIS”.
    * UAC of Windows 7 may block this program, so allow it

### Apache configuration

* Download the Apache HTTP server MSI Installer with OpenSSL: http://httpd.apache.org/download.cgi#apache22
* Select Destination. You can keep the default destination for your local testing. But, make sure that there is no other “Apache Software Foundation” directory in your current “C:\Program Files\” location
* Provide Server Information. For local testing, you can use “localdomain/localhost”
* Test whether Apache is installed or not. Open your web browser and use “localhost”. If you see "It Works!" page, you are done.


### Shibboleth and Apache further configuration

* Change the permission of the Apache Installation Directory, provide “write”  access 
* httpd.conf configuration
    * Change: “ServerName localhost:80” ( for your local testing )
    * Copy apache22.conf from the Shibboleth directory to ~/apache/conf/extra/
* Shibboleth2.xml configuration
    * Change: Host name=“localhost” ( for local testging )
    * Change: entityID=“https://localhost/shibboleth” ( for local testing )
    * Change: ApplicationOverride id=“admin” entityID=“https://localhost/shibboleth/”
* Reboot your Windows box

### Test SP installation with Windows and Apache

* Open Web browser and provide the address: localhost/Shibboleth.sso/Status
* If you can see some XML page, you are done with your SP installation in Windows through Apache2

### Create Trust Relationship from Gluu IDP

How to create trust relationship with
[Generate](http://www.gluu.org/docs/admin-guide/saml/outbound-saml/#saml-trust-relationship)
method.

## Shibboleth SP Configuration for Gluu Server in Windows

### Shibboleth SP Installation

1. Download the [Shibboleth SP MSI](http://shibboleth.net/downloads/service-provider/latest/).

2. Start the installation.

3. Select the destination folder. The default destination is (C:\opt\shibboleth-sp) and it is recommended to use it although you can selet any other folder of your choice.
![Shibboleth SP Destination](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_destination.png)

4. Select the Shibboleth Daemon Port: the default is _1600_. You can keep it for local testing.
![SP Port](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_port.png)

5. There are two options to follow here and you can choose either one depending on your requirement.

  a. Option 1: If you are installing Shibboleth for Apache Web Server.

	1. For Apache Web Server, **check "Install ISAPI filter and configure"**.
![Apache Setup for IIS7](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_apachesetup.png)

  b. Option 2: If you are installing Shibboleth for Microsoft IIS Web Server.

	1. For Microsoft IIS Web Server, **check "Install ISAPI filter and configure IIS"**. Please remember to put the file extension **".sso"**; this is necessary.
![Microsoft IIS Server](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_microsoft.png)

>UAC of Windows 7 may block this program, so allow it.![UAC](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_uac.png)

### Apache Configuration

1. Download the [Apache HTTP Server MSI Installer](http://httpd.apache.org/download.cgi#apache22) with OpenSSL.

2. Selet destination folder. The default destination folder can be kept for loal testing, but make sure there is no other "Apache Software Foundation" directory in your current "C:\Program Files\" location.
![Apache Destination](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_apachedestination.png)

3. Provide Server Information. For local testing, you can use "localdomain/localhost".
![Server Information](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_serverinfo.png)

4. Test whether Apache is installed or not. Open your web browser and use"localhost". If you see something that resembles the image below, you are done!
![Test](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_apachetest.png)

### Shibboleth and Apache Configuration

1. Change the permission of Apache Installation Directory to provide "write" access.

2. httpd.conf configuration

  a. Change: "ServerName localhost:80" (for your local testing)

  b. Copy **apache22.conf** from the _Shibboleth_ directory _~/apache/conf/extra/_

3. Shibboleth2.xml configuration

  a. Change: Host name = "localhost" (for local testing)

  b. Change: entityID = "https://localhost/shibboleth" (for local testing)

  c. Change: ApplicationOverride id = "admin" entityID = "https://localhost/shibboleth/"

4. Reboot your windows box.

#### Test SP Installation with Windows and Apache

1. Open the Web Browser and provide the address _localhost/Shibboleth.sso/Status_ in the address bar.

2. If you can see an XML page like the one below, you have successfully installed the SP in Windows through Apache2.
![Apache Test](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_spapache.png)

## IIS Configuration

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

## Trust Relationship in IdP

1. Log into the IdP as the administrator/admin user.

2. Select: SAML --> Trust Relationship
![Trust Relationship](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/admin_saml_menu.png)

3. Click "Add Relationship"

4. Configuration

  a. Display Name: No mandatory rule. Any name is fine.

  b. Description: Description of this trust relationship.

  c. Metadata Type: Select "Generate" from the drop-down menu.

  d. URL: Hostname of the SP.

  e. Public Certificate: Public certificate of Shibboleth SP site i.e. "sp-cert.pem" which was created during the Shibboleth SP Installation.

  f. Attributes: Release required attributes from the left panel. Released attributes will be shown under the "New Trust Relationship" box.
![New TR](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/admin_saml_newTR.png)

  g. Click "Add"

  h. After successful completion, a newtrust relationship will be shown in the Trust Relationship list.
![Trust Relationship Status](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/TR_status.png)

5. Collect configuration files for Shibboleth SP from Trust Relationship. This can be done by clicking on the "Download Shibboleth2 Configuration file" link.
![SP Config](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_saml_newTR.png)

## Shibboleth SP Configuration

1. There are four XML files in the Download Package; (i) attribute-map.xml (ii) idp-metadata.xml (iii) shibboleth2.xml and (iv) sp-metadata.xml. Place all the files inside the Shibboleth SP Configuration in the Shibboleth SP Server.

  a. Please make the required modification in the "shibboleth2.xml" file. A sample is given below.

  b. Check permission of these files in the Shibboleth SP Server. For our testing server, we granted full access to Administrator and System.

![Admin Grant](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/Admin_grant.png)
![Permisison Grant](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/Permission_grant.png)
 
   c. Restart Shibd Daemon and IIS.

## Test SSO

Insert the name of the SP site in the web browser and if the configurations are correct, then the SP will redirect the user to the IdP for authentication. After a successful authentication, the user will come back to the SP site as "logged-in user".

In one word: if the SP hostname is "https://testSPsite.com" and the IdP hostname is "https://testIdPsite.com" then the flow is

https://testSPsite.com --> https://testIdPsite.com --> htts://testSPsite.com as a logged-in user.

### Sample shibboleth2.xml file

	<!-- This is a sample shibboleth2.xml file which will take place inside
	Shibboleth-SP configuration. Please use this file as an example-->

	<SPConfig xmlns="urn:mace:shibboleth:2.0:native:sp:config"
    		xmlns:conf="urn:mace:shibboleth:2.0:native:sp:config"
    		xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion"
    		xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol"    
    		xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata"
    		logger="syslog.logger" clockSkew="180">

	<!-- The OutOfProcess section contains properties affecting the shibd daemon. -->
    	<OutOfProcess logger="shibd.logger">
    	</OutOfProcess>

	 <!-- The InProcess section conrains settings affecting web server modules/filters. -->
    	<InProcess logger="native.logger">
        	<ISAPI normalizeRequest="true" safeHeaderNames="true">
            		<Site id="1" name="SP_HOSTNAME_WITHOUT_HTTP_OR_HTTPS"/>
        	</ISAPI>
    	</InProcess>

	<!-- Only one listener can be defined, to connect in-process modules to shibd. -->
    	<TCPListener address="127.0.0.1" port="1600" acl="127.0.0.1"/>

	 <!-- This set of components stores sessions and other persistent data in daemon memory. -->
    	<StorageService type="Memory" id="mem" cleanupInterval="900"/>
    	<SessionCache type="StorageService" StorageService="mem" cacheTimeout="3600" inprocTimeout="900" cleanupInterval="900"/>
    	<ReplayCache StorageService="mem"/>
    	<ArtifactMap artifactTTL="180"/>

	<!-- To customize behavior, map hostnames and path components to applicationId and other settings. -->
    	<RequestMapper type="Native">
        	<RequestMap applicationId="default">
            		<Host name="SP_HOSTNAME_WITHOUT_HTTP_OR_HTTPS" authType="shibboleth" requireSession="true"/>
        	</RequestMap>
    	</RequestMapper>

	<!--
    	The ApplicationDefaults element is where most of  SAML bits of Shibboleth are defined.
    	Resource requests are mapped by the RequestMapper to an applicationId that
    	points into to this section.
    	-->

	 <ApplicationDefaults id="default" policyId="default"
        	entityID="DA.........XXXXX"
	        REMOTE_USER="uid eppn persistent-id targeted-id mail"
	        signing="false" encryption="false" attributePrefix="AJP_">

	<!--
        Controls session lifetimes, address checks, cookie handling, and the protocol handlers.
        You MUST supply an effectively unique handlerURL value for each of your applications.
        The value can be a relative path, a URL with no hostname (https:///path) or a full URL.
        The system can compute a relative value based on the virtual host. Using handlerSSL="true"
        will force the protocol to be https. You should also add a cookieProps setting of "; path=/; secure"
        in that case. Note that while we default checkAddress to "false", this has a negative
        impact on the security of the SP. Stealing cookies/sessions is much easier with this disabled.
        -->
	<Sessions lifetime="28800" timeout="3600" checkAddress="false"
            	handlerURL="https://SP_HOSTNAME/Shibboleth.sso" handlerSSL="true"
            	exportLocation="https://SP_HOSTNAME/Shibboleth.sso/GetAssertion" exportACL="127.0.0.1"
            	idpHistory="false" idpHistoryDays="7" cookieProps="; path=/; secure; httpOnly">

 		<!--
            	SessionInitiators handle session requests and relay them to a Discovery page,
            	or to an IdP if possible. Automatic session setup will use the default or first
            	element (or requireSessionWith can specify a specific id to use).
            	-->

		<!-- Default example directs to a specific SSO service of the IdP (favoring SAML 2 over Shib 1). -->
		<SessionInitiator type="Chaining" Location="/Login" isDefault="true" id="gluu"
				 relayState="cookie" entityID="https://IDP_HOSTNAME/idp/shibboleth">
			<SessionInitiator type="SAML2" acsIndex="1" template="bindingTemplate.html"/>
                	<SessionInitiator type="Shib1" acsIndex="5"/>
		</SessionInitiator>

		<!--
            	md:AssertionConsumerService locations handle specific SSO protocol bindings,
            	such as SAML 2.0 POST or SAML 1.1 Artifact. The isDefault and index attributes
            	are used when sessions are initiated to determine how to tell the IdP where and
            	how to return the response.
            	-->
		<md:AssertionConsumerService Location="/SAML2/POST" index="1"
                	Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"/>
            	<md:AssertionConsumerService Location="/SAML2/POST-SimpleSign" index="2"
                	Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST-SimpleSign"/>
            	<md:AssertionConsumerService Location="/SAML2/Artifact" index="3"
                	Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Artifact"/>
            	<md:AssertionConsumerService Location="/SAML2/ECP" index="4"
                	Binding="urn:oasis:names:tc:SAML:2.0:bindings:PAOS"/>
            	<md:AssertionConsumerService Location="/SAML/POST" index="5"
                	Binding="urn:oasis:names:tc:SAML:1.0:profiles:browser-post"/>
            	<md:AssertionConsumerService Location="/SAML/Artifact" index="6"
                	Binding="urn:oasis:names:tc:SAML:1.0:profiles:artifact-01"/>

 		<!-- LogoutInitiators enable SP-initiated local or global/single logout of sessions. -->
            	<LogoutInitiator type="Chaining" Location="/Logout" relayState="cookie">
			<LogoutInitiator type="SAML2" template="bindingTemplate.html"/>
                	<LogoutInitiator type="Local"/>
		</LogoutInitiator>

		<!-- md:SingleLogoutService locations handle single logout (SLO) protocol messages. -->
            	<md:SingleLogoutService Location="/SLO/SOAP"
                	Binding="urn:oasis:names:tc:SAML:2.0:bindings:SOAP"/>
            	<md:SingleLogoutService Location="/SLO/Redirect" conf:template="bindingTemplate.html"
                	Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect"/>
            	<md:SingleLogoutService Location="/SLO/POST" conf:template="bindingTemplate.html"
                	Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"/>
            	<md:SingleLogoutService Location="/SLO/Artifact" conf:template="bindingTemplate.html"
                	Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Artifact"/>

