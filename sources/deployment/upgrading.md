[TOC]

# Upgrading

Upgrading a Gluu Server is NOT a simple `apt-get upgrade`. The admin needs to explicitly install the version of the Gluu Server. It generally involves the following steps:

* Install new version
* Export the data from your current version
* Stop the current Gluu Server
* Start the new version of Gluu Server
* Import data into the new server

Gluu provides the required [scripts](https://github.com/GluuFederation/community-edition-setup/tree/master/static/scripts) necessary to perform the import and export of the data in and out of the servers.

## Upgrading from 2.4.x to 2.4.2 (latest)

> IMPORTANT: Replace `gluu-server24` with `gluu-server-2.4.1` in the commands, if you are running version 2.4.1

### Export the data from the current installation

```
# service gluu-server24 login

# wget https://raw.githubusercontent.com/GluuFederation/community-edition-setup/master/static/scripts/export24.py

# chmod +x export24.py

# ./export24.py
```

The export script will generate a directory called `backup_24` which will have all the data backed up from the current installation.
Check the log file generated in the directory for any errors.

### Install the latest version of the Gluu server

Consult the docs pages of the respective distribution about how to install the Gluu Server using the package manager. Once the package manager has installed the version `2.4.2`, then:

```
# service gluu-server24 stop  

# cp -r /opt/gluu-server24/root/backup_24/ /opt/gluu-server-2.4.2/root/

# service gluu-server24 stop

# service gluu-server-2.4.2 start

# service gluu-server-2.4.2 login

# cp backup_24/setup.properties /install/community-edition-setup/

# cd /install/community-edition-setup/

# ./setup.py
```

Enter the required information for the setup and complete the installation.

### Import your old data

Go to the folder where you have the backup_24 folder (if the above commands were followed, it is in /root/) and  get the necessary scripts.

```
# cd ~

# wget https://raw.githubusercontent.com/GluuFederation/community-edition-setup/master/static/scripts/imoport24.py

# wget https://raw.githubusercontent.com/GluuFederation/community-edition-setup/master/ldif.py
```

Install the `python-pip` package using your package manager, e.g., `apt-get install python-pip`

```
# pip install jsonmerge

# chmod +x import24.py

# ./import24.py backup_24
```

Any error or warning will be displayed in the terminal or can be seen in the import log generated. Now the admin should be able to log into the oxTrust web-UI with the old admin credentials and see all previous data in place.
