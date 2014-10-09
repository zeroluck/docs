# Apache OAuth2 using mod_ox

## Big picture

The solution consists of two parts:

* oxd - a standalone Java application that acts as a mediator between the web server plugins, and the OAuth2 Authorization Servers (either OpenID Connect or UMA) 
* mod_ox - Apache module

mod_ox defines set of custom directives for correct module configuration. Communication between mod_ox and oxd is made via sockets on port 8099 (Port should be configurable, 8099 should be used as default and fallback port).

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/openid_connect/oxd_overview.png?raw=true)

### Prerequisites

* [memcached](http://memcached.org/) - An in-memory key-value store for small chunks of arbitrary data (strings, objects)
* Apache HTTPD Server
* oxd - It's a mediator betweenApache plugins (mod_ox, mod_uma) and OIC/UMA Authorization server. If you are interested to know more, a full documentation is available [here](http://ox.gluu.org/doku.php?id=oxd:home)

### Source collection

`mod_ox` can be obtained from [Github](https://github.com/GluuFederation/mod_ox/archive/master.zip)

_Note that if you download a development release you will need current versions
of the autotools installed, and you must run ./autogen.sh first before following
these instructions._ 

#### Compilation

* Unzip the `mod_ox-master.zip`

* Enter into mod_ox directory and follow below commands to configure:

        1. ./configure (./autogen.sh for development release)
        2. make
        3. sudo make install

* Verify that the module has been enabled in your ”httpd.conf”:

        # note that the path to your module might be different
        LoadModule ox_module /usr/lib/apache2/modules/mod_ox.so

#### Configuration

See [mod_ox configuration page](../../reference/oxd)

## Test

* Start your oxd server
* Restart Apache2 HTTPD
* In the web browser, try with your hostname and mod_ox protected site. 
        http://www.myapache.com/ox

