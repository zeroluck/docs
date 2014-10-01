# Gluu Server Community Edition (CE) CentOS Configuration Guide

`chroot` is an OS level virtualization technique, such as Solaris Zones or FreeBsd jail. You can view it as a complete, independent Linux system which is being run on another Main Linux host. For example, the `/` directory in the Gluu Server is actually `/home/gluu-server` on the Main host. 

This strategy has its pluses and minuses. In certain circumstances, there are ways for a hacker to “break out of the jail”, and escalate to the host file system. (You don't want to make any file system links from the chroot'd server to the Main host!) The benefit from our perspective was ease of deployment, and loose bundling to the IAAS services needed to support the Gluu Server.

## System Requirements

The Gluu Server Community Edition should be deployed on a VM with:

* CentOS 6.5 
* 2 CPU Units and at least 2GB Physical Memory (more is always better, though)


## Installing the GLUU CE

`rpm -ivh http://repo.gluu.org/GLUU/centos/latest/base/x86_64/Packages/Gluu-Server-Repo-1.9-0.el6.x86_64.rpm`

`yum install Gluu-Server.x86_64 -y`

`service gluu-server start`

`chroot /home/gluu-server/ su -`

`cd /install/community-edition-setup/`

`./setup.py`
    
## Starting | Stopping the Gluu Server

`/etc/init.d/gluu-server start`

`/etc/init.d/gluu-server stop`

## Login to chroot environment
`chroot /home/gluu-server/ su -`

## Gluu Server Setup
To perform the final configuration of the Gluu Server you need to provide some Gluu Server appliance specific information, like the DNS hostname, and the information required for an X.509 certificate. After successful Gluu Server rpm installation, run the Gluu Server setup.py to complete the installation. You can get the latest setup scripts:

`wget https://github.com/GluuFederation/community-edition-setup/archive/master.zip`

Unzip and cd to community-edition-setup

`./setup.py`

TODO: Include final [community-edition-setup](https://github.com/GluuFederation/community-edition-setup) bits in RPM so no `wget` is needed.

After setup.py script successful execution, point your browser to `https://hostname` Login with the default user name “admin” and the password printed back in the confirmation (also conatained in `setup.properties.last`)

Make sure you remove or encrypt `setup.properties.last` It has the clear text passwords for everything: LDAP, admin user, keystores, and 3DES salt.

If something goes wrong, check `setup.log` for a detailed step-by-step of the installation. Or check `setup_errors.log` to just see the errors (or stderr output from the scripts).

If you want to script the installation of the Gluu Server, user the `-f` option or just save the properties file as `setup.properties` and it will be automatically detected. Also use the `-n` option to suppress the interactive confirmation to proceed. For example, to re-run the last installation:

`./setup.py -n -f setup.properties.last`

## Gluu Server RPM Uninstallation
Exit from chroot environment to main linux.

Stop the chroot environment, which will unmount all chroot directories and after delete rpm. Please look at following commands.

`/etc/init.d/gluu-server stop`

`rpm -e Gluu-Server-1.9-0.el6.x86_64.rpm`

`rm -rf /home/gluu-server`


