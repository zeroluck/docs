# Apache SAML

## Configuring Apache Shibboleth SP in CentOS

### System Preparation

__Add Shibboleth repo for CentOS__

* Contents of shib.repo

```
[security_shibboleth]
name=Shibboleth (CentOS_CentOS-6)
type=rpm-md
baseurl=http://download.opensuse.org/repositories/security:/shibboleth/CentOS_CentOS-6/
gpgcheck=1
gpgkey=http://download.opensuse.org/repositories/security:/shibboleth/CentOS_CentOS-6/repodata/repomd.xml.key
enabled=1
```

* http://download.opensuse.org/repositories/security:/shibboleth/CentOS_CentOS-6/security:shibboleth.repo

### Shibboleth SP Installation
<<<<<<< HEAD
Please run the following commands to install the Shibboleth SP.
>>
* yum install shibboleth
* service shibd start
* chkconfig shibd on
>>
=======

* # yum install shibboleth

* # service shibd start

* # chkconfig shibd on

>>>>>>> c3677c6b29ded0af8a4a0bdc7de3ccf058bd33aa
### Install and Configure httpd

#### Installation
The following commands will install and start the Apache server on your machine/linux environment.

<<<<<<< HEAD
>>
* yum install httpd
* service httpd start
=======
* # yum install httpd

* # service httpd start

>>>>>>> c3677c6b29ded0af8a4a0bdc7de3ccf058bd33aa
* Stop the firewall
>>

#### Configuration
Please edit the "shib.conf" file located at "/etc/httpd/conf.d/" to conform to the following changes.

* Change ServerName directive to the server name of the SP

* UseCanonicalName = On

* Restart httpd

#### Httpd Testing

* Create a "index.html" file inside /var/www/html

* Restart httpd

* Check from your browser

#### SP Key Certificate

* Create private key and certificate and place those in /etc/shibboleth

* Change permission

### Shibboleth SP Configuration

This section describes how to configure "shibboleth2.xml" file.

* Provide "entityID" of SP in:
	
	* `<ApplicationDefaults entityID="http://sp.example.org/Shibboleth"> section`

* Provide "entityID" of IdP in:

	* `<SSO entityID="https://idp.gluu.org/idp/shibboleth"> section`

* Point the metadata provider, in most cases it is Gluu IdP metadata link:

	* `<MetadataProvider type="XML" uri="https://idp.gluu.org/idp/shibboleth"> section`

* Provide the key and cert of SP in:

	* `<CredentialResolver type="File" key="spkey.key" certificate="spcrt.crt"> section`

## Configuring Apache Shibboleth SP in Ubuntu

### System Preparation

<<<<<<< HEAD
* apt-get install curl
Grab Shibboleth repository from SWITCH:

* curl -k -O http://pkg.switch.ch/switchaai/SWITCHaai-swdistrib.asc

* gpg --with-fingerprint SWITCHaai-swdistrib.asc

* apt-key add SWITCHaai-swdistrib.asc

* echo 'deb http://pkg.switch.ch/switchaai/ubuntu precise main' | sudo tee /etc/apt/sources.list.d/SWITCHaai-swdistrib.list> /dev/null

* apt-get update

### Shibboleth SP Installation

* apt-get install shibboleth
=======
1. # apt-get install curl

2. Grab Shibboleth repository from SWITCH:

* # curl -k -O http://pkg.switch.ch/switchaai/SWITCHaai-swdistrib.asc

* # gpg --with-fingerprint SWITCHaai-swdistrib.asc

* # apt-key add SWITCHaai-swdistrib.asc

* # echo 'deb http://pkg.switch.ch/switchaai/ubuntu precise main' | sudo tee /etc/apt/sources.list.d/SWITCHaai-swdistrib.list> /dev/null

* # apt-get update

### Shibboleth SP Installation

* # apt-get install shibboleth
>>>>>>> c3677c6b29ded0af8a4a0bdc7de3ccf058bd33aa

	* Quick test: `shibd -t [Important is the last line: overall configuration is loadable, check console for non-fatal problems]`

### Apache Testing

<<<<<<< HEAD
* apache2ctl configtest
=======
* # apache2ctl configtest
>>>>>>> c3677c6b29ded0af8a4a0bdc7de3ccf058bd33aa

### Test Shibboleth

* https://hostname_of_sp/Shobboleth.sso/Session

`It will say: "A valid session was not found."`

### Shibboleth Manual Configuration (one Physical SP):

* Create a directory named "secure" under /var/www/

* Change permission for directory "secure" to www-data:www-data

* httpd.conf

	* ServerName `<hostname_of_server>`

	* Set Location:

		```
		<Location /secure>
			AuthType shibboleth
			ShibRequestSetting requireSession 1
			ShibUseHeaders on
			Require valid-user
		</Location>
		```

* shibboleth2.xml configuration

	* EntityID of SP: `ApplicationDefaults entityID="http://hostname/secure"`

	* Privide EntityID of IDP: `SSO entityID="https://idp.gluu.org/idp/shibboleth"`

	* Metadata Provider, IDP: `MetadataProvider type="XML" uri="https://idp.gluu.org/idp/shibboleth"`

* Restart shibd and apache2

* Create Trust Relationship for this SP in your desired IdP.

## Configuring Apache Shibboleth SP in Windows

### Shibboleth SP Installation

1. Download the MSI of Shibboleth-SP from :http://www.shibboleth.net/downloads/service-provider/latest/

2. Start the installation

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_click.png)

3. Destination folder (by default it is: C:\opt\shibboleth-sp).

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_destination.png)

4. Select Shibboleth Daemon port: default is 1600, you can keep it for local testing

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_port.png)

5. Now, there are two options here. You have to follow either one (but not both) according to your target.

	1. Option 1: If you are installing Shibboleth for Apache Web Server

	2. Option 2: If you are installing Shibboleth for Microsoft IIS Web Server

		a. For Microsoft IIS Web Server, CHECK “Install ISAPI filter and configure IIS”, remember to put the file Extension ”.sso”; this 		    is necessary

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_microsoft.png)

		
		b. For Apache Web Server, UNCHECK "Install ISAPI filter and configure IIS".

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_apachesetup.png)

	3. UAC of Windows 7 may block this program, so allow it.

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_uac.png)

### Apache Configuration

1. Download the Apache HTTP server MSI Installer with OpenSSL: http://httpd.apache.org/download.cgi#apache22

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_apacheclick.png)
		
2. Select Destination. You can keep the default destination for your local testing. But, make sure that there is no other “Apache Software Foundation” directory in your current “C:\Program Files\” location.

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_apachedestination.png)

3. Provide Server Information. For local testing, you can use “localdomain/localhost”

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_serverinfo.png)

4. Test whether Apache is installed or not. Open your web browser and use “localhost”. If you see something like image shown below; you are done!

a![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_apachetest.png)

#### Shibboleth and Apache Configuration

1. Change the permission of the Apache Installation Directory, provide “write” access

2. 'httpd.conf' configuration

	1. Change: “ServerName localhost:80” (for your local testing)

	2. Copy apache22.conf from the Shibboleth directory to ~/apache/conf/extra/

3. 'Shibboleth2.xml' configuration

	1. Change: Host name=“localhost” ( for local testging )
    
	2. Change: entityID=“https://localhost/shibboleth” ( for local testing )
    
	3. Change: ApplicationOverride id=“admin” entityID=“https://localhost/shibboleth/”

4. Reboot your windows machine.

##### Test SP Installation with Windows and Apache

1. Open Web browser and provide the address: localhost/Shibboleth.sso/Status
2. If you can see some XML page like the one shown below, you are done with your SP installation in Windows through Apache2.

 a![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_checkstatus.png)
