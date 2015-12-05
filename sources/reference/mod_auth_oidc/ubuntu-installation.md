## Installing mod_auth_oidc on Gluu Server on Ubuntu 14.04

#### Apache2 and the SSL module

Install the Apache2 web server, and enable the SSL module as described
below:

    # sudo apt-get install apache2
    # sudo a2enmod ssl
    # service apache2 restart

Download the mod_auth_openidc deb file as below. If the binary file is
not available, then refer to the [OpenIDC wiki
page](https://github.com/pingidentity/mod_auth_openidc/wiki). Then,
install the binary file with `dpkg`, and enable the SSL module as shown
below.

```
# wget http://ftp.us.debian.org/debian/pool/main/liba/libapache2-mod-auth-openidc/libapache2-mod-auth-openidc_1.6.0-1_amd64.deb
# dpkg -i libapache2-mod-auth-openidc_1.6.0-1_amd64.deb
# a2enmod auth_openidc
# service apache2 restart
```

Now, since we want to run this Apache at port 44443 for SSL and at port
8000 for non-SSL, we need to edit three files. The changes are done to
avoid a conflict with the Gluu Server's Apache ports. But, if both the
Gluu Server and the Apache server are different, then there is no need
to change the ports.

Change the port numbers in the files `/etc/apache2/ports.conf`,
`/etc/apache2/sites-available/000-default.conf` and
`/etc/apache2/sites-available/default-ssl.conf`. Then, restart the
Apache2 web service:

```
# service apache2 restart
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
# chown -R www-data:www-data /var/www/html
```

Let's create the Apache config file now.

Create a file named `/etc/apache2/sites-available/dynamic.conf` with the
contents as written below:

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
        SSLCertificateFile      /etc/ssl/certs/ssl-cert-snakeoil.pem
        SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
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

![dynamic_discovery](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/dynamic_discovery.png)

Currently, the usual choice is `admin@ce.gluu.org`. Make sure that user
exist at the gluuCE along with an according uri such as
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
# chown -R www-data:www-data /var/www/html
```

As the next step create the Apache configuration file named
`/etc/apache2/sites-available/static.conf` with the contents as below:

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
        SSLCertificateFile      /etc/ssl/certs/ssl-cert-snakeoil.pem
        SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
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

Chances are there that you'll see the below error after logging in: 

    Error:

    The OpenID Connect Provider returned an error: Error in handling response type.

And that, the apache log at the client side shows as below:

    [Mon Jun 08 12:58:59.946860 2015] [auth_openidc:error] [pid 15877:tid 139878178371328] [client 124.253.174.54:42385]         oidc_proto_validate_idtoken: id_token JSON payload did not contain the required-by-spec "sub" string value, referer:         https://static.gluu.org:44443/static/fake_redirect_uri
    [Mon Jun 08 12:58:59.946916 2015] [auth_openidc:error] [pid 15877:tid 139878178371328] [client 124.253.174.54:42385]         oidc_proto_parse_idtoken: id_token payload could not be validated, aborting, referer:                        https://static.gluu.org:44443/static/fake_redirect_uri
 
The screenshots and logs have been captured while writing the doc.

To solve this problem, log into the gluuCE server as:

    # service gluu-server login

#### Getting DN from Client ID

We get the client id from the search performed in gluu-server's Web UI. So, to get the DN part we perform the below command. The ldap password can be stored in `/root/.pw` or at any convenient location. In our case the command was:

    # /opt/opendj/bin/ldapsearch -T -X -Z -p 1636 -D "cn=Directory Manager" -j /root/.pw -s sub -b "o=gluu" 'inum=@!1962.E949.50EE.BCB7!0001!B312.DB22!0008!24F8.303C'

Create a file named `mod.ldif` with the following contents. The `oxAuthSubjectIdentifier` is same as the client id. Since it's missing initially when we register the client manually, so we have to add it later. The DN part to be used in `mod.ldif` is obtained from above command's output. 

    dn: inum=@!1962.E949.50EE.BCB7!0001!B312.DB22!0008!24F8.303C,ou=clients,o=@!C648.9803.5565.E5CB!0001!0DB0.EEDB,o=gluu
    changetype: modify
    add: oxAuthSubjectIdentifier
    oxAuthSubjectIdentifier: @!1962.E949.50EE.BCB7!0001!B312.DB22!0008!24F8.303C

Then run the `ldapmodify` command to insert the `oxAuthSubjectIdentifier` as below:

    /opt/opendj/bin/ldapmodify -Z -X -h localhost -p 1636 -D "cn=Directory Manager" -j /root/.pw -f /root/mod.ldif

The command may vary depending upon how you are using.

Then again access the page: `https://static.gluu.org:44443/static` and very good chances are there that you'll see the success message.


