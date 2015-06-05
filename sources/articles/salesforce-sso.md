#SAML integration of Salesforce.com with Gluu Server

## Prepare Salesforce.com


* Log into Salesforce.com with your administrative account. 
* Click on 'Setup' [ right upper corner ] 
* You need to add a custom Domain name for your salesforce site if you don't have any yet. 
  * Go to 'Domain Management' –> 'My Domain' 
  * Add your custom domain 
  * Wait for some time. Salesforce will register this domain name for you. As for example we got something like 'testgluu-dev-ed.my.salesforce.com' for our testing 
  ![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/salesforce/My_Domain.png) 
  
  
*  Register your 'Gluu Server' information here in Salesforce
   * Go to 'Security Controls' –> 'Single Sign On Settings' 
   * Click 'New' 
  ![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/salesforce/SSO_Settings.png)