## Ubuntu 14.04

#### Install Apache2 and enable module ssl as below:


    # sudo apt-get install apache2
    # sudo a2enmod ssl
    # service apache2 restart

Download mod_auth_openidc deb file as below.
If the binary is not available, then refer to https://github.com/pingidentity/mod_auth_openidc/wiki.
Then install the binary with dpkg and at the end enable the mod as shown below.


    # wget http://ftp.us.debian.org/debian/pool/main/liba/libapache2-mod-auth-openidc/libapache2-mod-auth-openidc_1.6.0-1_amd64.deb
    # dpkg -i libapache2-mod-auth-openidc_1.6.0-1_amd64.deb
    # a2enmod auth_openidc
    # service apache2 restart


Now, since we want to run this apache at `port 44443` for ssl and `port 8000` for non-ssl, we need to edit three files. The changes are done to avoid conflict with the Gluu Server's Apache ports. But, if the Gluu Server and Apache servers are different, no need to change the ports. Change port numbers in the file: `/etc/apache2/ports.conf`, `/etc/apache2/sites-available/000-default.conf` and `/etc/apache2/sites-available/default-ssl.conf` and restart apache2 service as mentioned above.

#### Dynamic Client Registration

Let's consider the case of dynamic client registration first.
For this purpose we'll name the server: **dynamic.gluu.org**.

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

Now, change the ownerships. This is **extremely critical** because without this apache won't be able to write the metadata inside the directory.

    # chown -R www-data:www-data /var/www/html

Let's create the apache config file now.

Create a file named `/etc/apache2/sites-available/dynamic.conf` with the contents as below:

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

Above, I've taken the cert and key files which are pre-existing at the server. Feel free to use your own.

Now, enable the site and restart the apache service as below:

    # a2ensite  dynamic.conf
    # service apache2 restart

Now, try to access the page: `https://dynamic.gluu.org:44443/dynamic` and you should see the discovery page as below. 

When presented with the discovery page, enter `admin@ce.gluu.org`

{{:dynamic_discovery.png?500|}}

The usual choice as per present used urls is: `admin@ce.gluu.org`. But you must use the existing user at the gluuCE along with existing url i.e `existing_user@your.gluu.ce.server`

After this we are presented with the oxAuth page from gluuCE where we enter the credentials for authentication.

{{:oxauth_authentication.png?500|}}




