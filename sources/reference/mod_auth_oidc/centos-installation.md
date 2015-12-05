## Installing mod_auth_oidc on Gluu Server on CentOS 6.x

#### Add EPEL Repository

First, add the EPEL repository to your list of package resources, and
retrieve the according RPM file:

```
rpm -ivh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
```

#### Setup Apache2 SSL

Next, both install and the activate the SSL module for your web server
such as Apache2:

```
# yum install httpd mod_ssl
# yum install curl hiredis jansson
# rpm -ivh https://github.com/pingidentity/mod_auth_openidc/releases/download/v1.8.2/mod_auth_openidc-1.8.2-1.el6.x86_64.rpm
```

We recommend you to verify the presence of the the OpenIDC module as
below:

```
# ls -l /usr/lib64/httpd/modules/mod_auth_openidc.so
```

Next, create an according Apache configuration file to use this module:

```
# echo "LoadModule auth_openidc_module modules/mod_auth_openidc.so" > /etc/httpd/conf.d/mod_auth_openidc.conf
```

Activate the OpenIDC module:

```
# a2enmod auth_openidc
```

As demonstrated here we are running gluuCE at `ce.gluu.org`. The OpenIDC
module is being run at the same Apache server but at the port 44443 for
SSL, and at port 8000 for non-SSL. Therefore we need to edit three
files. The changes are done to avoid a conflict with the Gluu Server's
Apache ports. But, if both the Gluu Server and the Apache server are
different, then there is no need to change the ports.

Change the port numbers in the files `/etc/apache2/ports.conf`,
`/etc/apache2/sites-available/000-default.conf` and
`/etc/apache2/sites-available/default-ssl.conf`. Then, restart the
Apache2 web service:

```
# service httpd restart
```

#### Dynamic Client Registration

Let's consider the case of dynamic client registration first. For this
purpose we will use `dynamic.gluu.org` as the server name. Let's prepare
the server for serving the content protected by gluuCE.

Create a directory named as: `dynamic` inside `/var/www/html`:

```
# mkdir /var/www/html/dynamic
```

Now, let's create a file named `index.html` inside the directory above.
The file will have the following content:

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

Create another directory named `metadata` in `/var/www/html` which will
hold the metadata:

```
# mkdir /var/www/html/metadata
```

Now, change the ownership of the entire directory. This is **extremely
critical** because without this step the Apache will not be able to
write the metadata inside the directory.

```
# chown -R apache:apache /var/www/html
```

Let's create the Apache config file now.

Create a file named `/etc/httpd/conf.d/dynamic.conf` with the contents
as written below:

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
        SSLCertificateFile    /etc/pki/tls/certs/localhost.crt
        SSLCertificateKeyFile /etc/pki/tls/private/localhost.key
</VirtualHost>
```

Above, I have taken both the certificate and the key file which are
pre-existing at the server. Feel free to use your own files. As the next
step enable the site, and restart the Apache service as below:

```
# a2ensite  dynamic.conf
# service apache2 restart
```

To validate the availability if the website access the page via
`https://dynamic.gluu.org:44443/dynamic`. As a result, you should see
the discovery page as pictured below. Enter `admin@ce.gluu.org` to
access the site.

![dynamic_authentication](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/dynamic_discovery.png)

Currently, the usual choice is `admin@ce.gluu.org`. Make sure that the
user exists at the gluuCE along with an according uri such as
`existing_user@your.gluu.ce.server`.

After this we are presented with the oxAuth page from gluuCE where we
enter the credentials for authentication.

![oxauth_authentication](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/oxauth_authentication.png)

#### Manual Client Registration

Let's consider the case of **manual client registration** now if you do
not wish to use dynamic client registration. For this purpose we will
use `static.gluu.org` as the server name.

Let's prepare the server for serving the content protected by gluuCE.
Create a directory named `static` inside `the directory /var/www/html`:

```
# mkdir /var/www/html/static
```

Now, create a file named `index.html` inside the directory created
above. The file needs to have the following content:

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

Now, change the ownership of the entire directory:

```
# chown -R apache:apache /var/www/html
```

As the next step create the Apache configuration file named
`/etc/httpd/conf.d/static.conf` with the contents as below:

```
<VirtualHost *:44443>
	ServerName static.gluu.org
	DocumentRoot /var/www/html

	OIDCRedirectURI https://static.gluu.org:44443/static/fake_redirect_uri
	OIDCCryptoPassphrase newsecret

    OIDCProviderMetadataURL	https://ce.gluu.org/.well-known/openid-configuration
    OIDCClientID @!1962.E949.50EE.BCB7!0001!B312.DB22!0008!24F8.303C
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

Above, I have taken both the certificate and the key files which are
pre-existing at the server. Feel free to use your own authentification
files.

Now, restart the Apache server as below:

```
# a2ensite static.conf
# service apache2 restart
```

To validate the availability if the website access the page via
`https://static.gluu.org:44443/static`. As a result, you should see the
oxAuth page from gluuCE. Enter the credentials for authentication:

![oxauth_authentication](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/oxauth_authentication.png)

It may happen that you see the following error after logging in: 

```
Error:

The OpenID Connect Provider returned an error: Error in handling response type.
```

The Apache log file will contain the following entry:

```
[Mon Jun 08 12:58:59.946860 2015] [auth_openidc:error] [pid 15877:tid 139878178371328] [client 124.253.174.54:42385]         oidc_proto_validate_idtoken: id_token JSON payload did not contain the required-by-spec "sub" string value, referer:         https://static.gluu.org:44443/static/fake_redirect_uri
    [Mon Jun 08 12:58:59.946916 2015] [auth_openidc:error] [pid 15877:tid 139878178371328] [client 124.253.174.54:42385]         oidc_proto_parse_idtoken: id_token payload could not be validated, aborting, referer:                        https://static.gluu.org:44443/static/fake_redirect_uri
```

Note that the screenshots and log file extracts have been captured while
writing this documentation.

To solve this problem, log into the gluuCE server like that:

```
# service gluu-server login
```

#### Getting DN from Client ID

We need the client ID from the search performed in Gluu Server's Web UI.
We perform the command as written below. For example, the LDAP password
that is needed can be stored in a local file like `/root/.pw` or at any
other location that is convenient for you.

```
# /opt/opendj/bin/ldapsearch -T -X -Z -p 1636 -D "cn=Directory Manager" -j /root/.pw -s sub -b "o=gluu" 'inum=@!C648.9803.5565.E5CB!0001!0DB0.EEDB!0008!7728.5650'
```

Create an LDIF file named `mod.ldif` with the contents written below:

```
dn: inum=@!C648.9803.5565.E5CB!0001!0DB0.EEDB!0008!7728.5650,ou=clients,o=@!C648.9803.5565.E5CB!0001!0DB0.EEDB,o=gluu
changetype: modify
add: oxAuthSubjectIdentifier
oxAuthSubjectIdentifier: @!C648.9803.5565.E5CB!0001!0DB0.EEDB!0008!7728.5650
```

The `oxAuthSubjectIdentifier` is same as the client ID. Since it is
missing initially when we register the client manually, so we have to
add it later on. The DN part to be used in `mod.ldif` is obtained from
the above command's output. 

To insert the `oxAuthSubjectIdentifier` run the `ldapmodify` command:

```
/opt/opendj/bin/ldapmodify -Z -X -h localhost -p 1636 -D "cn=Directory Manager" -j /root/.pw -f /root/mod.ldif
```

The command may vary depending upon your installation.

Next, access the page `https://static.gluu.org:44443/static`, again.
Now, the success message will be displayed.

