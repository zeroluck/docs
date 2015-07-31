Instructions on how to install mod_auth_oidc with the Gluu Server.

## CentOS 6.x

#### Add EPEL Repo
`rpm -ivh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm`

#### Setup Apache2 SSL

    # yum install httpd mod_ssl
    # yum install curl hiredis jansson
    # rpm -ivh https://github.com/pingidentity/mod_auth_openidc/releases/download/v1.8.2/mod_auth_openidc-1.8.2-1.el6.x86_64.rpm

Confirm presence of the the mod file as below:
    # ls -l /usr/lib64/httpd/modules/mod_auth_openidc.so 

Next, create an apache conf file for loading this module. After that start the apache service.

    # cat "LoadModule auth_openidc_module modules/mod_auth_openidc.so" > /etc/httpd/conf.d/mod_auth_openidc.conf
    # service httpd start

For our demonstration, we are running gluuCE at **ce.gluu.org**.
 
Apache mod is being run at the same server but at the port **44443**.
You may choose your own and make appropriate changes.

#### Dynamic Client Registration

Let's consider the case of dynamic client registration first.
For this purpose we'll name the server: **dynamic.gluu.org**.

Let's prepare the server for serving the content protected by gluuCE.

Create a directory named as: **dynamic** inside **/var/www/html**

    # mkdir /var/www/html/dynamic

Now, let's create a file named **index.html** inside above directory with the following content:

    <html>
	      <title>
		    Protected URL
	      </title>
	     <body>
		  Nice to see the protected url via Dynamic Registration
	     </body>
    </html>

Create another directory named **metadata** in **/var/www/html** which will hold the metadata.

    # mkdir /var/www/html/metadata

Now, change the ownerships. This is **super critical**, because without this apache won't be able to write the metadata inside the directory.

    # chown -R apache:apache /var/www/html

Let's create the apache config file now.
Create a file named **/etc/httpd/conf.d/dynamic.conf** with the contents as below:

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

Now, try to access the page: **https://dynamic.gluu.org:44443/dynamic** and you should see the discovery page as below: You'll be presented with a discovery page, enter ''admin@ce.gluu.org''

{{:dynamic_discovery.png?500|}}


The usual choice as per present used urls is: **admin@ce.gluu.org**. But you must use the existing user at the gluuCE along with existing url i.e existing_user@your.gluu.ce.server

After this we are presented with the oxAuth page from gluuCE where we enter the credentials for authentication.

{{:oxauth_authentication.png?500|}}
