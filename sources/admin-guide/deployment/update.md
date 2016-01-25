[TOC]

# Updating Gluu CE
This guide outlines the update process to Gluu Server CE 2.4.1 from 2.4.0.

## Update Package Manually
### CentOS 6.x & 7

* Download [Gluu CE Update Package](http://repo.gluu.org/centos/testing/gluu-update24-2.4.1-1.el6.noarch.rpm)
* Run the following command to install the package:

	`rpm -ivh gluu-update24-2.4.1-1.el6.noarch.rpm`

Login to the Gluu CE chroot environment after the package is installed successfully and follow the steps to install the update.

* Go to the update folder
	
	`# cd /var/lib/gluu-update/2.4.1/bin`

* Run the `update.sh` file to install the update

	`# ./update.sh`

### Ubuntu Server 14.04

* Download [Gluu CE Update Package](http://repo.gluu.org/ubuntu/pool/main/trusty-devel/gluu-update24_2.4.1-1_all.deb)
* Run the following command to install the package:

        `rpm -ivh gluu-update24-2.4.1-1.el6.noarch.rpm`

Login to the Gluu CE chroot environment after the package is installed successfully and follow the steps to install the update.

* Go to the update folder

        `# cd /var/lib/gluu-update/2.4.1/bin`

* Run the `update.sh` file to install the update

        `# ./update.sh`

