# Gluu Server Community Edition (CE) Installation Guide

## System Requirements

The Gluu Server Community Edition should be deployed on a VM with:

* CentOS 6.5 
* Physical Memory: At least 2 GB (more is always better, though)

## Installing the GLUU CE

* Login to the system as root.
* Install the server with the following command:

    `rpm -ivh http://repo.gluu.org/GLUU/centos/6.5/base/x86_64/Packages/GLUU-1.0.5-CE.el6.x86_64.rpm`

It will take around 10 minutes to complete the installation on a VM that has 2GB of memory and 2 core processor.

* We've included a complete chroot environment for this server. So, before moving for the configuration, we have to login to chroot.
* Login to chroot environment with: 

    `chroot /home/my-package/chroot/gluu/ su - root`

* Configure the environment in `/etc/gluuce/config`
* NOTE: whitespace around '=' is not allowed! Use format:
    key=value
* Two properties MUST be set to customize your environment:

	* The IP of the VM (services will listen on this address) 
  	* The HOSTNAME (used in url) If we want the url to be: https://idp.example.com, we'll mention hostName as idp.exmaple.com 
  	* Don't modify properties prefixed with "old" unless you know what you are doing!

* Once you are ready for configuration, please run the command: `$ gluuce_configuration`
* The `inum` and `inumOrg` are generated automatically. These should be left untouched unless there is an absolute need for that.
* The configuration takes around 2 minutes to complete. Once done, the appliance is ready for being accessed from browser.
* Only https is allowed for browsing the server. The typical url you'll enter in the browser will be: `https://<HOSTNAME>`
* The default user/pass is `admin/admin`


