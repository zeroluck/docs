# Configuring Single Sign-On with Hobsons Education Solutions Company (including IdP-initiated SSO scenario)

## Metadta Exchange

Hobsons' metadata can be fetched from [https://services01.askadmissions.net/shibboleth/sp](here), but it may be best to ask them to provide it in order to ensure it's current and correct.

Your metadata can be found at: `https://idp.yourdomain.com/idp/shibboleth` 

## Local IDP Configuration

Lets create a new SAML Trust Relationship by navigating to the SAML interface within your Gluu Server:

1. Display Name: “Test Hobsons-Radius TR”
2. Description: ….
3. Metadata Type: URI or file, depending on what was provided by your organization or a Hobsons representative.
4. Logout URL: nothing, until you were provided one by their staff, or you found out they now support SAML Single Logout profile (from their metadata, docs etc)
5. Released Attributes:
  a. TransientID
  b. EduPersonPrincipalName
6. “Enable InCommon R&S”: Unchecked
7. Click “Add” button

Make sure your new trust relationship is in an active state. Its state is shown in the list of Trust Relationships, you also can tell by the fact that “Deactivate” button is shown instead of the “Activate” button. 

Now open new trust relationship's properties again, to complete the configuration:

1. “Configure Metadata Filters”: No changes
2. “Configure specific RelyingParty”: Checked
3. Click on the appeared “Configure RelyingParty” link
  a. In the pop-up window add “SAML2SSO” profile to the list of profiles to be customized; corresponding UI section will be added below
  b. Check “includeAttributeStatement”, set “assertionLifetime” to 300000, “assertionProxyCount” to 0 (which are defaults)
  c. Make sure “signResponses”, “signAssertions” and “signRequests” at least set to “conditional” (it will fail otherwise; in case of any issues check SAML responses being sent to Hobsons to make sure assertions and response itself are indeed receive signatures; try to change these settings to “always” if for some reason they don't)
  d. Set “encryptAssertions” to “conditional”
  e. Set “encryptNameIds” to “never”
  f. Click “Save” button to close pop-up
4. Click “Update” button

## Preparing for IDP-initated SSO
No preparations are needed for Shibboleth component used by Gluu at the time of the writing, as all required features were active out of the box. A brief description of how this use case is implemented in Shibboleth 2 can be found [here](https://wiki.shibboleth.net/confluence/display/SHIB2/IdPUnsolicitedSSO) (They call it “IdP Unsolicited SSO”). While troubleshooting, pay particular attention to profile handler of type `SAML2SSO` defined in `/opt/idp/conf/handler.xml`, with `RequestPath` set to `/SAML2/Unsolicited/SSO`, it should be present and uncommented; or look for the endpoint's url containing `/idp/profile/SAML2/Unsolicited/SSO` in its path in the IDP's metadata.

## Testing the Configuration
Hobsons' staging area can be reached via a unique url, such as: `https://example-staging.hobsonsradius.com` or `https://example.hobsonsradius.com`. Before conducting any tests, get confirmation from Hobsons that they have updated the metadata on their side and a test account for SSO login should be acquired.

## IDP-initatied SSO
To test thisyou can use a url like this (you can change the value of `target=` parameter to any other meaningful location, for example, their production area; the value of `providerID=` parameter should be the value of `entityID` element from Hobsons' metadata): `https://idp.example.edu/idp/profile/SAML2/Unsolicited/SSO?providerId=https://services01.askadmissions.net/shibboleth/sp&target=https://example.hobsonsradius.com`

## SP-initated SSO
It seems there is no special need to use IdP-initiated scenario, as Hobsons' systems also support SP-initiated SSO. It can be triggered by simply following the link to the staging area. 
