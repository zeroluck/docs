# Using SAML to get SSO with Google Apps

<pre>

Google Apps will work as Service Provide ( SP ) and we need to "introduce" Gluu Server with Google Apps as Gluu Server can work as Identity Provider ( IDP ).

We need to configure both parties ( Google Apps and Gluu Server ) as they can talk to each other.

From Google Apps ( through it's dashboard ):

Login to dashboard.

Click "Security" tab.

"Advanced Settings" --> Set Up SSO.

3.1 Sign-in Page URL: https://idp_hostname/profile/SAML2/Redirect/SSO

3.2 Sign-out Page URL: https://idp_hostname/logout.jsp

3.3 Change Password URL: Organization should provide this link if they have any link for end users.

3.4 Verification certificate: Update your IDP's ( Gluu Server ) SAML cert

3.4.1 Ref: https://support.gluu.org/questions/36/idp-certificate-entityid-location-http-redirect-location-etc/

3.4.2 Ref: https://support.gluu.org/questions/37/certificates-in-idp/

3.5 Use a domain specific issuer: Check it.

Ref: https://support.google.com/a/answer/60224?hl=en

From Gluu Server ( from Gluu Server's Web UI control centre ):

Create Trust Relationship for Google Apps.

1.1 Ref: http://www.gluu.org/docs/admin-guide/configuration/shibIDP/#saml-trust-relationship

NOTE: It's highly recommended to use Google staging apps setup before Google production migration. If you have any question or confusion, please feel free to let us know.

</pre>

