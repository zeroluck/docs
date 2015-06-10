**Table of Contents**  

- [Outbound SAML](#outbound-saml)
	- [Metadata of website:](#metadata-of-website)
	- [Required attribute of website:](#required-attribute-of-website)
	- [SSO testing endpoint of website:](#sso-testing-endpoint-of-website)
- [Configuring Outbound SAML SSO](#configuring-outbound-saml-sso)
	- [LDAP Attributes](#ldap-attributes)
	- [SAML Trust Relationship](#saml-trust-relationship)
		- [How to create Trust Relationship](#how-to-create-trust-relationship)
- [FAQ](#faq)

# Outbound SAML

Outbound SAML setup from Gluu Server is pretty easy using the Gluu Server's oxTrust GUI. The following pieces of information are needed from the target website or application:

- [Metadata of website](#metadata-of-website)
- [Required attribute of website](#required-attribute-of-website)
- [SSO testing endpoint of website](#sso-testing-endpoint-of-website)

Above three points are described briefly below. 

## Metadata of website: 

Metadata is a XML file which has configuration data used to provision any
website ( SP ) or IDP ( Gluu Server ) to communicate with each other. It's
interchangeable between IDP and SP. 

Websites ( SP ) can provide metadata via URL or as a standalone separate file.
If SP provide an XML separate file, Gluu Server can check the integrity of that
metadata with it's own mechanism, which can be shown and tested from Gluu Server
oxTrust GUI. 

## Required attribute of website: 

Every organization has their own policy to release / share attributes with any
IDP or SP. Gluu Server support and can be configured for standard or custom
attribute. All can be done from Gluu Server oxTrust GUI. 

## SSO testing endpoint of website: 

Every website ( SP ) should have staging and production URL endpoint which can
be checked for SSO, where user will hit to log into that SP. 

# Configuring Outbound SAML SSO

The Gluu Server's SAML capabilities are tightly integrated with [Shibboleth](https://shibboleth.net/). 

## LDAP Attributes

The Gluu Server releases all standard attributes. The server administrator is able to see attributes from the Web UI Configuration. 

Other than standard attributes, the server administrator can create and map any custom attributes in LDAP from the attributes section in the UI:

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SamlIDPAdminGuide/Base_attributes.png?raw=true)

An “Active” attribute list can be seen from the Configuration → Attributes section. 
The Gluu Server has a large LDAP tree which includes all standard attributes. Not all are necessarily “Active”. Active Attributes can be sorted by clicking “Show only Active Attributes.”

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SamlIDPAdminGuide/LDAP_tree_Gluu_server.png?raw=true)

Organization can manage their required attributes from this big LDAP tree. Just
select the attribute and make it active / inactive in the GUI. 

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SamlIDPAdminGuide/Active_inactive.png?raw=true)

If the organization needs more attributes or has custom attributes, they can be added from within the GUI. Click on “Add attribute” and a page like this will appear:

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SamlIDPAdminGuide/Add_new_attribute.png?raw=true)

* _Name_: Name of this custom attribute. It must be unique in Gluu Server LDAP tree.
* _SAML1 URI_: SAML1 URI value for custom attribute.
* _SAML2 URI_: SAML2 URI value for custom attribute
* _Display Name_: Any name which is human readable.
* _Type_: Attribute type. There are four types supported by Gluu Server: (i) Text (ii) Numeric (iii) Photo and (iv) Date.
* _Edit Type_: User who can edit this attribute definition.
* _View Type_:  User who can view this attribute.
* _Privacy Level_: From 1 to 5. Select the desired one.
* _Multivalued_: Is this attribute has multi values? If yes, True. Otherwise, false. 
* _SCIM Attributes_: Is this attribute in SCIM architecture? True or False.
* _Description_: Little description of this attribute
* _Status_: “Active” will release and publish the attribute in IdP. 
 

## SAML Trust Relationship

A Trust Relationship is the mechanism to create single sign-on to any SAML Service Provider ( SP ) from the Gluu Server SAML IDP. Trust Relationships can be created from within the GUI.  

### How to create Trust Relationship

In order to create a trust relationship with any SP: 

* Go to SAML → Trust Relationships
* Click on “Add Relationship”
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/Add_Relationships.png?raw=true)
* A new page will appear. Here, Gluu Server Administrator needs to provide all informations regarding SP to establish Trust Relationship from Gluu Server. 
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/TR_new_page.png?raw=true)
    * _Display Name_: Name of the Trust Relationship ( it should be unique for every trust relationship ) 
    * _Description_: Little description. Purpose and SSO link can be added here.
    * _Metadata Type_: Depending on trusted party’s metadata (SP), there are four available types in Gluu Server
        * _File_: If SP has uploadable metadata in XML format, this option works best.
        * _URI_: If the metadata of SP has url link and accessible from internet, Gluu Server Administrator need to use this option. 
        * _Generate_: Using Gluu Server to generate configuration files for SP is another big option when the SP is inhouse application or “Shibboleth SP” is installed or going to be installed in target application site (SP).  [How to install Shibboleth SP](http://www.gluu.org/docs/articles/apache-saml/) will help user to configure and install Shibboleth SP on their own area. Please note few things when you are going to use _Generate_ method for your SP. 
            * _URL_ : This is the `hostname of SP`
            * _Public certificate_ : You `must` have to provide the certificate which is Base64 encoded ASCII file and contain "-----BEGIN CERTIFICATE-----" and "-----END CERTIFICATE-----". This certificate `can not be password protected`. 
            * After creating the Trust Relationship, download the generated configuration files from `Download Shibboleth2 configuration files` link and place these configuration files inside your SP configuration. 

        * _Federation_: If target application ( SP ) is affiliated with any Federation server (i.e: InCommon, NJEdge etc. ), this option of “Metadata Type” is required. 
        Select “Federation” in Metadata Type and another drop down menu called “Select Federation” will appear. From this drop menu select desired Federation. 
        In order to create this documentation we took “InCommon” Federation as an example.
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/Federation_1.png?raw=true)

After selecting the “Federation Name”, a new link named “Click to select entity id” will appear. From this link Gluu Server Administrator can select all SP’s entityIDs which are InCommon affiliated. Click on this link and another new SP entityID discovery page will appear like below image. 
        
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/Federation_2.png?raw=true)

Gluu Server Administrator can grab any SP’s entityID from “Filter” box. As for example, Gluu Server Administrator is looking for Educause entityID. 
        
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/Federation_3.png?raw=true)


* Public certifiate: Upload public certificate for this SP server. Please note that: public certificate’s CN (common name) MUST maintain the hostname of the SP server. If the SP has no certificate then keep this option blank and the IdP will generate a self signed certificate.

* Released: Release required attributes. Available attributes can be grabbed from upper left corner. 

* More configuration: If SP requires custom relying party and/or custom MetadataFilter configuration, that can be achieved using the following options: 
* Configure MetadataFilters: Click on this option and Gluu Server will allow you to configure MetadataFilters inside the GUI.
* Configure specific Relying Party: If the server admin “checks” this option a new link will appear which allows the server administrator to modify various relying party configurations like SAML2SSO, SAML2AttributeQuery, ShibbolethSSO etc. 

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/Relying_Party_Configuration.png)

After adding a new Trust Relationship, the server administrator will observe a confirmation page like the one below. Please note that for testing purpose we did not provided any certificates. The IdP created the key and cert by itself. The image below shows a sample Trust Relationship after successful creation.

# FAQ 

* I have a new SP, what do I need to do to create a Trust Relationship from the Gluu Server? 
    * Basically there are two types of single sign-on: IDP-inititate SSO and SP-initiated SSO. You need to know what kind of SSO it is. 
        * For SP-initiated SSO, you need to know: 
            * Required attributes by SP.  
            * Metadata of SP. 
            * SSO endpoint / testing endpoint which end user will use to log
            into SP.   

        * For IDP-initiated SSO, you need to know: 
            * Required attribute by SP. 
            * Metadata of SP ( if possible )
            * SSO endpoint ( if possible )

* Where I can find my IDP's metadata? 
    * Gluu Server IDP metadata is available online at: `https://<yourhostname>/idp/shibboleth`

* What kind of certificates does the Gluu Server use? 
    * [Certificates](../certificates/index.md) in Gluu Server             

* How can I get the IDP's SAML cert? 
    * SAML certificate is available in your IDP's metadata. Metadata can be collected by following these [instructions](https://support.gluu.org/questions/36/idp-certificate-entityid-location-http-redirect-location-etc/). 


* I need to update metadata for one Service Provider. How is it possible? 
    * This is pretty easy. Just follow the instructions listed [here](https://support.gluu.org/view/maintenance/update-metadata-for-service-provider/1446). 
