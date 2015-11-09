# Apache SAML

## Configuring Apache Shibboleth SP in CentOS

### System Preparation

__Add Shibboleth repository for CentOS__

* The file `shib.repo` contains the following entry:

```
[security_shibboleth]
name=Shibboleth (CentOS_CentOS-6)
type=rpm-md
baseurl=http://download.opensuse.org/repositories/security:/shibboleth/CentOS_CentOS-6/
gpgcheck=1
gpgkey=http://download.opensuse.org/repositories/security:/shibboleth/CentOS_CentOS-6/repodata/repomd.xml.key
enabled=1
```

* Download the Shibboleth security security:

`http://download.opensuse.org/repositories/security:/shibboleth/CentOS_CentOS-6/security:shibboleth.repo`

### Shibboleth SP Installation

To install the Shibboleth SP, run the following commands in a terminal:

```
yum install shibboleth
service shibd start
chkconfig shibd on
```

### Install and Configure httpd
#### Installation

The following commands will both install, and start the Apache web
server on your machine/Linux environment:

```
yum install httpd
service httpd start
Stop the firewall
```

#### Configuration

Edit the file `httpd.conf`, and do the following changes:

* Change the `ServerName` directive to the server name of the SP.

* Set `UseCanonicalName = On`.

* Restart the httpd service using the command `service httpd restart`.

#### Httpd Testing

* Create an `index.html` file inside the directory `/var/www/html`.

* Restart the httpd service using the command `service httpd restart`.

* Check from your browser

#### SP Key Certificate

* Create both a private key, and a certificate, and place those in the
  file `/etc/shibboleth`.

* Change the permissions of these files so that the web server can read
  the files.

### Shibboleth SP Configuration

This section describes how to configure the file `shibboleth2.xml`.

* Provide the `entityID` of the according SP in:
	
	* `<ApplicationDefaults entityID="http://sp.example.org/Shibboleth"> section`

* Provide the `entityID` of the IdP in:

	* `<SSO entityID="https://idp.gluu.org/idp/shibboleth"> section`

* Adjust the entry of the metadata provider. In most cases this is the
  Gluu IdP metadata link:

	* `<MetadataProvider type="XML" uri="https://idp.gluu.org/idp/shibboleth"> section`

* Provide both the key and certificate of the SP in:

	* `<CredentialResolver type="File" key="spkey.key" certificate="spcrt.crt"> section`

### Shibboleth Manual Configuration (one Physical SP):

* Create a directory named under `/var/www/secure`.

* Change the permissions for that directory `secure` to
  `www-data:www-data` (owner and group of the web server).

* `httpd.conf`

	* change the ServerName `<hostname_of_server>`

	* Define the Location, and the authorization type:

		```
		<Location /secure>
			AuthType shibboleth
			ShibRequestSetting requireSession 1
			ShibUseHeaders on
			Require valid-user
		</Location>
		```

* configure `shibboleth2.xml`

	* Set the EntityID of the SP: `ApplicationDefaults entityID="http://hostname/secure"`

	* Provide the EntityID of the IDP: `SSO entityID="https://idp.gluu.org/idp/shibboleth"`

	* Set both the Metadata Provider, and the IDP: `MetadataProvider type="XML" uri="https://idp.gluu.org/idp/shibboleth"`

* Restart both shibd and Apache2 using these lines:

  ```
  service shibd restart
  service httpd restart
  ```

* Create a Trust Relationship for this SP in your desired IdP.

## Configuring Apache Shibboleth SP in Windows

### Shibboleth SP Installation

1. Download the MSI of Shibboleth-SP from:
   http://www.shibboleth.net/downloads/service-provider/latest/ .

2. Start the installation

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_click.png)

3. Define the destination folder (by default it is: C:\opt\shibboleth-sp).

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

	1. Change: Host name=“localhost” ( for local testing )
    
	2. Change: entityID=“https://localhost/shibboleth” ( for local testing )
    
	3. Change: ApplicationOverride id=“admin” entityID=“https://localhost/shibboleth/”

4. Reboot your windows machine.

##### Test SP Installation with Windows and Apache

1. Open Web browser and provide the address: localhost/Shibboleth.sso/Status
2. If you can see some XML page like the one shown below, you are done with your SP installation in Windows through Apache2.

 a![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/admin_sp_checkstatus.png)
