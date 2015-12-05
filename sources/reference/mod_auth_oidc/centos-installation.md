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

Activate the OpenIDC module, and restart the Apache service, then:

```
# a2enmod auth_openidc
# service httpd restart
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

#### Dynamic Client Registration

Let's consider the case of dynamic client registration first.

For this purpose we'll name the server: `dynamic.gluu.org`.

Let's prepare the server for serving the content protected by gluuCE.

Create a directory named as: `dynamic` inside `/var/www/html`

    # mkdir /var/www/html/dynamic

Now, let's create a file named `index.html` inside above directory with the following content:

    <html>
	      <title>
		    Protected URL
	      </title>
	     <body>
		  Nice to see the protected url via Dynamic Registration
	     </body>
    </html>

Create another directory named `metadata` in `/var/www/html` which will hold the metadata.

    # mkdir /var/www/html/metadata

Now, change the ownerships. This is **extremely critical**, because without this apache won't be able to write the metadata inside the directory.

    # chown -R apache:apache /var/www/html

Let's create the apache config file now.
Create a file named `/etc/httpd/conf.d/dynamic.conf` with the contents as below:

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

Above, I've taken the cert and key files which are pre-existing at the server.
Feel free to use your own.

Now, restart the apache service as below:

    # service httpd restart

Now, try to access the page: `https://dynamic.gluu.org:44443/dynamic` and you should see the discovery page as below: You'll be presented with a discovery page, enter `admin@ce.gluu.org`
![dynamic_authentication](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/dynamic_discovery.png)



The usual choice as per present used urls is: `admin@ce.gluu.org`. But you must use the existing user at the gluuCE along with existing url i.e `existing_user@your.gluu.ce.server`

After this we are presented with the oxAuth page from gluuCE where we enter the credentials for authentication.

![oxauth_authentication](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/oxauth_authentication.png)

#### Manual Client Registration

Let's consider the case of **manual client registration** now if you don't wish to use dynamic client registration.

For this purpose we'll name the server: `static.gluu.org`.

Let's prepare the server for serving the content protected by gluuCE.

Create a directory named as: `static` inside `/var/www/html`

    # mkdir /var/www/html/static

Now, let's create a file named `index.html` inside above created directory with the following content:

    <html>
	<title>
		Protected URL
	</title>
	<body>
		Nice to see the protected url via Manual registration
	</body>
    </html>

Now, change the ownerships.

    # chown -R apache:apache /var/www/html

Let's create the apache config file now.
Create a file named `/etc/httpd/conf.d/static.conf` with the contents as below:

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

Above, I've taken the cert and key files which are pre-existing at the server. Feel free to use your own.

Now, restart the apache service as below:

    # service httpd restart

Now, try to access the page: `https://static.gluu.org:44443/static` and you should see the oxAuth page from gluuCE where we enter the credentials for authentication.

![oxauth_authentication](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/oxauth_authentication.png)

Chances are there that you'll see the below error after logging in: 

    Error:

    The OpenID Connect Provider returned an error: Error in handling response type.

And that, the apache log at the client side shows as below:


    [Fri Jun 05 14:48:28 2015] [error] [client 124.253.60.123] oidc_proto_validate_idtoken: id_token JSON payload did not        contain the required-by-spec "sub" string value, referer: https://static.gluu.org:44443/static/fake_redirect_uri
    [Fri Jun 05 14:48:28 2015] [error] [client 124.253.60.123] oidc_proto_parse_idtoken: id_token payload could not be           validated, aborting, referer: https://static.gluu.org:44443/static/fake_redirect_uri

The screenshots and logs have been captured while writing the doc.

To solve this problem, log into the gluuCE server as:

    # service gluu-server login

#### Getting DN from Client ID

We get the client id from the search performed in gluu-server's Web UI. So, to get the DN part we perform the below command. The ldap password can be stored in /root/.pw or at any convenient location. In our case the command was:

`# /opt/opendj/bin/ldapsearch -T -X -Z -p 1636 -D "cn=Directory Manager" -j /root/.pw -s sub -b "o=gluu" 'inum=@!C648.9803.5565.E5CB!0001!0DB0.EEDB!0008!7728.5650'`


Create a file named `mod.ldif` with the following contents. The `oxAuthSubjectIdentifier` is same as the client id. Since it's missing initially when we register the client manually, so we have to add it later. The DN part to be used in `mod.ldif` is obtained from above command's output. 


    dn: inum=@!C648.9803.5565.E5CB!0001!0DB0.EEDB!0008!7728.5650,ou=clients,o=@!C648.9803.5565.E5CB!0001!0DB0.EEDB,o=gluu
    changetype: modify
    add: oxAuthSubjectIdentifier
    oxAuthSubjectIdentifier: @!C648.9803.5565.E5CB!0001!0DB0.EEDB!0008!7728.5650

Then run the `ldapmodify` command to insert the `oxAuthSubjectIdentifier` as below:

    /opt/opendj/bin/ldapmodify -Z -X -h localhost -p 1636 -D "cn=Directory Manager" -j /root/.pw -f /root/mod.ldif

The command may vary depending upon how you are using.

Then again access the page: ``https://static.gluu.org:44443/static` and very good chances are there that you'll see the success message.
