# Gluu Server Ubuntu Installation Guide

## System Requirements

The Gluu Server Community Edition should be deployed on a VM with:

* Ubuntu Server 14.04(Trusty)
* 2 CPU Units and at least 2GB Physical Memory (more is always better, though)

## Quick Install of the Gluu Server for the impatient! 

Download and install Gluu-Server by following commands

Use the .deb installation to perform a base chroot installation with following Gluu Server Base Ubuntu requirements

<code> # wget http://repo.gluu.org/GLUU/ubuntu/pool/gluu/Gluu-CE-Repo-1.9-0.amd64.deb </code>

<code> # dpkg -i Gluu-CE-Repo-1.9-0.amd64.deb </code>

<code> # apt-get update </code>

<code> # apt-get install gluu-server </code>

<code> # service gluu-server start </code>

<code> # service gluu-server login </code> 

<code> # cd /install/community-edition-setup-master/ </code>

<code> ./setup.py </code>

After setup.py script successful execution, login to oxTrust, the policy
administration point for Gluu by pointing your browser to 
https://hostname

Note: if you are not using a resolvable DNS host, you will need to add 
the hostname to your hosts file on the server which is running your browser.
Login with the default user name “admin” and the password printed back in 
the confirmation (also conatained in setup.properties.last (`grep -i pass`)
and look for the LDAP password which is the same as the admin password.

### Starting | Stopping the Gluu Server

<code> /etc/init.d/gluu-server start </code>
 
<code> /etc/init.d/gluu-server stop </code>

### Login to chroot environment

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

If you want to script the installation of the Gluu Server, user the -f option or just save the properties file as setup.properties and it will be automatically detected. Also use the -n option to suppress the interactive confirmation to proceed. For example, to re-run the last installation:

<code> ./setup.py -n -f setup.properties.last </code>

### Gluu Server uninstallation

Exit from chroot environment to main linux.

Stop the chroot environment, which will unmount all chroot directories and after delete rpm. Please look at following commands.

<code> # /etc/init.d/gluu-server stop </code>

<code> # apt-get remove gluu-server </code>

<code> # rm -rf /home/gluu-server </code>

On installation, any modified files are saved in `/home/gluu-server.save`
If you want to blow away all remnants of the install, `rm -rf /home/gluu-server.save'

In some circumstances, the installation can be broken. In that case please 
try following to force uninstall the package.

<code> # dpkg --purge --force-all gluu-server </code>
