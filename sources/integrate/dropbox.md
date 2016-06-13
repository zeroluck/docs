# Dropbox SSO with Gluu Server
This documents a step-by-step guide to setting up Dropbox SSO in Gluu Server.
This SSO requires settuing a custom `nameid` called `emailnid`.

### Custom NameID
Please see [this doc](../customize/attributes.md) on how to create custom attributes.

The new attribute screen should look like the screenshot below
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/emailnid.png)

The custom `nameid` needs to be defined in the `attribute-resolver` template file.

* Please edit the `attribute-resolver.xml.vm` file  under the `/opt/tomcat/conf/shibboleth2/idp` folder

* Add the `$attribute.name.equals('emailnid')` with the existing *#if( ! ($attribute.name.equals('transientId')* to look like the snippet below

```
#if( ! ($attribute.name.equals('transientId') or $attribute.name.equals('emailnid') ) ) 
```

* Add `nameid` definition 

```
 <resolver:AttributeDefinition id="emailnid"
                                xsi:type="Simple"
                                xmlns="urn:mace:shibboleth:2.0:resolver:ad"
                                sourceAttributeID="mail">
                        <resolver:Dependency ref="siteLDAP" />
                        <resolver:AttributeEncoder xsi:type="SAML2StringNameID"
                                xmlns="urn:mace:shibboleth:2.0:attribute:encoder"
                                nameFormat="urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress" />
</resolver:AttributeDefinition> 
```
* Add `emailAddress` in Principal Connector

```
 <resolver:PrincipalConnector xsi:type="pc:Transient" id="saml2Transient" nameIDFormat="urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress" /> 
```

* Restart Tomcat Server

### Trust Relationship
Please see [this doc](../integrate/outbound-saml.md) to create trust relationship and fill up the form with the following info

1. Display Name: Dropbox
2. Description: External SP / File method
3. Metadata Type: File
4. SP Metadata File: Upload the 'dropbox_metadata.xml' which you just created
5. Configure Specific RelyiningParty: Yes

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/rp_configuration)

```
signResponses: conditional
signAssertions: never
signRequests: conditional
encryptAssertions: never
encryptNameIds: never
```
6. Released attribute: emailnid
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/dropboxtr.png)

### Configure Gluu Server as IdP in Dropbox

1. Log into Dropbox
2. Click on `Admin Console`
3. Click `Authentication`
4. Click on the checkbox labeled `Enable single-sign-on`
5. Optional/Required according to necessity

    1. Sign in URL
```
 https://<hostname_of_Gluu_server>/idp/profile/SAML2/Redirect/SSO 
```

    2. X.509 certificate: Get `shibIDP.crt` from Gluu Server `chroot` environment under `/etc/certs/` folder and upload it.

6. Save configuration

### Test SSO
* Please go to https://www.dropbox.com and click on the `Sign In` button

* If the account is configured for SSO, then a screen similar to the screenshot below will appear after entering the email address.
!image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/dblogin.png)

* Click `Continue` and the website will redirect to Gluu Server for authentication.

