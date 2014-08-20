# Apache OAuth2 using mod_ox [ Work in Progress....]

mod_ox is an access control module implementing OIC+UMA and acts as Resource
Server side.

* OIC is implementing Implicit Flow of OpenID Connect specifications.
* UMA is implementing an User-Managed Access (UMA)

## Big picture

Solution consists of two parts:

* mod_ox - new apache module written in C which is loaded by httpd.
* oxd - mediator between mod_ox and UMA Authorization server. oxd is java application.

mod_ox defines set of custom directives for correct module configuration.

Communication between mod_ox and oxd is made via sockets on port 8099 (Port
should be configurable, 8099 should be used as default and fallback port).

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/openid_connect/oxd_overview.png?raw=true)

## Installation

These docs assume that you have Apache2/HTTPD installed and running already. Both of
Linux and Windows are supported.

### Prerequisites

* [memcached](http://memcached.org/) - An in-memory key-value store for small chunks of arbitrary data (strings, objects)
* oxd - It's a mediator betweenApache plugins (mod_ox, mod_uma) and OIC/UMA Authorization server. If you are interested to know more, a full documentation is available [here](http://ox.gluu.org/doku.php?id=oxd:home)

### Source collection

`mod_ox` development release can be collected from Gluu SVN
[link](https://svn.gluu.info/repository/oauth2ApacheHTTPD/MOD_OX/Package/mod_ox-0.1.tar.gz). 

_Note that if you download a development release you will need current versions
of the autotools installed, and you must run ./autogen.sh first before following
these instructions._ 



#### Compilation

* Untar the tarball

* Enter into mod_ox directory and follow below commands to configure:

        1. ./configure (./autogen.sh for development release)
        2. make
        3. sudo make install


* Verify that the module has been enabled in your ”httpd.conf”:

        # note that the path to your module might be different
        LoadModule ox_module /usr/lib/apache2/modules/mod_ox.so


#### Parameter configuration

* Open up `ox.conf`. This is the main configuration file. Here is a sample configuration attached below with brief description. 
 

        <DirectoryMatch "/ox">
            AuthType Gluu_ox
            Require valid-user

            # Connect|SAML
            AuthnType Connect

            # Valid only if AuthnType=Connect
            AmrValues https://schema.example.com/connect/basic

            # Valid only if AuthnType=SAML
            SAMLRedirectUrl http://www.myexample.com/secure/redirect.php

            # General
            OxdHostAddr 127.0.0.1
            OxdPortNum 8099
            MemcachedHostAddr 127.0.0.1
            MemcachedPortNum 11211
            ClientCredsPath /etc/myCLIENT/client_creds.json
            SendHeaders on

            # OpenID Connect Required - needed for both UMA and OpenID Connect
            ConnectDiscoveryUrl https://example.com/.well-known/openid-configuration
            ConnectRedirectUrl https://www.myexample.com/ox/redirect.html
            ClientName myCLIENT

            # UMA
            UmaDiscoveryUrl https://example.com/.well-known/uma-configuration
            UmaResourceName TestResource
            UmaRsHost www.myexample.com
            GETUmaAmHost idp.example.com "https://schema.example.com/uma/readPolicy1;https://schema.example.com/uma/readPolicy2"
            PUTUmaAmHost idp.example.com "https://schema.example.com/uma/write"
            POSTUmaAmHost idp.example.com "https://schema.example.com/uma/write"
            DELETEUmaAmHost idp.example.com "https://schema.example.com/uma/delete"
        
            # Logout
            ApplicationLogoutUrl http://www.myexample.com/ox/logout 
            ApplicationPostLogoutUrl https://idp.gluu.org/oxauth/seam/resource/restv1/oxauth/end_session
            ApplicationLogoutRedirectUrl http://www.myexample.com/ox/
        </DirectoryMatch>



| _Params_     |:     | Notes                                                                               | 
|:------------ |----- | ----------------------------------------------------------------------------------: |
| _/ox_        |:| Apache directory protected by mod_ox plugin. Could be set any directory in Apache   |
| _AuthType_   |:|`REQUIRED`. Always must be “Gluu_ox”. |
| _Require_ |:|`REQUIRED`. Always must be "valid-user" |
| _AuthnType_ |:|`REQUIRED`. Always must be one of Connect and SAML |
| _AcrValues_ |:| OPTIONAL. Requested Authentication Context Class Reference values |
| _SAMLRedirectUrl_ |:| OPTIONAL. URL specifying Shibboleth SP apache module. (e.g. http://www.example.com/secure/redirect.php) |
| _OxdHostAddr_ |:| OPTIONAL. Host Name or IP address of oxd server. This could be a host name or a IP address on a different host running oxd server. Default: (e.g. localhost or 127.0.0.1) |
| _OxdPortNum_ |:| OPTIONAL. Port Number of oxd server. Default: (e.g. 8099) |
| _MemcachedHostAddr_ |:| OPTIONAL. Host Name or IP address of memcached server. This could be a host name or a IP address on a different host running memcached server. If there is no Memcached, invalid. Default: (e.g. localhost or 127.0.0.1) |
| _MemcachedPortNum_ |:| OPTIONAL. Port Number of memcached server. If there is no Memcached, invalid. Default: (e.g. 11211) |
| _ClientCredsPath_ |:| OPTIONAL. Json file name to write user creds info on the file system. (e.g. /etc/myCLIENT/seed.gluu.org-client_creds.json)  In this case, /var/www/html/gluu/ should be writable. `sudo chmod 666 var/www/html/gluu/` |
| _SendHeaders_ |:| `REQUIRED`. Determine whether sending HTTP headers to oxAuth authorize requrest, or not (e.g. on | off) |
| _ConnectDiscoveryUrl_ |:| 'REQUIRED`. URL specifying the Authorization Server discovery endpoint. (e.g. https://as.example.com/.well-known/openid-configuration) As UMA uses OpenID Connect for client registration, and mod_ox is always used for either UMA or OpenID Connect, there is no use case where the OpenID Connect URL is not needed. |
| _ConnectRedirectUrl_ |:| `REQUIRED`. Redirection URL if authentication is succeed. Not really relevant for client authentication only, so if you are in doubt, just point it to the url of the folder you are protecting. This could be placed in any location, but recommended to be placed in the same directory protected by OX. (e.g. https://www.example.com/ox/ox_redirect.html) |
| _ClientName_ |:| `REQUIRED`. Client Name to be registered with the Authorization Server. Could be ANY name. |
| _UmaDiscoveryUrl_ |:| OPTIONAL. URL specifying the UMA discovery endpoint. (e.g. https://as.example.com/.well-known/uma-configuration) |
| _UmaResourceName_ |:| OPTIONAL. Resource name for UMA authentication. (e.g. TestResource). Could be any name.|
| _UmaRsHost_ |:| OPTIONAL. Resource server (host where apache is loacated e.g. www.example.com) |
| _GETUmaAmHost_ |:| OPTIONAL. Authorization server and scope for HTTP GET method (e.g. as.example.com "https://schema.example.com/uma/manager") |
| _PUTUmaAmHost_ |:| OPTIONAL. Authorization server and scope for HTTP PUT method (e.g. as.example.com "https://schema.example.com/uma/manager") |
| _POSTUmaAmHost_ |:| OPTIONAL. Authorization server and scope for HTTP POST method (e.g. as.example.com "https://schema.example.com/uma/manager") |
| _DELETEUmaAmHost_ |:| OPTIONAL. Authorization server and scope for HTTP DELETE method (e.g. as.example.com "https://schema.example.com/uma/manager") |
| _ClientCredsPath_ |:| File system location for client credentials. If blank, a new client will be created and save via Dynamic Client Registration. Sample format:|

        {
            "status": "ok",
            "data": {
                "client_id": "7fe914a5-6605-4372-9801-a78f8ac2d75b",
                "client_secret": "120fb4f5-ac08-494f-b94c-a2094e18f3c7",
                "registration_access_token": "86767689-ff3b-45d2-8dbc-6eabf329d3c0",
                "client_secret_expires_at": 1400920051
            }
        }


| _Params_     |:     | Notes                                                                               |
|:------------ |----- | ----------------------------------------------------------------------------------: |
| _ApplicationLogoutUrl_ |:| OPTIONAL. URL specifying openid logout. if the user hope to logout from openid authentification, just enter ApplicationLogoutUrl on web browser. Could be set any url in protected directory (e.g. http://www.myexample.com/ox/logout) |
| _ApplicationPostLogoutUrl_ |:| OPTIONAL. URL specifying openid logout processing server. Redirected by mod_ox, if the user enter ApplicationLogoutUrl (e.g. https://idpdev.mediaocean.com/oxauth/seam/resource/restv1/oxauth/end_session) |
| _ApplicationLogoutRedirectUrl_ |:| OPTIONAL. URL after logout. Could be set any url (e.g. http://www.myexample.com/ox) |

#### Further Configurations

* Copy `ox.conf` into Apache2/HTTPD directory.
* Apply sufficient permission for `ox.conf` file.
* Copy module in Apache2/HTTPD
* Enabled mod in httpd.conf


## Test

* Start your [oxd](http://ox.gluu.org/doku.php?id=oxd:home) server. 
* Restart Apache2/HTTPD
* In the web browser, try with your hostname and mod_ox protected site. As for example, our sample hostname is "www.myapache.com" and we are protecting "ox" directory. So: 
        
        http://www.myapache.com/ox
