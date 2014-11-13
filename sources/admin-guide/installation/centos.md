# Gluu Server Community Edition (CE) CentOS Configuration Guide

`chroot` is an OS level virtualization technique, such as Solaris Zones or FreeBsd jail. You can view it as a complete, independent Linux system which is being run on another Main Linux host. For example, the `/` directory in the Gluu Server is actually `/home/gluu-server` on the Main host. 

This strategy has its pluses and minuses. In certain circumstances, there are ways for a hacker to “break out of the jail”, and escalate to the host file system. (You don't want to make any file system links from the chroot'd server to the Main host!) The benefit from our perspective was ease of deployment, and loose bundling to the IAAS services needed to support the Gluu Server.

Note: to report issues or provide feedback, please use [GitHub](https://github.com/GluuFederation/community-edition-setup/issues) or register for an account on [https://support.gluu.org](https://support.gluu.org).

## System Requirements

The Gluu Server Community Edition should be deployed on a VM with:

* CentOS 6.5 
* 2 CPU Units and at least 2GB Physical Memory (more is always better, though)

## Installing the GLUU Server

`# rpm -ivh http://repo.gluu.org/GLUU/centos/latest/base/x86_64/Packages/Gluu-Server-Repo-1.9-0.el6.x86_64.rpm`

`# yum install gluu-server.x86_64 -y`

`# service gluu-server start`

Note, if you don't want to use yum, you can also download the [RPM](http://repo.gluu.org/GLUU/centos/latest/base/x86_64/Packages/Gluu-Server-1.9-0.el6.x86_64.rpm
)

## Gluu Server Configuratioin

To perform the final configuration of the Gluu Server you need to provide some instance
specific information, like the DNS hostname, and the information required for 
an X.509 certificate. After successful Gluu Server rpm installation, run the Gluu Server 
`setup.py` to complete the installation. You can get the latest setup scripts:

`# chroot /home/gluu-server/ su -`

`# cd /install/community-edition-setup-master/`

`# ./setup.py`

To get an updated Community Edition Setup script, download the latest zip file:

`# wget https://github.com/GluuFederation/community-edition-setup/archive/master.zip`

After setup.py script successful execution, point your browser to `https://hostname` Login with the 
default user name “admin” and the password printed back in the confirmation (also 
conatained in `setup.properties.last`). If you want to see the full LDIF for the admin user, 
it is contained in `/opt/opendj/ldif/people.ldif`

Make sure you remove or encrypt `setup.properties.last` It has the clear text passwords for everything: LDAP, admin user, keystores, and 3DES salt.

If something goes wrong, check `setup.log` for a detailed step-by-step of the installation. Or check 
`setup_errors.log` to just see the errors (or stderr output from the scripts).

If you want to script the installation of the Gluu Server, user the `-f` option or just save the 
properties file as `setup.properties` and it will be automatically detected. Also use the `-n` option 
to suppress the interactive confirmation to proceed. For example, to re-run the last installation:

`./setup.py -n -f setup.properties.last`

## Starting | Stopping the Gluu Server

`# /etc/init.d/gluu-server start`

`# /etc/init.d/gluu-server stop`

## Login to chroot environment

`# chroot /home/gluu-server/ su -`

## Gluu Server Uninstallation

Exit from chroot environment to main linux. Stop the chroot environment, remove the Gluu Server,
then remove the Gluu yum repository

`# /etc/init.d/gluu-server stop`

`# yum remove Gluu-Server`

`# rm -rf /home/gluu-server`

`# rpm -e http://repo.gluu.org/GLUU/centos/latest/base/x86_64/Packages/Gluu-Server-Repo-1.9-0.el6.x86_64`

