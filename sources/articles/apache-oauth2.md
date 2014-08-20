# Apache OAuth2 using mod_ox

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
            ApplicationPostLogoutUrl https://idpdev.mediaocean.com/oxauth/seam/resource/restv1/oxauth/end_session
            ApplicationLogoutRedirectUrl http://www.myexample.com/ox/
        </DirectoryMatch>



        
