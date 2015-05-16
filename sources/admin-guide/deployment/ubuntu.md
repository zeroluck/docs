**Table of Contents**  

- [Gluu Server Ubuntu Installation Guide](#gluu-server-ubuntu-installation-guide)	
	- [System Requirements](#system-requirements)	
	- [Install](#install)	
	- [Starting and Stopping the Gluu Server](#starting-and-stopping-the-gluu-server)	
	- [Login to chroot environment](#login-to-chroot-environment)	
	- [Running the latest setup](#running-the-latest-setup)		
	- [Uninstallation](#uninstallation)	
	

# Gluu Server Ubuntu Installation Guide

## System Requirements

The Gluu Server Community Edition should be deployed on a VM with:

* Ubuntu Server 14.04(Trusty)	
* 2 CPU Units and at least 2GB Physical Memory (more is always better, though)	

## Install 

Download and install Gluu-Server by following commands

Use the .deb installation to perform a base chroot installation with following Gluu Server Base Ubuntu requirements

New alternative using our Gluu repo for ubuntu trusty:

<code> # echo "deb http://repo.gluu.org/ubuntu/ trusty main" > /etc/apt/sources.list.d/gluu-repo.list </code>

<code> # curl http://repo.gluu.org/ubuntu/gluu-apt.key | apt-key add - </code>

<code> # apt-get update </code>

<code> # apt-get install gluu-server </code>

<code> # service gluu-server start </code>

<code> # service gluu-server login </code> 

<code> # cd /install/community-edition-setup/ </code>

<code> ./setup.py </code>

After setup.py script successful execution, login to oxTrust, the policy
administration point for Gluu by pointing your browser to 
https://hostname

Note: if you are not using a resolvable DNS host, you will need to add 
the hostname to your hosts file on the server which is running your browser.
Login with the default user name “admin” and the password printed back in 
the confirmation (also conatained in setup.properties.last (`grep -i pass`)
and look for the LDAP password which is the same as the admin password.

## Starting and Stopping the Gluu Server

<code> service gluu-server start </code>
 
<code> service gluu-server stop </code>

## Login to chroot environment

<code> # service gluu-sever login </code>

Or if you prefer... 

<code> chroot /home/gluu-server/ su - </code>

## Running the latest setup

To perform the final configuration of the Gluu Server you need to provide 
some Gluu Server appliance specific information, like the DNS hostname, and 
the information required for an X.509 certificate. 
We are always working to make the setup easier. After successful Gluu 
Server installation, run the Gluu Server `setup.py` to complete the 
installation. The script is installed in `/install`, or you can get the latest 
setup scripts:

<code> wget https://github.com/GluuFederation/community-edition-setup/archive/master.zip </code>

Unzip and cd to community-edition-setup

<code> ./setup.py </code>

Make sure you remove or encrypt setup.properties.last It has the clear text passwords for everything: LDAP, admin user, keystores, and 3DES salt.

If something goes wrong, check setup.log for a detailed step-by-step of the installation. Or check setup_errors.log to just see the errors (or stderr output from the scripts).

### Scripted Installation

If you want to script the installation of the Gluu Server, here is what you can do to achieve your target: 

* Save and backup your existing `setup.properties.last`
* Uninstall existing Gluu-Server installation
* For new installation you can either grab a new VM or use existing one
* Run all commands till `service gluu-server login`
* Copy your saved `setup.properties.last` file into new server's  /install/community-edition-setup/ location
* Rename `setup.properties.last` to `setup.properties`
* Run setup script with `./setup.py` command


# Uninstallation

Exit from chroot environment to main linux.

Stop the chroot environment, which will unmount all chroot directories and after delete rpm. Please look at following commands.

<code> # service gluu-server stop </code>

<code> # apt-get remove gluu-server </code>

<code> # rm -rf /home/gluu-server </code>

On installation, any modified files are saved in `/home/gluu-server.save`
If you want to blow away all remnants of the install, `rm -rf /home/gluu-server.save'

In some circumstances, the installation can be broken. In that case please 
try following to force uninstall the package.

<code> # dpkg --purge --force-all gluu-server </code>
