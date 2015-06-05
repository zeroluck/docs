#SAML integration of Salesforce.com with Gluu Server

By default Salesforce suggest deployers to implement IDP-initiated SSO.
The initialization of IDP-initiated SSO is hectic as it require a big hostname
which includes IDP's SSO link as well as SP's login url. So we prefer
SP-initiated SSO and here in this documentation we are presenting a very simple
SP-initiated SSO steps with Salesforce and Gluu Server. 

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
     
     
## Prepare Gluu Server

* How to create SAML trust relationship is available [here](http://www.gluu.org/docs/admin-guide/saml/outbound-saml/#saml-trust-relationship). 
* Grab Salesforce metadata from Salesforce site. There is an option named 'Download Metadata' there. 
  * Modify Salesforce metadata a bit: 
    * Remove AuthnRequestsSigned=“true” from metadata. 
    * Save metadata
* Create Trust Relationship: 
  * Display Name: Anything, whichever is easier for you to recognize this trust relationship. 
  * Description: Anything, whichever is easier for you to recognize this trust relationship
  * Metadata Type: File 
  * Upload salesforce's metadata ( your modified one )
  * Releases attributes: TransientID and Email
  * 'Add' this trust
  * Configure Specific Relying: It can be done from Gluu Server's GUI ( named: oxTrust )
    * Select 'SAML2SSO'
        * includeAttributeStatement: Enabled
        * assertionLifetime: keep the default one
        * assertionProxyCount: keep the default one
        * signResponses: conditional
        * signAssertions: never
        * signRequests: conditional
        * encryptAssertions: never
        * encryptNameIds: never
        * Save it
  * 'Update' the trust relationship
  * Here is how it looks like for our test setup: 
  ![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/salesforce/Gluu_Server.png)
  
  
## Test SSO

* Go back to Salesforce.com setup
* Security Controls –> Single Sign On Settings
* Enable 'Federated Single Sign-On Using SAML' 
* Go to 'Domain Management'
* Configure 'Authentication Configuration'
  * Select 'Gluu Server' 
  * Save it
  * Here is how 'Authentication Configuration' looks like: 
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/salesforce/Authentication_Configuration.png)
* This is SP-initiate SSO. So hit your Salesforce website link to initiate the SSO. 
* [Here](https://www.youtube.com/watch?v=VehuRJr647E&feature=youtu.be) is video link of this SSO. 





