## Ubuntu 14.04

Install Apache2 and enable module ssl as below:


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


