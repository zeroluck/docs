# Using SAML to get SSO with Google Apps


Google Apps will work as Service Provide ( SP ) and we need to "introduce" Gluu Server with Google Apps as Gluu Server can work as Identity Provider ( IDP ).

NOTE: It's highly recommended to use Google staging apps setup before Google
production migration. If you have any question or confusion, please feel free to
let us know.

We need to configure both parties ( Google Apps and Gluu Server ) as they can talk to each other.

## Configuring Google Apps with Google dashboard:

* Login to dashboard.

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/GoogleAppSSO/dashboard.png?raw=true)

* Click "Security" tab.

* Got to "Advanced Settings" and select "Set up single sign-on(SSO)" feature. 
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/GoogleAppSSO/advanced_setting.png?raw=true)

    * Sign-in Page URL: https://idp_hostname/profile/SAML2/Redirect/SSO

    * Sign-out Page URL: https://idp_hostname/idp/logout.jsp

    * Change Password URL: Organization should provide this link if they have any link for end users.

    * Verification certificate: Update your IDP's ( Gluu Server ) SAML cert

        * How to get the SAML cert of your Gluu Server? [Here](https://support.gluu.org/view/installation/certificates-in-idp/275) it is. 

    * Use a domain specific issuer: Check it.

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/GoogleAppSSO/sso_setting.png?raw=true)


If you want to know more about Google SSO. [This](https://support.google.com/a/answer/60224?hl=en) might help you. 

## Configuration in Gluu Server:

Now we need to create a Trust Relationship in Gluu Server as IDP can start its
SAML transaction with SP ( in this case: Google Apps ). 

In order to create a Trust Relationship, we need to grab the metadata of Google
Apps. This metadata can be collected from Google. It's generally specific to
organization account. 

Got the metadata? Great, we are ready to move forward. 

* Create Trust Relationship for Google Apps: 

    * How to create a trust relationship can be found [here](http://www.gluu.org/docs/admin-guide/oxTrust/saml/). We need to follow the "File" method for Google Apps trust relationship. 
    * Required attributes: Generally a nameID attributes is required. Please talk to us to generate this nameID in your Gluu Server. 
    * Relying Party Configuration: Yes, SAML2SSO should be configured. 
        * includeAttributeStatement: check
        * assertionLifetime: default 
        * assertionProxyCount: default
        * signResponses: conditional
        * signAssertions: never
        * signRequests: conditional
        * encryptAssertions: never
        * encryptNameIds: never 




