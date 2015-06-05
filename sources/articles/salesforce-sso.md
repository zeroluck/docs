#SAML integration of Salesforce.com with Gluu Server

By default Salesforce suggest deployers to implement IDP-initiated SSO.
The initialization of IDP-initiated SSO is little complex as it require a big hostname
which includes IDP's SSO link as well as SP's login url. So we prefer
SP-initiated SSO and here in this documentation we are presenting a very simple
SP-initiated SSO steps with Salesforce and Gluu Server. You can still go for IDP-initiated SSO if you prefer, documentation is available in Salesforce.com site. 


## Prepare Salesforce.com


* Log into Salesforce.com with your administrative account. 
* Click on _Setup_ [ right upper corner ] 
* You need to add a custom Domain name for your salesforce site if you don't have any yet. 
  * Go to _Domain Management_ –> _My Domain_ 
  * Add your custom domain 
  * Wait for some time. Salesforce will register this domain name for you. As for example we got something like 'testgluu-dev-ed.my.salesforce.com' for our testing. 
  ![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/salesforce/My_Domain.png) 
  
  
*  Register your 'Gluu Server' information here in Salesforce
   * Go to _Security Controls_ –> _Single Sign On Settings_ 
   * Click _New_ 
  ![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/salesforce/SSO_Settings.png)
   * Now you need to add your Gluu Server's information here
     * _Name_: Anything, whichever is easier for you to recognize this setup. i.e. 'Gluu Server'
     * _API Name_: Gluu Server. 
     * _Issuer_: EntityID of your Gluu Server. i.e. https://test.gluu.org/idp/shibboleth 
     * _EntityID_: Your Salesforce custom domain name. i.e. https://testgluu-dev-ed.my.salesforce.com
     * _Identity Provider Certificate_: Grab your Gluu Server's SAML certificate. SAML certificate can be grabbed from your Gluu Sever's [metadata](https://support.gluu.org/view/application-integration/how-can-i-get-my-idps-metadata/216). Save the certificate and upload it. 
     * _Request Signing Certificate_: Default Certificate
     * _Request Signature Method_: RSA-SHA1
     * _Assertion Decryption Certificate_: Assertion not encrypted. 
     * _SAML Identity Type_: Assertion contains User's salesforce.com username
     * _SAML Identity Location_: Identity is in an Attribute element
     * _Attribute Name_: Provide 'SAML2 URI' of your attribute. For our test case we are using Gluu Server's Email attribute. How to check the information of your attribute is available [here](http://www.gluu.org/docs/admin-guide/configuration/#attributes).
     * _NameID Format_: Keep it blank
     * _Identity Provider Login URL_: https://test.gluu.org/idp/profile/SAML2/Redirect/SSO
     * _Service Provider Initiated Request Binding_: HTTP-Redirect
     * Here is how our final setup looks like: 
     ![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/salesforce/Final_setup.png)
     
     
## Prepare Gluu Server

* How to create SAML trust relationship is available [here](http://www.gluu.org/docs/admin-guide/saml/outbound-saml/#saml-trust-relationship). 
* Grab Salesforce metadata from Salesforce site. There is an option named 'Download Metadata' there. 
  * Modify Salesforce metadata a bit: 
    * Remove _AuthnRequestsSigned=“true”_ from metadata. 
    * Save metadata
* Create Trust Relationship: 
  * _Display Name_: Anything, whichever is easier for you to recognize this trust relationship. 
  * _Description_: Anything, whichever is easier for you to recognize this trust relationship
  * _Metadata Type_: 'File' 
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





