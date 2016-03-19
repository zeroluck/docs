# DUO 
This is the person authentication module for oxAuth enabling [DUO][duo] for 
user authentication.

## Overview
There are a few properties in the [DUO][duo] Authentication Script.

|	Property	|Status		|	Description	|	Example		|
|-----------------------|---------------|-----------------------|-----------------------|
|duo_creds_file		|Mandatory     |Path to ikey, skey, akey|/etc/certs/duo_creds.json|
|duo_host		|Mandatory    |URL of the DUO API Server|api-random.duosecurity.com|
|audit_attribute	|Optional|Attribute to determine user group|memberOf		|
|duo_group		|Optional|Attribute to enable DUO for specific user|memberOf	|
|audit_group		|Optional|Notify administrator via email upon user login|memberOf|
|audit_group_email	|Optional|Administrator email		| admin@organization.com|

## Installation
The following steps prepare the Gluu Server for [DUO][duo] integration.

### Jython Installation
The [DUO][duo] module depends on python libraries and this section will outline the steps for installing Jython.

1. Install Jython 2.5.3 in `/opt/jython-2.5.3` following the [Installation Instructions](http://wiki.python.org/jython/InstallationInstructions).

2. Set permissions to jython folder using the following command
`chown -R tomcat.tomcat /opt/jython-2.5.3`

3. Create symlink from _/opt/jython-2.5.3_ to _/opt/jython_
`ls -s /opt/jython-2.5.3 /opt/jython`

### Configure CE Chroot

1. Copy requred python libraries from `.lib` folder to `$CATALINA_HOME/conf/python`

2. Prepare the DUO credential file `/etc/certs/duo_creds.json` with **ikey, akey & skye**

### Configure oxTrust
Follow the steps below to configure the [DUO][duo] module in the oxTrust Admin GUI.

1. Go to Manage Custom Scripts  
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_menu.png)

2. Click on the add custom script button   
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_add.png)

3. Fill up the from and add the [DUO authentication script](https://raw.githubusercontent.com/GluuFederation/oxAuth/master/Server/integrations/duo/DuoExternalAuthenticator.py)

4. Enable the script by ticking the check box  
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_enable.png)

5. Change the default authentication method to [DUO][duo]
![image](https://raw.githubusercontent.com/GluuFederation/docs/75518bb90184aa1b096874526b4da5f9f924bd44/sources/img/2.4/admin_auth_default.png)

[duo]: https://www.duosecurity.com "Duo Authentication"
