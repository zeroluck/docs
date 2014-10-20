# Gluu Server Community Edition (CE) Ubuntu Installation Guide

## System Requirements

The Gluu Server Community Edition should be deployed on a VM with:

* Ubuntu Server 14.04(Trusty)
* 2 CPU Units and at least 2GB Physical Memory (more is always better, though)


## Installing the GLUU CE
Download and install Gluu-Server by following commands

Use the .deb installation to perform a base chroot installation with following Gluu Server Base Ubuntu requirements

<code> wget http://repo.gluu.org/GLUU/ubuntu/pool/gluu/Gluu-CE-Repo-1.9-0.amd64.deb </code>

<code> dpkg -i Gluu-CE-Repo-1.9-0.amd64.deb </code>

<code> apt-get update </code>

<code> apt-get install gluu-server </code>

<code> service gluu-server start </code>

<code> chroot /home/gluu-server/ su - root </code>

<code> wget https://github.com/GluuFederation/community-edition-setup/archive/master.zip </code>

<code> apt-get install unzip </code>

<code> unzip master.zip </code>

<code> cd ./install/community-edition-setup/ </code>

<code> ./setup.py </code>


====== Starting | Stopping the Gluu Server ======


<code> /etc/init.d/gluu-server start </code>
 
<code> /etc/init.d/gluu-server stop </code>


====== Login to chroot environment ======


<code> chroot /home/gluu-server/ su - </code>


Gluu Server Setup

To perform the final configuration of the Gluu Server you need to provide some Gluu Server appliance specific information, like the DNS hostname, and the information required for an X.509 certificate. After successful Gluu Server rpm installation, run the Gluu Server setup.py to complete the installation. You can get the latest setup scripts:

<code> wget https://github.com/GluuFederation/community-edition-setup/archive/master.zip </code>

Unzip and cd to community-edition-setup

<code> ./setup.py </code>

TODO: Include final community-edition-setup bits in .deb so no wget is needed.

After setup.py script successful execution, point your browser to https://hostname Login with the default user name “admin” and the password printed back in the confirmation (also conatained in setup.properties.last)

Make sure you remove or encrypt setup.properties.last It has the clear text passwords for everything: LDAP, admin user, keystores, and 3DES salt.

If something goes wrong, check setup.log for a detailed step-by-step of the installation. Or check setup_errors.log to just see the errors (or stderr output from the scripts).

If you want to script the installation of the Gluu Server, user the -f option or just save the properties file as setup.properties and it will be automatically detected. Also use the -n option to suppress the interactive confirmation to proceed. For example, to re-run the last installation:

<code> ./setup.py -n -f setup.properties.last </code>


====== Gluu Server .deb uninstallation ======


Exit from chroot environment to main linux.

Stop the chroot environment, which will unmount all chroot directories and after delete rpm. Please look at following commands.

<code> /etc/init.d/gluu-server stop </code>

<code> apt-get remove gluu-server </code>

<code> rm -rf /home/gluu-server </code>

In some circumstances, the installation can be broken. In that case please try following to force uninstall the package.

<code> dpkg --purge --force-all gluu-server </code>


