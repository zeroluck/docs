# oxPush2
This script enables use of the free open source [oxPush2 multi-factor authentication](https://github.com/GluuFederation/oxPush2) mechanism.
## Overview
The script has the following properties

|	Property	|	Description		|	Example	|
|-----------------------|-------------------------------|---------------|
|application_id		|URL of the identity server	|https://idp.gluu.info|
|authentication_mode	|Determine factor of authentication|two_step|
|credentials_file	|JSON file for oxPush2 		|/etc/certs/oxpush2_creds.json|

## Installation
### Configure oxTrust
Follow the steps below to configure the oxPush2 module in the oxTrust Admin GUI.

1. Go to Manager Custom Scripts

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_menu.png)

2. Click on the Person Authentication tab

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_person.png)

3. Select the [oxPush2 script](://raw.githubusercontent.com/GluuFederation/oxAuth/master/Server/integrations/oxpush2/oxPush2ExternalAuthenticator.py)

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_oxpush2.png)

4. Enable the script by ticking the check box

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_enable.png)

5. Click Update 

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_update.png)

6. Change the default authentication method to oxPush2

![image](https://raw.githubusercontent.com/GluuFederation/docs/75518bb90184aa1b096874526b4da5f9f924bd44/sources/img/2.4/admin_auth_default.png)

