**Table of Contents** 

- [SetUp Apache2](#setup-apache2)
- [Client Registration](#client-registration)
	- [Dynamic Client Registration](#dynamic-client-registration)
	- [Manual Client Registration](#manual-client-registration)
- [Getting DN from Client ID](#getting-dn-from-client-id)

# mod_auth_oidc Installation Guide

### SetUp Apache2

We're assuming that all the hostnames will be dns resolvable. If not, then you should consider making entries in **/etc/hosts.** Install apache2 and enable module ssl by running following commands: 

* sudo apt-get install apache2
* sudo a2enmod ssl
* service apache2 restart

If you are encountered with a problem saying:

```
 * Restarting web server apache2                                               [fail]
```

Then you need to enter following commands (These commands will solve the issues regarding pre-occupied Port), if there is no error, then continue to the procedure about downloading mod_auth_openidc deb files.

* sudo /etc/init.d/apache2 stop
* sudo killall apache2
* sudo netstat -l|grep www
* sudo /etc/init.d/apache2 restart

Download *mod_auth_openidc* deb file as below. If the binary is not available, refer to [this page](https://github.com/pingidentity/mod_auth_openidc/wiki). Then, use *dpkg* to install the binary.

* sudo wget http://ftp.us.debian.org/debian/pool/main/liba/libapache2-mod-auth-openidc/libapache2-mod-auth-openidc_1.6.0-1_amd64.deb
* dpkg -i libapache2-mod-auth-openidc_1.6.0-1_amd64.deb

Here, for some machines, you need to have following packages installed:

- libhiredis0.10
- libpcre3
- libjansson4

These packages can be installed using command:

* sudo apt-get install *package-name*

If you are encountered with errors having "Unmet dependency", then you can use following command:

* sudo apt-get -f install

Now, enable the mod as shown below, and restart the server:

* a2enmod auth_openidc
* service apache2 restart


Now, since we want to run this apache at port __44443__ ssl and __8000__ for non-ssl, we need to edit three files. The changes are done to avoid conflict with the gluu-server's apache ports. But, if the gluu-server server and apache servers are different, no need to change the ports. Change port numbers in the file: 

* /etc/apache2/ports.conf 
* /etc/apache2/sites-available/000-default.conf
* /etc/apache2/sites-available/default-ssl.conf

And, restart apache2 service as mentioned above (last command). 

### Client Registration

There are two methods for client registration:

1. Dynamic Client Registration
2. Manual Cient Registration

You can use any of the methods to register the client.


#### Dynamic Client Registration

For dynamic client registration, we'll name the server: **dynamic.gluu.org.**


Create a directory **dynamic** inside **/var/www/html**, that is:


* mkdir /var/www/html/dynamcic


Now, create a file named **index.html**, and all following content:

```

<html>
	<title>
		Protected URL
	</title>
	<body>
		Nice to see the protected url via Dynamic Registration
	</body>
</html>

```

Create another directory **metadeta** inside above directory to hold metadata.

Now, change the ownership of directory, so that apache can write metadata inside the directory.


* chown -R www-data:www-data /var/www/html

Create the certificate for SSL with the following command:

`openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apachessl.key -out /etc/apache2/ssl/apachessl.crt`


Let's create the apache config file now. Create a file named **/etc/apache2/sites-available/dynamic.conf**  with the contents as below :


```

<VirtualHost *:44443>
	ServerName dynamic.gluu.org
	DocumentRoot /var/www/html

	OIDCMetadataDir	/var/www/html/metadata
	OIDCClientSecret secret
	
	OIDCRedirectURI https://dynamic.gluu.org:44443/dynamic/fake_redirect_uri
	OIDCCryptoPassphrase secret
	OIDCSSLValidateServer Off
	
	<Location /dynamic/>
   		AuthType openid-connect
   		Require valid-user
	</Location>

	SSLEngine On
	SSLCertificateFile /etc/apache2/ssl/apachessl.crt
	SSLCertificateKeyFile /etc/apache2/ssl/apachessl.key
</VirtualHost>

```

Here, cert and key files are pre-existing on the server. You can use your own too.

Enable the site by running this command:

* a2ensite  dynamic.conf

Now, restart the apache service as:


* service httpd restart
 

Now, try to access [this page](https://dynamic.gluu.org:44443/dynamic), and You'll be presented with a discovery page, enter `admin@ce.gluu.org`

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/dynamic_discovery.png)


The usual choice as per present used urls is: **admin@ce.gluu.org**. But you must use the existing user at the gluuCE along with existing url i.e *existing_user*@your.gluu.ce.server

After this we are presented with the *oxAuth* page from gluuCE where we enter the credentials for authentication. 

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/oxauth_authentication.png)


#### Manual Client Registration

Considering __manual client registration__ case, we'll name the server: **static.gluu.org.**

Create a directory named *static* inside /var/www/html, i. e.


* mkdir /var/www/html/static 
 

Now, let's create another file named *index.html* with content:

```

<html>
	<title>
		Protected URL
	</title>
	<body>
		Nice to see the protected url via Manual registration
	</body>
</html>

```


Now, change the ownerships by using this command:


* chown -R www-data:www-data /var/www/html


Let's create the apache config file now. Create a file named **/etc/apache2/sites-available/static.conf** with the contents as below: 


```

<VirtualHost *:44443>
	ServerName static.gluu.org
	DocumentRoot /var/www/html

	OIDCRedirectURI https://static.gluu.org:44443/static/fake_redirect_uri
	OIDCCryptoPassphrase newsecret

	OIDCProviderMetadataURL	https://ce.gluu.org/.well-known/openid-configuration
	OIDCClientID @!C648.9803.5565.E5CB!0001!0DB0.EEDB!0008!7728.5650
	OIDCClientSecret newsecret
	OIDCResponseType id_token
	OIDCProviderTokenEndpointAuth client_secret_basic
	
	OIDCProviderIssuer	https://ce.gluu.org
	OIDCSSLValidateServer Off
	
	<Location /static/>
   		AuthType openid-connect
   		Require valid-user
	</Location>

	SSLEngine On
	SSLCertificateFile /etc/pki/tls/certs/localhost.crt
	SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
</VirtualHost>

```

Instead of pre-existing cert and key files, feel free to use your own.

Enable the site by running this command:

* a2ensite  dynamic.conf


Now, restart the apache service as below:


* service httpd restart


Now, try to access [this page](https://static.gluu.org:44443/static), and you should see the oxAuth page from gluuCE where we enter the credentials for authentication. 

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/oxauth_authentication.png)

Chances are there that you'll see the below error after logging in: 


```

Error:

The OpenID Connect Provider returned an error: Error in handling response type.

```

And that, the apache log at the client side as below:

```

[Fri Jun 05 14:48:28 2015] [error] [client 124.253.60.123] oidc_proto_validate_idtoken: id_token JSON payload did not contain the required-by-spec "sub" string value, referer: https://static.gluu.org:44443/static/fake_redirect_uri
[Fri Jun 05 14:48:28 2015] [error] [client 124.253.60.123] oidc_proto_parse_idtoken: id_token payload could not be validated, aborting, referer: https://static.gluu.org:44443/static/fake_redirect_uri

```


To solve this problem, log into the gluuCE server by running following command:


* service gluu-server login



### Getting DN from Client ID

We get the client id from the search performed in gluu-server's Web UI. So, to get the DN part we perform the below command. The ldap password can be stored in /root/.pw or at any convenient location. In our case the command was:  


* /opt/opendj/bin/ldapsearch -T -X -Z -p 1636 -D "cn=Directory Manager" -j /root/.pw -s sub -b "o=gluu" 'inum=@!1962.E949.50EE.BCB7!0001!B312.DB22!0008!24F8.303C'


Create a file named __mod.ldif__ with the contents given below. Here, **oxAuthSubjectIdentifier** is same as the client id. Since it's missing initially when we register the client manually, so we have to add it later. The DN part to be used in __mod.ldif__ is obtained from above command's output.


```
dn: inum=@!1962.E949.50EE.BCB7!0001!B312.DB22!0008!24F8.303C,ou=clients,o=@!C648.9803.5565.E5CB!0001!0DB0.EEDB,o=gluu
changetype: modify
add: oxAuthSubjectIdentifier
oxAuthSubjectIdentifier: @!1962.E949.50EE.BCB7!0001!B312.DB22!0008!24F8.303C
```

Then run the __ldapmodify__ command to insert the __oxAuthSubjectIdentifier__ as below:


* /opt/opendj/bin/ldapmodify -Z -X -h localhost -p 1636 -D "cn=Directory Manager" -j /root/.pw -f /root/mod.ldif



The command may vary depending upon your using.

Then again access [this page](https://static.gluu.org:44443/static) and you should see the success message.


