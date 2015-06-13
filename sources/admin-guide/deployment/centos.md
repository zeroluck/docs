# Gluu Server Community Edition (CE) CentOS Configuration Guide

`chroot` is a pre-Docker OS level container technology. Like Docker, the `chroot` distribution includes a full linux distribution. As a file system based "jail", when you login to the Gluu Server from the host linux system, the `/` directory in the Gluu Server is actually `/home/gluu-server` on the host. 

This strategy has its pluses and minuses. In certain circumstances, there are ways for a hacker to “break out of the jail”, and escalate to the host file system. (You don't want to make any file system links from the chroot'd server to the main host!) The benefit is ease of deployment (Docker not required...). We wanted a simple package that people could install and uninstall quickly.

To report issues or provide feedback about the installation process, please use [GitHub](https://github.com/GluuFederation/community-edition-setup/issues) or register for an account on [https://support.gluu.org](https://support.gluu.org).

## System Requirements

The Gluu Server Community Edition should be deployed on a VM with:

* CentOS 6.5 
* 2 CPU Units and at least 2GB Physical Memory (more is always better, though)

### Installing GLUU Server with yum:

`# wget http://repo.gluu.org/centos/Gluu.repo -O /etc/yum.repos.d/Gluu.repo`

`# wget http://repo.gluu.org/centos/RPM-GPG-KEY-GLUU -O /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU`

`# rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU`

`# yum clean all`

`# yum install gluu-server`

### Start Gluu-Server: 

`# service gluu-server start`

## Gluu Server Configuration

To perform the final configuration of the Gluu Server you need to provide some instance specific information, like the DNS hostname, and the information required to generate certificates. Post rpm installation, run the Gluu Server `setup.py` to complete the installation.  See [setup.py help](./setup_py.md) or run `./setup.py -h` to see the latest installation options.  

* Login to Gluu Server container: 

`# service gluu-server login`

* Run "setup" script to perform the final installation: 

`# cd /install/community-edition-setup/`

`# ./setup.py`


After setup.py script successful execution, point your browser to `https://hostname` Login with the
default user name “admin” and the LDAP password printed back in the confirmation (also 
contained in `setup.properties.last`). If you want to see the full LDIF for the admin user,
it is contained in `/opt/opendj/ldif/people.ldif`

Make sure you remove or encrypt `setup.properties.last` It has the clear text passwords for everything: LDAP, admin user, keystores, and 3DES salt.

If something goes wrong, check `setup.log` for a detailed step-by-step of the installation. Or check 
`setup_errors.log` to just see the errors (or stderr output from the scripts).

<!--
If you want to script the installation of the Gluu Server, user the `-f` option or just save the 
properties file as `setup.properties` and it will be automatically detected. Also use the `-n` option 
to suppress the interactive confirmation to proceed. For example, to re-run the last installation:

`./setup.py -n -f setup.properties.last`
-->

## Starting | Stopping the Gluu Server

`# service gluu-server start`

`# service gluu-server stop`

## Login to chroot environment

`# service gluu-server login`

## Gluu Server Uninstallation

Exit from chroot environment to main linux. Stop the chroot environment, remove the Gluu Server,
then remove the Gluu yum repository

`# service gluu-server stop`

`# yum remove gluu-server`

`# rm -f -r /opt/gluu-server.rpm.saved`

<!--
or 

`# rpm -e Gluu-Server-Repo-2.0-0.el6.x86_64`
-->
