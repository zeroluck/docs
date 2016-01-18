[TOC]
# Installation

We assume that all the hostnames will be dns resolvable. If not, then
add the according entries in `/etc/hosts`, please.

### Add EPEL Repository

Run the following command to __Add EPEL Repo__.

* `rpm -ivh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm`

## Apache Web Server
To setup __Apache2 SSL__, run the following commands:

```
yum install httpd mod_ssl
yum install curl hiredis jansson
```

## Authentication Module (mod_auth_openidc)
Run the following command to install the `mod_auth_openidc` module:

```
rpm -ivh https://github.com/pingidentity/mod_auth_openidc/releases/download/v1.8.2/mod_auth_openidc-1.8.2-1.el6.x86_64.rpm
```

**Note:** If there are any difficulties installing `hiredis` and `jansson`,
try to update the package database of your system using the following command:

```
yum upgrade
```
### Load Authentication Module 
Please make sure that the following shared-object file exists by running the following command:

```
ls -l /usr/lib64/httpd/modules/mod_auth_openidc.so
```

Next, create an **Apache _conf_** file for loading this module.

```
echo -e "LoadModule auth_openidc_module modules/mod_auth_openidc.so\nListen 44443" > /etc/httpd/conf.d/mod_auth_openidc.conf
```

The file `/etc/httpd/conf.d/mod_auth_openidc.conf` will now contain
these two lines:

```
LoadModule auth_openidc_module modules/mod_auth_openidc.so
Listen 44443
```

This Apache mod should now be listening on port **44443**. To enable
this, start the Apache service (running gluuCE at **ce.gluu.org**):

```
service httpd start
```

# Client Registration

There are two methods for client registration:

1. Dynamic Client Registration
2. Manual Client Registration

You can use any of the methods to register the client.


## Dynamic Client Registration

For dynamic client registration, we'll name the server: **dynamic.gluu.org.**

Create a directory named `dynamic` inside the directory `/var/www/html`, that is:

```
mkdir /var/www/html/dynamic
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
chown -R apache:apache /var/www/html
```

Let's create the Apache configuration file now. Create a file named
`/etc/httpd/conf.d/dynamic.conf` with the content as below:

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
	SSLCertificateFile /etc/pki/tls/certs/localhost.crt
	SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
</VirtualHost>
```

Here, both certificate and key files already exist on the server. You
can use your own, too. Next, enable the site by running the
following command, and restart the Apache service as:

```
ln -s /etc/httpd/sites-available/dynamic.conf
service httpd restart
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

## Manual Client Registration

Considering the __manual client registration__ case, we will name the
server `static.gluu.org`, instead.

Create a directory named `/var/www/html/static`, i. e. with this
command:

```
mkdir /var/www/html/static
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
chown -R apache:apache /var/www/html
```

Create a file named `/etc/httpd/conf.d/static.conf` with the contents as
below:

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
Next, enable the static site by running the following command, and
restart the Apache service as below:

```
ln -s /etc/httpd/sites-available/sites-available/static.conf
service httpd restart
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
service gluu-server login
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
/opt/opendj/bin/ldapmodify -Z -X -h localhost -p 1636 -D "cn=Directory Manager" -j /root/.pw -f /root/mod.ldif
```

The command may vary depending upon your installation. Next, access
[this page](https://static.gluu.org:44443/static), and the success
message should be visible.

