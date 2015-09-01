# SAML Trust Relationship with Hobsons Education Solutions Co

This guide has been prepared to connect the Hobsons Service Provider (SP) with the Gluu Server for SP-inititated SSO.
The connection is extablished through the creation of a Trust Relationship using the Gluu Server UI, oxTrust.

## Creating Hobsons Trust Relationship

* Log in to your Gluu Server using admin credentials.

* Click on the SAML tab and select Trust Relationships. Then click on the Add Relationship button.

![Add Relationship](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_saml_create.png)

* The add relationship button will open the following page, the trust relationship can be created easily using the following form.

![Add empty form](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_saml_newTR.png)

	1. Display Name: This field contains the display name of the trust relationship. We have used “Test Hobsons-Radius TR” as an example.

	2. Description: A small description of Hobsons can be input here.

	3. Metadata Type: Please select URI from the dropdown menu.

	4. SP Metadata URL: The metadata URL provided by Hobsons goes in this field.

	5. SP Logout URL: This should be ideally supplied by the Hobsons staff; if you have not received any logout URL, then leave it blank.

	4. Released: The necessary attributes, Transientid and the eduPersonPrincipalName, were selected from the attribute list.
 
![hobsons-tr](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/hobsons-tr.jpeg)

	5. Finally click on "Add" to finish creating the trust relationship.

## Configuring Hobsons Trust Relationship

Please ensure that the new trust relationship status is "active", else click on the trust relationship and activate it before configuring it.

![hobsons-tr-active](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/hobsons-tr-active.jpeg)

The configuration screen can be accessed by clicking on the Hobsons Trust Relationship.

1. Configure Metadata Filters: Do not make any changes.

2. Configure specific Relying Pary: Check this option and a link "Configure Relying Party" will appear.

3. Configure Relying Party: Click the link and a new window shall appear.

	* Select SAML2SSO from the list and click the "Add" button.

	* Set "signResponses", "signAssertions", "signRequests" and "encryptAssertions" to Conditional from the drop-down menu.

	* Set "encryptNameIds" to Never from the drop-down menu and click "Save".

![hobsons-tr-update](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/sp_setup/hobsons-tr-update.jpeg)

4. Click "Update" to finish the Trust Relationship.
