[TOC]
# Gluu Server Ubuntu Installation Guide

## System Requirements

The Gluu Server Community Edition should be deployed on a VM with:

* Ubuntu Server 14.04.2 (Trusty Tahr)
* 2 CPU units 
* At least 4GB of RAM (more is always better, though)
* 40 GB disk space

## Available Components

Please review the [deployment guide](./index.md) for a list of available
components during the installation.

## Install 

Download and install Gluu Server by the following commands. Use the
`.deb` installation to perform a base chroot installation with the
following Gluu Server Base Ubuntu requirements.

As an alternative, use our Gluu repository for Ubuntu Trusty (14.04):

```
# echo "deb http://repo.gluu.org/ubuntu/ trusty main" > /etc/apt/sources.list.d/gluu-repo.list

# curl http://repo.gluu.org/ubuntu/gluu-apt.key | apt-key add -

# apt-get update

# apt-get install gluu-server24
```

After both the retrieval, and the installation of the Gluu Server
software package start the Gluu Server, and login into the local chroot
environment to configure the Gluu Server. These are the single steps:

```
# service gluu-server24 start

# service gluu-server24 login

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

You can start the Gluu Server with this command:

```
# service gluu-server24 start
```

You can stop the Gluu Server with this command:

```
# service gluu-server24 stop
```

## Login to the chroot environment

```
# service gluu-server24 login
```

Or if you prefer...

```
# chroot /home/gluu-server24/ su -
```

## Running the latest setup

To perform the final configuration of the Gluu Server you need to
provide some instance specific information, like the DNS hostname, and
the information required to generate the X.509 certificate. Next, run
the script `setup.py` to complete the installation. The script is
located in the directory `/install`. For both help and the latest
installation options see either [setup.py help](./setup_py.md), or run
`./setup.py -h`.

Make sure you remove or encrypt `setup.properties.last`. It has the
clear text passwords for everything: LDAP, admin user, keystores, and
3DES salt.

If something goes wrong, check `setup.log` for a detailed step-by-step
of the installation. As an alternative you may check the file
`setup_errors.log` to just see the errors (or stderr output from the
scripts).

### Scripted Installation

If you want to script the installation of the Gluu Server, here is what
you can do to achieve your goal:

* Save and backup your existing file `setup.properties.last`.
* Uninstall existing Gluu Server installation.
* For a new installation you can either grab a new VM, or just use the
  existing one.
* Run all the commands until `service gluu-server24 login`.
* Copy your file `setup.properties.last` into the new server's
  `/install/community-edition-setup/` location.
* Rename the file `setup.properties.last` to `setup.properties`.
* Run the setup script with `./setup.py` command.

## Uninstallation

First, exit from the chroot environment to main Linux.

Second, stop the Gluu Server chroot environment which will unmount all
chroot directories. As a third step, delete both the Gluu Server
packages that are installed, and the home directory of the Gluu Server
user. The following commands illustrate the single steps:

```
# service gluu-server24 stop

# apt-get remove gluu-server24

# rm -rf /opt/gluu-server24
```

On an installation, any modified files are saved in the directory
`/home/gluu-server24.save`. If you want to remove all the remnants of the
installation, delete these files with the command `rm -rf
/home/gluu-server24.save'.

In some circumstances, the installation can be broken. In that case
please try the following to force to uninstall the package.

```
# dpkg --purge --force-all gluu-server24
```

## Troubleshooting
Please see our [Cloud Deployment FAQ](../../faq/cloud-faq.md) for cloud
specific notes and our [Troubleshooting
FAQ](../../faq/troubleshooting.md) for solutions to common issues we
know about.

## Support
Gluu offers both community and VIP support. Anyone can browse and open
tickets on our [support portal](http://support.gluu.org). For private
support, expedited assistance, and strategic consultations, please view
[our pricing](http://gluu.org/pricing) and [schedule a meeting with
us](http://gluu.org/booking) to discuss VIP support options.

