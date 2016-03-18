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

2. Click on the Person Authentication tab

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_person.png)

3. Select the [U2F script](https://raw.githubusercontent.com/GluuFederation/oxAuth/master/Server/integrations/u2f/U2fExternalAuthenticator.py)

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_u2f.png)

4. Enable the script by ticking the check box

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_enable.png)

5. Click Update 

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_update.png)

