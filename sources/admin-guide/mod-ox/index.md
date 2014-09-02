Windows 7 (64bit)
=========
###Memcached Installation
1. Download Memcached from
[https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Windows(x64)/memcached
-win64.zip](https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Windows(x64)/memcached-win64.zip)
2. Run command prompt :

        :> memcached –d install
        :> memcached –d start

###Apache 2.4 Installation
1. Download Apache2.4 from:
[https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Windows(x64)/httpd-2.4.6-
x64.zip](https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Windows(x64)/httpd-2.4.6-x64.zip)
2. Decompress httpd-2.4.6-x64.zip into C:/Apache24.
3. Edit “C:\Windows\System32\drivers\etc\hosts”

        127.0.0.1 www.myexample.com

        (“www.myexample.com” : Name of Host Server. Could set by yourself.)
4. Edit “C:\Apache24\conf\httpd.conf”

Fix :

        #ServerName www.example.com:80->ServerName www.myexample.com:80
5.Run command prompt (Start->Run->cmd)

        :> cd C:\Apache24\bin
        :> httpd –k install
        :> httpd –k start
6.Test if Apache is installed or not. Open your web browser and use 
""www.myexample.com"". If you see something like below image; you are done!

###PHP 5.5 Installation
1. Download PHP5.5 from:
[https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Windows(x64)/php-5.5.9-
Win32-VC11-x64.zip](https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Windows(x64)/php-5.5.9-Win32-VC11-x64.zip)
2. Decompress php-5.5.9-Win32-VC11-x64.zip into C:/PHP.
3. Rename “C:\PHP\ php.ini-development” to php.ini
4. Edit “C:\PHP\php.ini”

Fix :

    ; extension_dir = "ext" -> extension_dir = "C:\PHP\ext"
5.Restart Apache2.4 on command prompt

    :> httpd –k restart

###PHP Memcache Installation
1. Download PHP5.5 from:
[https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Windows(x64)/php_memc
ache-3.0.8-5.5-ts-vc11-x64.zip](https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Windows(x64)/)
2. Decompress php-memcache-3.0.8-5.5-ts-vc11-x64.zip into C:/PHP/memcache.
3. Copy memcache/php_memcache.dll into ext/

        :> cd C:\PHP\
        :> copy memcache\php_memcache.dll ext\

4. Edit “C:\PHP\php.ini”

Add : 

    extension=php_memcache.dll
5.Edit “C:\Apache24\conf\httpd.conf”

Add : 

    LoadModule php5_module "C:/PHP/php5apache2_4.dll"
    PHPIniDir "C:/PHP/"
    AddType application/x-httpd-php .php
    AddHandler application/x-httpd-php .php
6.Restart Apache2.4 on command prompt

        :> httpd –k restart

###Shibboleth-SP Installation
1. Download MSI of Shibboleth-SP from:
[http://shibboleth.net/downloads/service-provider/latest/win64/shibboleth-sp-2.5.3-
win64.msi](http://shibboleth.net/downloads/service-provider/latest/win64/shibboleth-sp-2.5.3-win64.msi)
2. Start installation by double clicking the file “shibboleth-sp-2.5.3-win64.msi”Ox Apache Plugin Install Guide
3. License agreement

4. Destination folder (by default it is: C:\opt\shibboleth-sp\)You can select any 
directory, but this is best to follow the tree \opt\shibboleth-sp\
5. Click Next, finish installation.
6. Copy C:\opt\shibboleth-sp\etc\shibboleth\apache24.config into 

C:\Apache24\conf\extra

    :> copy C:\opt\shibboleth-sp\etc\shibboleth\apache24.config C:\Apache24\conf\extra 
7.Edit “C:\Apache24\conf\httpd.conf”

Add : 

    Include conf/extra/apache24.config
8.Restart Windows OS.

9.Restart Apache2.4 on command prompt

    :> httpd –k restart

###OX Plugin Installation
1. Download OX package from:
[https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Windows(x64)/ox.zip](https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Windows(x64)/ox.zip)
2. Decompress ox.zip into C:/ox.
3. Copy C:\ox\mod_ox.so into C:\Apache24\modules\
4. Copy C:\ox\ox.conf into C:\Apache24\conf\extra\
5. Edit “C:\Apache24\conf\extra\apache24.config”

Add :

    <Location /shibd>
              AuthType shibboleth
              ShibRequestSetting requireSession 1
              ShibUseHeaders on
              Require valid-user
    </Location>
6.Copy all directories in C:\ox\htdocs into C:\Apache24\htdocs

7.Copy all files in C:\ox\shibd\ into C:\opt\shibboleth-sp\etc\shibboleth\

8.Open “C:\opt\shibboleth-sp\etc\shibboleth\shibboleth2.xml” and check the following
lines.

        <!-- Chains together all your metadata sources. -->
        <MetadataProvider type="Chaining">
        <MetadataProvider type="XML" file="C:/opt/shibboleth-sp/etc/shibboleth/idpmetadata.xml"/>
        </MetadataProvider>
        … …
        <!-- TODO is password needed? -->
        <CredentialResolver type="File" key="C:/opt/shibboleth-sp/etc/shibboleth/spkey.key"
        certificate="C:/opt/shibboleth-sp/etc/shibboleth/spcert.crt" />

   (If you install Shibd SP into any other directory, please adjust RED paths)

9.Edit “C:\Apache24\conf\httpd.conf”

Add :

         LoadModule ox_module modules/mod_ox.so
        <IfModule ox_module>
        Include conf/extra/ox.conf
        </IfModule>
10.Restart Apache2.4 on command prompt

        :> httpd –k restart
11.Download OXD package from:
[https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Oxd.tar.gz](https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Oxd.tar.gz)

Decompress Oxd.zip into C:/Oxd and run Oxd server.

    :> cd C:/Oxd
    :> autorun(win).bat
12.On web browser, goto www.myexample.com/ox

###Ubuntu 12.04
####Memcached Installation
1. First, make sure your system is up to date

            # sudo apt-get update
            # sudo apt-get upgrade

2. Install Memcached via apt-get

            # sudo apt-get install memcached

###Apache 2 Installation
1. Install Apache2 via apt-get

            # sudo apt-get install apache2
            # sudo a2enmod ssl
            # sudo a2ensite default-ssl

2. Edit “/etc/hosts”

        127.0.0.1 www.myexample.com
   
  (“www.myexample.com” : Name of Host Server. Could set by yourself.)

3. Restart Apache2 service

        # sudo service apache2 restart

4. On web browser, go to https://www.myexample.com

###PHP 5 Installation
1. Install PHP5 via apt-get

        # sudo apt-get install php5
        # sudo apt-get install libapache2-mod-php5
        # sudo service apache2 restart

###PHP Memcache Installation
1. Install PHP memcache via apt-get

        # sudo apt-get install php5-memcache
        # sudo service apache2 restart

###Shibboleth-SP Installation
1. Install Shibboleth SP via apt-get

        # sudo apt-get install libapache2-mod-shib2
        # sudo a2enmod shib2
        # sudo service apache2 restart


###OX Plugin Installation
1. Install needed packages via apt-get

        # sudo apt-get install libtool automake g++ apache2-prefork-dev

2. Download OX package from:
[https://svn.gluu.info/repository/oauth2ApacheHTTPD/MOD_OX/Package/mod_ox-0.1.tar.gz](https://svn.gluu.info/repository/oauth2ApacheHTTPD/MOD_OX/Package/mod_ox-0.1.tar.gz)
3. Decompress mod_ox-0.1.tar.gz and compile OX.

        # tar –xzvf mod_ox-0.1.tar.gz
        # cd mod_ox
        # sudo chmod 755 autogen.sh
        # ./autogen.sh
        # ./configure && make && sudo make install
        # sudo cp ox.conf /etc/apache2/mods-available/
        # sudo ln -s /etc/apache2/mods-available/ox.conf /etc/apache2/mods-enabled/
        # sudo cp –r copies.into.htdocs/* /var/www/

4. Copy Shibboleth SP config files into Shibboleth-SP

        # sudo cp –f copies.into.htdocs/shibd/conf/* /etc/shibboleth/

5. Make “/etc/apache2/mods-avaliable/shib2.conf”

        # sudo gedit /etc/apache2/mods-available/shib2.conf

Add : 

    <Location /shibd>
        AuthType shibboleth
        ShibRequestSetting requireSession 1
        ShibUseHeaders on
        Require valid-user
    </Location>

    # sudo ln –s /etc/apache2/mods-available/shib2.conf /etc/apache2/mods-enabled/
6.Download Oxd Server and start Run.
[https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Oxd.tar.gz](https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/)

        # sudo service memcached restart
        # sudo service shibd restart
        # sudo service apache2 restart
        # tar –xzvf Oxd.tar.gz
        # cd oxd
        # sudo apt-get install openjdk-7-jre-headless
        # sudo chmod 755 autorun.sh
        # sudo ./autorun.sh

7.On web browser, goto www.myexample.com/ox

###CentOS 6.4
####Memcached Installation
1. First, you make sure your system is up to date

        # sudo yum update
        # sudo yum upgrade

2. Disable SELINUX and Firewall
[http://sharadchhetri.com/2013/02/27/how-to-disable-selinux-in-red-hat-or-centos/](http://sharadchhetri.com/2013/02/27/how-to-disable-selinux-in-red-hat-or-centos/)
3. Install Memcached via yum

        # sudo yum install memcached

###HTTPD Installation
1. Install HTTPD via yum

        # sudo yum install httpd openssl
        # sudo yum install mod_ssl
        # sudo mkdir /etc/httpd/ssl
        # sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/httpd/ssl/apache.key -out /etc/httpd/ssl/apache.crt

2. Open up the SSL config file :

        # sudo vim /etc/httpd/conf.d/ssl.conf

Uncomment the DocumentRoot and ServerName line and replace example.com with 
your DNS approved domain name or server IP address (it should be the same as the 
common name on the certificate. In this document “www.myexample.com”):

        ServerName www.myexample.com:443
Find the following three lines, and make sure that they match the extensions below:

        SSLEngine on
        SSLCertificateFile /etc/httpd/ssl/apache.crt
        SSLCertificateKeyFile /etc/httpd/ssl/apache.key
3.Restart HTTPD service

        # sudo service httpd restart

###PHP 5 Installation
1. Install PHP5 via yum

        # sudo yum install php
        # sudo service httpd restart

###PHP Memcache Installation
1. Install PHP memcache via yum

        # sudo yum install php-pecl-memcache
        # sudo service httpd restart

###Shibboleth-SP Installation
1. Install Shibboleth SP via yum
[https://tuakiri.ac.nz/confluence/display/Tuakiri/Installing+Shibboleth+2.x+SP+on+Red
Hat+based+Linux](https://tuakiri.ac.nz/confluence/display/Tuakiri/Installing+Shibboleth+2.x+SP+on+RedHat+based+Linux)

        # sudo wget 
        http://download.opensuse.org/repositories/security://shibboleth/CentOS_CentOS-6/security:shibboleth.repo -P /etc/yum.repos.d
        # sudo yum install shibboleth
        # sudo service shibd restart
        # sudo service httpd restart

###OX Plugin Installation
1. Install needed packages via apt-get

        # sudo yum install libtool automake gcc-c++ httpd-devel

2. Download OX package from:
[https://svn.gluu.info/repository/oauth2ApacheHTTPD/MOD_OX/Package/mod_ox-0.1.tar.gz](https://svn.gluu.info/repository/oauth2ApacheHTTPD/MOD_OX/Package/mod_ox-0.1.tar.gz)
3. Decompress mod_uma-0.1.tar.gz and compile UMA.

        # tar –xzvf mod_uma-0.1.tar.gz
        # cd mod_uma
        # sudo chmod 755 autogen.sh
        # ./autogen.sh
        # ./configure && make && sudo make install
        # sudo cp uma.conf /etc/httpd/conf.d/
        # sudo cp –r copies.into.htdocs/* /var/www/html/

4. Copy Shibboleth SP config into Shibboleth-SP

        # sudo cp –f copies.into.htdocs/shibd/conf/* /etc/shibboleth/

5. Edit “/etc/httdp/conf.d/shibd.conf”

Add : 

    <Location /shibd>
      AuthType shibboleth 
      ShibRequestSetting requireSession 1
      ShibUseHeaders on
      Require valid-user
    </Location>
6.Download Oxd Server and start Run.
[https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Oxd.tar.gz](https://svn.gluu.info/repository/oauth2ApacheHTTPD/ETC/Oxd.tar.gz)

        # sudo service memcached restart
        # sudo service shibd restart
        # sudo service httpd restart
        # tar –xzvf Oxd.tar.gz
        # cd oxd
        # sudo yum install java7
        # sudo chmod 755 autorun.sh
        # sudo ./autorun.sh
7.On web browser, goto www.myexample.com/uma

###Appendix
####ox.conf

    <DirectoryMatch "/ox">
    AuthType Gluu_ox
    Require valid-user
    # Connect|SAML
    AuthnType Connect
    # Trusted_RP | RS_ONLY
    AuthzType Trusted_RP
    # Needed only if AuthnType=Connect
    AcrValues https://schema.example.com/connect/basic
    # Needed only if AuthnType=SAML
    SAMLRedirectUrl http://www.myexample.com/secure/redirect.php
    # General
    OxdHostAddr 127.0.0.1
    OxdPortNum 8099
    MemcachedHostAddr 127.0.0.1
    MemcachedPortNum 11211
    ClientCredsPath /var/www/html/providence/seed.gluu.org-client_creds.json
    SendHeaders on

    # OpenID Connect Required - needed for both UMA and OpenID Connect
    ConnectDiscoveryUrl https://sso-dev.example.com/.well-known/openid-configuration
    ConnectRedirectUrl https://www.myexample.com/ox/ox_redirect.html
    ClientName myCLIENT

    # UMA
    UmaDiscoveryUrl https://sso-dev.example.com/.well-known/uma-configuration
    UmaResourceName TestResource
    UmaRsHost www.myexample.com
    UmaAmHost sso-dev.example.com 
    "https://schema.example.com/uma/resource"
    </DirectoryMatch>

Please refer [http://ox.gluu.org/doku.php?id=oxd:mod_ox](http://ox.gluu.org/doku.php?id=oxd:mod_ox)
