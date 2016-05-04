[TOC]
# Installation
This is the installation guide for the Apache Module `auth_openaidc`.

## Apache Web Server

It is assumed that all the hostnames will be dns resolvable; if not, then add the entries in `/etc/hosts` file. Run the following commands to install Apache2, enable SSL and restart the server:

```
sudo apt-get install apache2
service apache2 restart
```

## SSL Configuration
The SSL Module is necessary for the Apache OpenID Connect Module. Please use the following commands to activate the `ssl module`.
```
sudo a2enmod ssl
service apache2 restart
```

The next step is to create a self-signed SSL Certificate.

* Create a directory to put the ssl certificates<br/>`sudo mkdir /etc/apache2/ssl`

* Generate the certificate<br/>`sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt`

* Answer the questions that are asked. A template is given below
```
	Country Name (2 letter code) [AU]:US
	State or Province Name (full name) [Some-State]:Texas
	Organization Name (eg, company) [Internet Widgits Pty Ltd]:Gluu Inc
	Organizational Unit Name (eg, section) []:Gluu Test
	Common Name (e.g. server FQDN or YOUR name) []:gluu.org
	Email Address []:support@gluu.org
```

### Configure Apache to use SSL
This section will guide you through the steps to configure apache to use the SSL module

1. Open the `default-ssl.conf` file<br/>`sudo vim /etc/apache2/sites-available/default-ssl.conf`

2. Edit the file to edit the following fields to look like the examples below

  * ServerName 
  * ServerAlias 
  * DocumentRoot
  * SSlCertificateFile
  * SSLCertificateKeyFile

3. Activate the SSl Virtual Host and restart Apache Server
```
sudo a2ensite default-ssl.conf
sudo service apache2 restart
```

### Restart Apache Manually
If Apache Web Server fails and the following error is shown, then Apache Server needs to be stopped manually.

`Restarting web server apache2                                               [fail]`

Run the following commands to stop the Apache Server manually:

```
sudo /etc/init.d/apache2 stop
sudo killall apache2
sudo netstat -l|grep www
sudo /etc/init.d/apache2 restart
```

## Authentication Module (auth_openidc)

Run the following command to download and install the `auth_openidc` module:

```
# wget http://ftp.us.debian.org/debian/pool/main/liba/libapache2-mod-auth-openidc/libapache2-mod-auth-openidc_1.6.0-1_amd64.deb
# dpkg -i libapache2-mod-auth-openidc_1.6.0-1_amd64.deb
```

If the package is not available, please check this [Github Page](https://github.com/pingidentity/mod_auth_openidc/wiki).

**Note:** This module depends on `libhiredis0.10, libpcre3, & libjansson4` package. If the dependencies are not met, please install them manually using the `apt-get` command.

### Load auth_openidc Module

The module can be enabled using the follwing command:

`sudo a2enmod auth_openidc`


The Apache Web Server must be restarted to load this module. Pleae run the following command to restart the Apache Server:

`sudo service apache2 restart`

**Note:** Restart the server after configuring the module, else the server will not restart and it will throw errors. To check for errors, please chek the `errors.log` file in `/var/log/apache/` folder.

# Configuration
This is the configuration guide for the Apache Module `mod_auth_aidc`.

## Apache Web Server

The default ports for `http` and `https` are not used for `auth_openidc` module, therefore it is necessary to update three files. The changes are done to avoid a conflict with the Gluu Server's Apache ports. 
But, if the Gluu Server and the Apache server are different, there is no need to change the ports. 

Change port numbers to **44443** (for SSL) and **8000** (for non-SSL) in these three files.

* /etc/apache2/ports.conf

* /etc/apache2/sites-available/000-default.conf

* /etc/apache2/sites-available/default-ssl.conf

# Client Registration
There are two methods for client registration:

1. Dynamic Client Registration
2. Manual Client Registration

The example configuration uses `dynamic.gluu.org` as the server name and `ce.gluu.org` as the Gluu Server name.

## Dynamic Client Registration
The following example shows the configuration for dynamic client registration. 

### Preparing auth_openidc Module
Please add the following lines in the `auth_openidc` configuration file.

Add the following lines in `/etc/apache2/mods-available/auth_openidc.conf`

```
OIDCMetadataDir /var/cache/apache2/mod_auth_openidc/metadata
OIDCClientSecret secret
OIDCRedirectURI https://dynamic.gluu.org:44443/dynamic/fake_redirect_uri
OIDCCryptoPassphrase secret
OIDCSSLValidateServer Off
```

The default `metadata` folder is used in this example but it can be changed to any other convenient location as well.
Run the following command to enable the module:

`sudo a2enmod auth_openidc`

### Preparing Protected Resource

Create a directory named `dynamic` inside the `/var/www/html` directory using the following command:

`sudo mkdir /var/www/html/dynamic`

Create a file named `index.html` in the `dynamic` folder and add the following content:

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

Change the ownership of the `html` directory using the following command:

`sudo chown -R www-data:www-data /var/www/html`

Create the apache configuration file named `dynamic.conf` in the `/etc/apache2/sites-available/` folder and add the following lines in the file:

```
<VirtualHost *:44443>
    ServerName dynamic.gluu.org
    DocumentRoot /var/www/html

    <Location /dynamic/>
        AuthType openid-connect
        Require valid-user
    </Location>

    SSLEngine On
    SSLCertificateFile /etc/apache2/ssl/apache.crt
    SSLCertificateKeyFile /etc/apache2/ssl/apache.key
</VirtualHost>
```

**Note:** The default certificate location for the SSL module is used in this example. Please change the locaiton if you use your own certificate.

### Enable Site
The `dynamic` site is enabled using the `a2ensite` command. Run the commands below to enable the site and restart Apache Server:

`sudo a2ensite dynamic.conf`

`sudo service apache2 restart`

### Access Site
The `dynamic` site can be accessed from the following URL:

`https://dynamic.gluu.org:44443/dynamic`

Accessing the link will land you in the discovery page.
![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/dynamic_discovery.png)

The usual choice as per present used uris is: `admin@ce.gluu.org`. Note
that you have to use an existing user at the gluuCE along with an
existing uri. An example is `existing_user@your.gluu.ce.server`.

After this the *oxAuth* page from gluuCE is displayed where you enter
the credentials for authentication.

![IMAGE](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/oxauth_authentication.png)

## Manual Client Registration
The following example shows the configuration for manual client registration.

### Preparing auth_openidc Module
Please add the following lines in the `auth_openidc` configuration file.

Add the following lines in `/etc/apache2/mods-available/auth_openidc.conf`

```
    OIDCRedirectURI https://static.gluu.org:44443/static/fake_redirect_uri
    OIDCCryptoPassphrase newsecret

    OIDCProviderMetadataURL https://ce.gluu.org/.well-known/openid-configuration
    OIDCClientID @!C648.9803.5565.E5CB!0001!0DB0.EEDB!0008!7728.5650
    OIDCClientSecret newsecret
    OIDCResponseType id_token
    OIDCProviderTokenEndpointAuth client_secret_basic

    OIDCProviderIssuer  https://ce.gluu.org
    OIDCSSLValidateServer Off
```

Run the following command to enable the module:

`sudo a2enmod auth_openidc`

### Preparing Protected Resource
Create a directory named `static` inside the `/var/www/html` directory using the following command:

`sudo mkdir /var/www/html/static`

Create a file named `index.html` in the `static` folder and add the following content:

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

Change the ownership of the html directory using the following command:

`sudo chown -R www-data:www-data /var/www/html`

Create the apache configuration file named static.conf in the `/etc/apache2/sites-available/` folder and add the following lines in the file:

```
<VirtualHost *:44443>
    ServerName static.gluu.org
    DocumentRoot /var/www/html

    <Location /static/>
        AuthType openid-connect
        Require valid-user
    </Location>

    SSLEngine On
    SSLCertificateFile /etc/ssl/certs/ssl-cert-snakeoil.pem
    SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
</VirtualHost>
```
### Enable Site
The dynamic site is enabled using the `a2ensite` command. Run the commands below to enable the site and restart Apache Server:

`sudo a2ensite static.conf`

`sudo service apache2 restart`

### Access Site
The `static` site can be accessed from the following URL:

`https://static.gluu.org:44443/static`

This link will lead to the oxAuth page from gluuCE where you enter the credentials for authentication.
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/mod_auth_oidc/oxauth_authentication.png)

There is a possibility that you will see the following error upon login:

```
Error:

The OpenID Connect Provider returned an error: Error in handling response type.
```

The apache log will contain the following:

```
[Fri Jun 05 14:48:28 2015] [error] [client 124.253.60.123] oidc_proto_validate_idtoken: id_token JSON payload did not contain the required-by-spec "sub" string value, referer: https://static.gluu.org:44443/static/fake_redirect_uri
[Fri Jun 05 14:48:28 2015] [error] [client 124.253.60.123] oidc_proto_parse_idtoken: id_token payload could not be validated, aborting, referer: https://static.gluu.org:44443/static/fake_redirect_uri
```

### Getting DN from Client ID
Log into the gluuCE server by running the following command:

`sudo service gluu-server login`

We get the client id from the search performed in Gluu Server's Web UI. So, to get the DN part we perform the below command. The LDAP password can be stored in /root/.pw or at any other location that is convenient for you. In our case the command is:

`/opt/opendj/bin/ldapsearch -T -X -Z -p 1636 -D "cn=Directory Manager" -j /root/.pw -s sub -b "o=gluu" 'inum=@!C648.9803.5565.E5CB!0001!0DB0.EEDB!0008!7728.5650'`

Create a file named `mod.ldif` with the contents given below. The DN part to be used in mod.ldif is obtained from output of the command above:

```
dn: inum=@!C648.9803.5565.E5CB!0001!0DB0.EEDB!0008!7728.5650,ou=clients,o=@!C648.9803.5565.E5CB!0001!0DB0.EEDB,o=gluu
changetype: modify
add: oxAuthSubjectIdentifier
oxAuthSubjectIdentifier: @!C648.9803.5565.E5CB!0001!0DB0.EEDB!0008!7728.5650
```

Then, run the `ldapmodify` command to insert the **oxAuthSubjectIdentifier** as below:

`sudo /opt/opendj/bin/ldapmodify -Z -X -h localhost -p 1636 -D "cn=Directory Manager" -j /root/.pw -f /root/mod.ldif`

The command may vary depending upon your installation. Next, access [this page](https://static.gluu.org:44443/static), and the success message should be visible or `<hostname>:44443/static`.
