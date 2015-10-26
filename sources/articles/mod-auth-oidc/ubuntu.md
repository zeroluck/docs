[TOC]
# Installation
This is the installation guide for the Apache Module `auth_openaidc`.

## Apache Web Server

It is assumed that all the hostnames will be dns resolvable; if not, then add the entries in `/etc/hosts` file. Run the following commands to install Apache2, enable SSL and restart the server:

```
sudo apt-get install apache2
sudo a2enmod ssl
service apache2 restart
```

### Manual Restart for Apache
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

## Authentication Module (auth_openidc)
The configuration file for this module is located in `/etc/apache2/mods-available/auth_openidc.conf` and `/etc/apache2/mods-enabled/auth_openidc.conf`. The file in `/mods-available/` should be edited before enabling, and `/mods-enabled/` after enabling the module. Please see the respective client registration for configuration details.

Add the following lines in `/etc/apache2/mods-available/auth_openidc.conf`

# Client Registration
There are two methods for client registration:

1. Dynamic Client Registration
2. Manual Client Registration

The example configuration uses `dynamic.gluu.org` as the server name and `ce.gluu.org` as the Gluu Server name.

## Dynamic Client Registration
The following example shows the configuration for dynamic client registration. Please add the following lines in the `auth_openidc` configuration file.

```
OIDCMetadataDir /var/cache/apache2/mod_auth_openidc/metadata
OIDCClientSecret secret
OIDCRedirectURI https://dynamic.gluu.org:44443/dynamic/fake_redirect_uri
OIDCCryptoPassphrase secret
OIDCSSLValidateServer Off
```

The default `metadata` folder is used in this example but it can be changed to any other convenient location as well.

The following example shows how to prepare the server to serve an `index.html` file protected by Gluu Server Community Edition.

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

### Apache Configuration
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
    SSLCertificateFile /etc/ssl/certs/ssl-cert-snakeoil.pem
    SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key
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

