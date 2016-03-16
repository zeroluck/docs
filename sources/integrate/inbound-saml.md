**Table of Contents** 

- [Inbound SAML in Gluu Server](#inbound-saml-in-gluu-server)
- [Requirements for Inbound SAML](#requirements-for-inbound-saml)
	- [Metadata of Authentication Server](#metadata-of-authentication-server)
	- [Metadata of Service Provider](#metadata-of-service-provider)
	- [SAML Certificate of Service Provider](#saml-certificate-of-service-provider)
	- [SSL Certificate of Authentication Server](#ssl-certificate-of-authentication-server)
	- [Required Attributes](#required-attributes)
- [Asimba Configuration](#asimba-configuration)
	- [Base Installation of Asimba Package](#base-installation-of-asimba-package)
	- [Asimba Apache Configuration](#asimba-apache-configuration)
	- [Test Asimba Setup](#test-asimba-setup)
- [Add New Service Provider or Identity Provider](#add-new-service-provider-or-identity-provider)
- [Configure Asimba SAML Proxy](#configure-asimba-saml-proxy)
        - [Base SAML Proxy Installation](#base-installation)
	- [SAML Proxy Apache Configuration](#saml-proxy-apache-configuration)
- [Add New Identity Provider](#add-new-identity-provider)
	- [Required Files](#required-files)
	- [Configure asimba.xml:](#configure-asimba.xml)
	- [Work on IdP Keystore:](#work-on-idp-keystore)
	- [IdP Restart Tomcat](#idp-restart-tomcat)
- [Add New Service Provider](#add-new-service-provider)
	- [Configure asimba.xml:](#configure-asimba.xml)
	- [Work on SP Keystore](#work-on-sp-keystore)
	- [SP Restart Tomcat](#sp-restart-tomcat)
- [Configure SP](#configure-sp)
	- [Configure Remote IdP](#configure-remote-idp)
- [How to Test](#how-to-test)


# Inbound SAML in Gluu Server

The main use case for Asimba is to enable websites to use a single IdP
for single sign-on (SSO) even when the organization may have a number of
IdPs that are trusted. For more information, please review the [Asimba
website](http://www.asimba.org/site/).

# Requirements for Inbound SAML 

* [Metadata of Authentication Server](#metadata-of-authentication-server)
* [Metadata of Service Provider](#metadata-of-service-provider)
* [SAML Certificate of Service Provider](#saml-certificate-of-service-provider)
* [SSL Certificate of Authentication Server](#ssl-certificate-of-authentication-server) 
* [Required Attributes](#required-attributes)

Above points are described below, briefly. 

## Metadata of Authentication Server

An authentication server can be any remote/native SAML IdP such as the
Shibboleth IdP or Microsoft ADFS. You need the metadata of this server
to configure Asimba. After configuration, the end user will be able to
select their desired authentication server from Asimba's discovery page.
As an alternative, you can configure the "selector" which will
automatically redirect a user to the desired IdP/ADFS.

## Metadata of Service Provider

Just like the authentication server metadata, you will also need
metadata from all websites (SPs) which will be connected.

## SAML Certificate of Service Provider

Base64 encoded certificates are required to configure the Asimba trust
store to connect/allow the inbound SAML request from the remote SP.

## SSL Certificate of Authentication Server

Base64 encoded certificates for the authentication server are also
required:

## Required Attributes

Every organization has their own policy to both release and pass
attributes to service providers. It can be a standard attribute like
UID, or an email address. In general, it can be any custom attribute.

# Asimba Configuration 

## Base Installation of Asimba Package

* Get the war for Asimba from [http://asimba.org](http://asimba.org)
* Copy the war file in `/opt/tomcat/webapps`
* Restart the Tomcat service. It will extract the Asimba, automatically.
* Get the `asimba.conf` template from Gluu
* Generate the keystore for your Asimba server:
    * Command: `keytool -genkeypair -keyalg RSA -alias "<ALIAS_OF_KEYSTORE>" -keypass <PASSWORD> -keystore <NAME_OF_JKS>.jks -storepass <PASSWORD>`
        * What is your first and last name?: Provide the hostname of Asimba server
        * What is the name of your organizational unit?: IT
        * What is the name of your organization?: Provide name
        * What is the name of your City or Locality?: city name
        * What is the name of your State or Province?: State name
        * What is the two-letter country code for this unit?: US
* Adding IdP/ADFS in Asimba: 
    * Gather metadata of IdP/ADFS and keep them in some place under
      `/tomcat/webapps/asimba-saml-proxy/WEB-INF/`.
    * Collect the certificate of the IdP/ADFS, and import them in Asimba
      truststore JKS.

* Adding SP in Asimba: 
    * Gather the metadata of the SP and keep them in some place under
      `/tomcat/webapps/asimba-saml-proxy/WEB-INF/`.
    * Collect certificate of the SP and import them in Asimba truststore
      JKS.

* Restart the Tomcat service.

## Asimba Apache Configuration

* Configure `idp.conf`: 

```
<Location /asimba-saml-proxy>
	ProxyPass ajp://<ASIMBA_HOSTNAME>:8009/asimba-saml-proxy retry=5 disablereuse=On
	ProxyPassReverse ajp://<ASIMBA_HOSTNAME>:8009/asimba-saml-proxy

	Order allow,deny
	Allow from all
</Location>
```

* Restart httpd

## Test Asimba Setup

* Download the metadata of the Asimba server using `wget -c
  https://<HOSTNAME>/asimba-saml-proxy/profiles/saml2`.

# Add New Service Provider or Identity Provider

All our configurations are based on one Asimba configuration file named
`asimba.xml`. It's also possible to configure Asimba with JDBC. For more
info have a look at the [Asimba
wiki](http://sourceforge.net/p/asimba/wiki/Home/).

* Required tools
    * Metadata of remote IdP
    * SAML certificate of remote IdP

* Configuring `asimba.xml`:
    * Grab the metadata of the remote IdP and save it in some place.
      Make sure that user `tomcat` can read this xml copy.
        * Specify this metadata in the `<websso>\<method>\<idps>` section.
            * `idp id` must follow the entityID of this metadata.
            * `scoping` should be "false"
            * Add the static path of metadata inside the `<file>` section.

A sample configuration looks like that:

```
<idp id="https://idp.gluu.org/idp/shibboleth" friendlyname="Gluu IDP" scoping="false" avoid_subjectconfirmation="false">
	<nameidpolicy enabled="false" />
	<metadata>
		<file>${webapp.root}/WEB-INF/metadata/idp/idp_gluu_org.xml</file>
	</metadata>
</idp>
```

# Configure Asimba SAML Proxy

* Collect the metadata of IdP/ADFS which will be connected with your Asimba Server.
* Collect the SAML certificate of that IdP/ADFS server which will be
  connected with Asimba Proxy Server.
    * The certificate has to be a base64-encoded ASCII file which
      contains the two lines `-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----`.
    * The certificate cannot be password protected.
* Collect the metadata of SP which will be connected with Asimba SAML Proxy.
* Collect the SAML certificate of SP.
    * The certificate has to be a base64 encoded ASCII files which
      contains the two lines `-----BEGIN CERTIFICATE-----` and `-----END CERTIFICATE-----`.
    * The certificate cannot be password protected.

## Base SAML Proxy Installation

* Get Asimba from the [Asimba repository](http://sourceforge.net/projects/asimba/files/release/).
* Send the war file in `~/tomcat/webapps/`.
* Restart the Tomcat service. It will extract the Asimba files, automatically.
* Generate the keystore for your SAML Proxy Server:
    * Command: `keytool -genkeypair -keyalg RSA -alias "<ALIAS_OF_KEYSTORE>" -keypass <PASSWORD> -keystore <NAME_OF_JKS>.jks -storepass <PASSWORD>`
        * What is your first and last name?: Provide the hostname of Asimba server
        * What is the name of your organizational unit?: IT
        * What is the name of your organization?: Provide name
        * What is the name of your City or Locality?: city name
        * What is the name of your State or Province?: State name
        * What is the two-letter country code for this unit?: US

## SAML Proxy Apache Configuration

Configure `idp.conf`: 

```
<Location /asimba-saml-proxy>
	ProxyPass ajp://<ASIMBA_HOSTNAME>:8009/asimba-saml-proxy retry=5 disablereuse=On
	ProxyPassReverse ajp://<ASIMBA_HOSTNAME>:8009/asimba-saml-proxy

	Order allow,deny
	Allow from all
</Location>
```

# Add New Identity Provider (with oxTrust GUI)

oxTrust Asimba Adminstration GUI stores the configuration in LDAP. Gluu-Asumba loads both LDAP and XML configurations, so you free to choose where to add new a new configuration item.

## Required Files

* Metadata file or metadata URL of remote IdP
* SAML certificate of remote IdP

## Configure SAML > Asimba > Add IDP form

A sample configuration looks like that:
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/asimba-idp_add.png?raw=true)

## Work on IdP Keystore: 

* Import the SAML certificate of IdP into Asimba's JKS
    * Convert certificate into DER format
    * Import this DER formatted certificate into Asimba's keystore
    * Please note that it's a good practice to follow the IdP's `entityID` as `alias` of this certificate.

Sample command would be: 

        keytool -import -trustcacerts -alias https://idp.gluu.org/idp/shibboleth \ 
            -file idp_gluu_org.der -keystore asimba-keystore.jks

** - SAML certificate import will be added to GUI form in the next version of oxTrust. 

## IdP Restart Tomcat 
If everything was done correctly, the new IdP is configured with Asimba

# Add New Identity Provider (with asimba.xml configuration file)

All our XML configurations are based on one Asimba configuration file named
`asimba.xml`. It's also possible to configure Asimba with JDBC. For more
info view the Asimba [wiki](http://sourceforge.net/p/asimba/wiki/Home/).

## Required Files

* Metadata file or metadata URL of remote IdP
* SAML certificate of remote IdP

## Configure `asimba.xml`:

* Grab the metadata of the remote IdP, and save it in some place. Make
  sure that the user `tomcat` can read this xml copy.
    * Specify this metadata in the `<websso>\<method>\<idps>` section.
        * The `idp id` has to follow the entityID of this metadata.
        * The `scoping` should be "false".
        * Add the static path of metadata inside the `<file>` section.

A sample configuration looks like that:

```
<idp id="https://idp.gluu.org/idp/shibboleth" friendlyname="Gluu IDP" scoping="false" avoid_subjectconfirmation="false">
	<nameidpolicy enabled="false" />
	<metadata>
		<file>${webapp.root}/WEB-INF/metadata/idp/idp_gluu_org.xml</file>
	</metadata>
</idp>
```

## Work on IdP Keystore: 

* Import the SAML certificate of IdP into Asimba's JKS
    * Convert certificate into DER format
    * Import this DER formatted certificate into Asimba's keystore
    * Please note that it's a good practice to follow the IdP's `entityID` as `alias` of this certificate.

Sample command would be: 

        keytool -import -trustcacerts -alias https://idp.gluu.org/idp/shibboleth \ 
            -file idp_gluu_org.der -keystore asimba-keystore.jks
    
## IdP Restart Tomcat 
If everything was done correctly, the new IdP is configured with Asimba

# Add New Service Provider (with oxTrust GUI)

The required Files are:

* Metadata file or metadata URL of SP
* SAML certificate of SP

## Configure SAML > Asimba > Add SP RequestorPool form
You should use the default RequestorPool or create a new one. The primary goal of separated RequestorPool is customization of attribute mapping, authorization process, etc.

Default RequestorPool already configured in oxTrust:
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/asimba-sp_list.png?raw=true)

## Configure SAML > Asimba > Add SP Requestor form

A sample configuration looks like that:
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/asimba-sprp_add.png?raw=true)

## Work on SP Keystore

* Import the SAML certificate of the SP into Asimba's JKS.
    * Convert the certificate into DER format.
    * Import this DER formatted certificate into Asimba's keystore.
    * Please note that it is a good practice to follow the SP's
      `entityID` as `alias` of this certificate.

A sample command is:

```
keytool -import -trustcacerts -alias https://sptest2.gluu.org/secure \
            -file sp_gluu_org.der -keystore asimba-keystore.jks
```

** - SAML certificate import will be added to GUI form in the next version of oxTrust. 

## SP Restart Tomcat
If everything was done correctly, the SP is now configured in Asimba. 

# Add New Service Provider (with asimba.xml configuration file)

The required Files are:

* Metadata file or metadata URL of SP
* SAML certificate of SP

## Configure `asimba.xml`:

* Collect the metadata of the SP and place them in some location of your
  file system. Make sure that the metadata is in XML format, and readable
  for the user `tomcat`.
* Add Requestor: Every SP is known as `requestor` to Asimba. There are
  couple of places where we need to configure this SP inside Asimba's
  `asimba.xml` file.
    * Requestor should be configured in `<requestorpoolfactory>\<requestors>\<requestor>`.
    * `requestor id` should be the `entityID` of SP.
    * `friendlyname` can be anything which is unique, and reflects the service.

A sample configuration looks like that:

```
<requestor id="http://sptest2.gluu.org/secure" friendlyname="Gluu Test SP" enabled="true" />
```

* Add a profile of the requestor: in this section both the location of
  SP's metadata, and some other configurations are set. 
    * This configuration is configured in `<profiles>\<websso>\<requestors>\<requestor>`.
    * The `requestor id` is the entityID of SP.
    * The `metadata` location is a the absolute path.

A sample configuration of requestor's profile configuration: 

```
<requestor id="http://sptest2.gluu.org/secure" signing="FALSE">
	<metadata>
		<file>${webapp.root}/WEB-INF/metadata/sp/sptest2_gluu_org.xml</file>
	</metadata>
</requestor>
```

## Work on SP Keystore

* Import the SAML certificate of the SP into Asimba's JKS.
    * Convert the certificate into DER format.
    * Import this DER formatted certificate into Asimba's keystore.
    * Please note that it is a good practice to follow the SP's
      `entityID` as `alias` of this certificate.

A sample command is:

```
keytool -import -trustcacerts -alias https://sptest2.gluu.org/secure \
            -file sp_gluu_org.der -keystore asimba-keystore.jks
```

## SP Restart Tomcat
If everything was done correctly, the SP is now configured in Asimba. 

# Configure SP

Now, it is time to configure your SP as it can send the request to the
Asimba server. The primary item to configure the Asimba server in SP's
configuration is `the metadata of Asimba`. You can grab uhis information
with this command:

```
wget -c https://<HOSTNAME>/asimba-saml-proxy/profiles/saml2
```

## Configure Remote IdP

The remote IdP/ADFS also needs to be configured for the Asimba server
so that they can talk to each other.

If the remote authentication server is a Shibboleth IdP, it just
requires three things:

* Metadata of Asimba--which can be grabbed easily.
* Name identifier attribute, which will be shared with Asimba - `persistentID`.
* `SAML2SSO` relying party configuration for this trust relationship with Asimba. Values should be: 
    * _includeAttributeStatement_ : true
    * _assertionLifetime_ : 300000
    * _assertionProxyCount_ : 0
    * _signResponses_ : conditional
    * _signAssertions_ : never
    * _signRequests_ : conditional
    * _encryptAssertions_ : never
    * _encryptNameIds_ : never 

# Add New SP->IDP Selector Rule (with oxTrust GUI)

Configured Selector Rule automatically redirects user's browser to predefined IDP, without view Asimba default IDP selection form.

## Configure SAML > Asimba > Add Selector form

A sample configuration looks like that:
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/asimba-selectors_add.png?raw=true)

# Add New SP->IDP Selector Rule (with asimba-selector.xml configuration file)

Default file location: {Tomcat Directory}/conf/asimba-selector.xml

A sample configuration looks like that:
```
<?xml version="1.0" encoding="UTF-8"?>
<asimba-selector>
	<application entityId="https://ce.gluu.info/secure" organizationId="https://ce.gluu.org/idp/shibboleth" />
</asimba-selector>
```

entityId - SP URL
organizationId - IDP URL

# How to Test

The workflow of the SAML Proxy is:

End user hit the SP --> SP will take user to Asimba's discovery page to
select IDP --> User will select IdP for authentication --> After
successful authentication user will be logged into SP.

The Gluu server has an auto selector mechanism which automatically
redirects the user from the specified SP to the desired IdP for
authentication. If you have questions, please open a ticket on
[support](http://support.gluu.org).

