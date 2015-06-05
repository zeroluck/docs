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
   * Now you need add your Gluu Server's information here
     * Name: Anything, whichever is easier for you to recognize this setup. i.e. 'Gluu Server'
     * API Name: Gluu Server. 
     * Issuer: EntityID of your Gluu Server. i.e. https://test.gluu.org/idp/shibboleth 
     * EntityID: Your Salesforce custom domain name. i.e. https://testgluu-dev-ed.my.salesforce.com
     * dentity Provider Certificate: Grab your Gluu Server's SAML certificate. SAML certificate can be grabbed from your Gluu Sever's metadata. Save the certificate in some .crt format and upload it. 
     * Request Signing Certificate: Default Certificate
     * Request Signature Method: RSA-SHA1
     * Assertion Decryption Certificate: Assertion not encrypted. 
     * SAML Identity Type: Assertion contains User's salesforce.com username
     * SAML Identity Location: Identity is in an Attribute element
     * Attribute Name: Provide 'SAML2 URI' of your attribute. For our test case we are using Gluu Server's Email attribute. How to check the information of your attribute is available [here](http://www.gluu.org/docs/admin-guide/configuration/#attributes).
     * NameID Format: Keep it blank
     * Identity Provider Login URL: https://test.gluu.org/idp/profile/SAML2/Redirect/SSO
     * Service Provider Initiated Request Binding: HTTP-Redirect
     * Here is how our final setup looks like: 
     ![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/salesforce/Final_setup.png)