# Gluu Server Ubuntu Installation Guide

## System Requirements

The Gluu Server Community Edition should be deployed on a VM with:

* Ubuntu Server 14.04 (Trusty Tahr)
* 2 cpu units and at least 4GB of physical memory (more is always better, though)

## Available Components

Please review the [deployment guide](./index.md) for a list of available
components during the installation.

## Install 

Download and install Gluu-Server by the following commands. Use the
`.deb` installation to perform a base chroot installation with the
following Gluu Server Base Ubuntu requirements.

As an alternative, use our Gluu repository for Ubuntu Trusty:

```
# echo "deb http://repo.gluu.org/ubuntu/ trusty main" > /etc/apt/sources.list.d/gluu-repo.list

# curl http://repo.gluu.org/ubuntu/gluu-apt.key | apt-key add -

# apt-get update

# apt-get install gluu-server

# service gluu-server start

# service gluu-server login

# cd /install/community-edition-setup/

#./setup.py
```

After the successful execution of `setup.py` script, login to oxTrust,
the policy administration point for Gluu. Point your browser to the uri
`https://hostname`.

Note: if you are not using a resolvable DNS host, you will need to add
the hostname to your hosts file on the server which is running your browser.
Login with the default user name “admin” and the password printed back in
the confirmation (also contained in `setup.properties.last` (use the
Unix command `grep --color -i pass` to find the according line quickly)
and look for the LDAP password which is the same as the admin password.

## Troubleshooting

Please see our [Cloud Deployment FAQ](../../faq/cloud-faq.md) for cloud
specific notes and our [Troubleshooting
FAQ](../../faq/troubleshooting.md) for solutions to common issues. In
addition, you can browse our [support site](https://support.gluu.org)
for solutions to many common problems we know about.

## Starting and Stopping the Gluu Server

```
# service gluu-server start

# service gluu-server stop
```

## Login to chroot environment

<code> # service gluu-server login </code>

Or if you prefer...

<code> chroot /home/gluu-server/ su - </code>

## Running the latest setup

To perform the final configuration of the Gluu Server you need to
provide some Gluu Server appliance specific information, like the DNS
hostname, and the information required for an X.509 certificate. We are
always working to make the setup easier. After successful Gluu Server
installation, run the Gluu Server `setup.py` to complete the
installation. The script is installed in the directory `/install`.

<code> ./setup.py </code>

Make sure you remove or encrypt `setup.properties.last`. It has the
clear text passwords for everything: LDAP, admin user, keystores, and
3DES salt.

If something goes wrong, check `setup.log` for a detailed step-by-step
of the installation. Or check `setup_errors.log` to just see the errors
(or stderr output from the scripts).

### Scripted Installation

If you want to script the installation of the Gluu Server, here is what
you can do to achieve your goal:

* Save and backup your existing `setup.properties.last`
* Uninstall existing Gluu-Server installation
* For new installation you can either grab a new VM or use existing one
* Run all commands till `service gluu-server login`
* Copy your saved `setup.properties.last` file into new server's  /install/community-edition-setup/ location
* Rename `setup.properties.last` to `setup.properties`
* Run setup script with `./setup.py` command


## Uninstallation

Exit from chroot environment to main Linux.

Stop the chroot environment, which will unmount all chroot directories.
After that, delete both the Gluu Server packages that are installed, and
the home directory of the Gluu Server user. The following commands
illustrate the single steps:

<code> # service gluu-server stop </code>

<code> # apt-get remove gluu-server </code>

<code> # rm -rf /home/gluu-server </code>

On installation, any modified files are saved in
`/home/gluu-server.save`. If you want to blow away all remnants of the
installation, delete these files with the command `rm -rf
/home/gluu-server.save'.

In some circumstances, the installation can be broken. In that case
please try the following to force uninstall the package.

<code> # dpkg --purge --force-all gluu-server </code>




