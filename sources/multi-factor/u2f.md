# U2F
This script enables the multi-factor authentication based on u2f.
## Overview
The script has the following properties

|	Property	|	Description	|
|-----------------------|-----------------------|
|u2f_server_uri		|URL of the u2f server	|
|u2f_server_metadata_uri|URL of the u2f server metadata|

## Installation
### Configure oxTrust
Follow the steps below to configure the [DUO][duo] module in the oxTrust Admin GUI.

1. Go to Manager Custom Scripts

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_menu.png)

2. Click on the add custom script button

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_add.png)

3. Fill up the from and add the [U2F script](https://raw.githubusercontent.com/GluuFederation/oxAuth/master/Server/integrations/u2f/U2fExternalAuthenticator.py)

4. Enable the script by ticking the check box

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_enable.png)

5. Change the default authentication method to U2F

![image](https://raw.githubusercontent.com/GluuFederation/docs/75518bb90184aa1b096874526b4da5f9f924bd44/sources/img/2.4/admin_auth_default.png)

