**Table of Contents** 

- [Setup Apache2](#setup-apache2)
- [Client Registration](#client-registration)
	- [Dynamic Client Registration](#dynamic-client-registration)
	- [Manual Client Registration](#manual-client-registration)
- [Getting DN from Client ID](#getting-dn-from-client-id)

# mod_auth_oidc Installation Guide

### Setup Apache2

We assume that all the hostnames will be dns resolvable. If not, then
add the according entries in `/etc/hosts`, please. Install Apache2 and
enable the SSL module by running the following commands:

```
sudo apt-get install apache2
sudo a2enmod ssl
service apache2 restart
```

In case that restarting the Apache web server failed:

```
Restarting web server apache2                                               [fail]
```

... you will have to stop the Apache service, manually. The following
commands help you solving that situation:

```
sudo /etc/init.d/apache2 stop
sudo killall apache2
sudo netstat -l|grep www
sudo /etc/init.d/apache2 restart
```

Now, you can continue with the [auth_openidc module][openidc]. This
module is available as a native deb package from the Debian/Ubuntu
repositories. Download and install the `libapache2--mod_auth_openidc`
package as described below.

Note: if the binary package is not available, refer to [this
page](https://github.com/pingidentity/mod_auth_openidc/wiki) for the
sources. 

Then, use `apt-get` to install the binary package.

```
sudo apt-get install libapache2-mod-auth-openidc
```

This package depends on these libraries--`libhiredis0.10`, `libpcre3`,
and `libjansson4`. `apt-get` will resolve this dependencies,
automatically, and will retrieve the packages as well.

Next, enable the Apache module, and restart the Apache web server:

```
sudo a2enmod auth_openidc
sudo service apache2 restart
```

Now, since we would like to run our Apache web server at port __44443__
(for SSL), and __8000__ (for non-SSL), we need to edit three files. The
changes are done to avoid a conflict with the Gluu Server's Apache
ports. But, if the Gluu Server and the Apache server are different, no
need to change the ports. Change port numbers in these files: 

* `/etc/apache2/ports.conf`
* `/etc/apache2/sites-available/000-default.conf`
* `/etc/apache2/sites-available/default-ssl.conf`

Next, restart Apache 2 service:

```
sudo service apache2 restart
```

### Client Registration

There are two methods for client registration:

1. Dynamic Client Registration
2. Manual Client Registration

You can use any of the methods to register the client.


#### Dynamic Client Registration

For dynamic client registration, we'll name the server: **dynamic.gluu.org.**

Create a directory named `dynamic` inside the directory `/var/www/html`, that is:

```
sudo mkdir /var/www/html/dynamic
```

Now, create a file named `index.html`, and add the following content:

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

Create another directory named `metadata` inside the directory from
above to hold further metadata. Then, change the ownership of this
directory using this command:

```
sudo chown -R www-data:www-data /var/www/html
```

Create the according certificate for SSL with the following command:

```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apachessl.key -out /etc/apache2/ssl/apachessl.crt
```

Then, create the Apache configuration file now. Create a file named
`/etc/apache2/sites-available/dynamic.conf` with the content as below:

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

Here, both certificate and key files already exist on the server. You
can use your own, too. Next, enable the site by running the
`a2ensite`command, and restart the Apache service as:

```
sudo a2ensite dynamic.conf
sudo service httpd restart
```

Now, try to access [this page](https://dynamic.gluu.org:44443/dynamic),
and you'll be presented with a discovery page. To access this page,
enter `admin@ce.gluu.org`.

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/dynamic_discovery.png)

The usual choice as per present used uris is: `admin@ce.gluu.org`. Note
that you have to use an existing user at the gluuCE along with an
existing uri. An example is `existing_user@your.gluu.ce.server`.

After this the *oxAuth* page from gluuCE is displayed where you enter
the credentials for authentication.

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/oxauth_authentication.png)

#### Manual Client Registration

Considering the __manual client registration__ case, we will name the
server `static.gluu.org`, instead.

Create a directory named `/var/www/html/static`, i. e. with this
command:

```
sudo mkdir /var/www/html/static
```

Now, let's create another file named `index.html` with this content:

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

Then, change the ownerships by using this command:

```
sudo chown -R apache:apache /var/www/html
```

Create a file named `/etc/apache2/sites-available/static.conf` with the
contents as below:

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
Next, enable the static site by running the `a2ensite` command, and
restart the Apache service as below:

```
sudo a2ensite static.conf
sudo service httpd restart
```

Now, try to access [this page](https://static.gluu.org:44443/static),
and you should see the oxAuth page from gluuCE where you enter the
credentials for authentication.

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/oxauth_authentication.png)

Chances are there that you'll see this error after logging in: 

```
Error:

The OpenID Connect Provider returned an error: Error in handling response type.
```

The according Apache log looks like that:

```
[Fri Jun 05 14:48:28 2015] [error] [client 124.253.60.123] oidc_proto_validate_idtoken: id_token JSON payload did not contain the required-by-spec "sub" string value, referer: https://static.gluu.org:44443/static/fake_redirect_uri
[Fri Jun 05 14:48:28 2015] [error] [client 124.253.60.123] oidc_proto_parse_idtoken: id_token payload could not be validated, aborting, referer: https://static.gluu.org:44443/static/fake_redirect_uri
```

To solve this problem, log into the gluuCE server by running the
following command:

```
sudo service gluu-server login
```

### Getting DN from Client ID

We get the client id from the search performed in Gluu Server's Web UI.
So, to get the DN part we perform the below command. The LDAP password
can be stored in `/root/.pw` or at any other location that is convenient
for you. In our case the command is:

```
/opt/opendj/bin/ldapsearch -T -X -Z -p 1636 -D "cn=Directory Manager" -j /root/.pw -s sub -b "o=gluu" 'inum=@!C648.9803.5565.E5CB!0001!0DB0.EEDB!0008!7728.5650'
```
Create a file named `mod.ldif` with the contents given below. The DN
part to be used in `mod.ldif` is obtained from output of the command
above:

```
dn: inum=@!C648.9803.5565.E5CB!0001!0DB0.EEDB!0008!7728.5650,ou=clients,o=@!C648.9803.5565.E5CB!0001!0DB0.EEDB,o=gluu
changetype: modify
add: oxAuthSubjectIdentifier
oxAuthSubjectIdentifier: @!C648.9803.5565.E5CB!0001!0DB0.EEDB!0008!7728.5650
```

Then, run the `ldapmodify` command to insert the
__oxAuthSubjectIdentifier__ as below:

```
sudo /opt/opendj/bin/ldapmodify -Z -X -h localhost -p 1636 -D "cn=Directory Manager" -j /root/.pw -f /root/mod.ldif
```

The command may vary depending upon your installation. Next, access
[this page](https://static.gluu.org:44443/static), and the success
message should be visible.

[openidc]: https://github.com/pingidentity/mod_auth_openidc/wiki "Wiki for mod_auth_openidc"
