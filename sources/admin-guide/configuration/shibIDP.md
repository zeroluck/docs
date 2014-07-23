# Gluu Server - Shibboleth IDP

## Introduction

Gluu Server is the combination of OpenID Connect and SAML. This chapter is
basically coverinig the SAML section of Gluu Server.  Gluu Server's SAML section is tightly integrated with [Shibboleth](https://shibboleth.net/). 

## LDAP Attributes

Gluu server released all standard attributes. The administrator of Gluu Server
is able to see all attributes from Web UI Configuration. 

Other than standard attribute, Gluu Server allows administrator to create and
map any custom attributes in ldap. Gluu Server GUI has such feature.

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SamlIDPAdminGuide/Base_attributes.png?raw=true)

An “Active” attribute list can be seen from the Configuration → Attributes section. 
The Gluu Server has a large ldap tree which includes all standard attributes. Not all are necessarily “Active”. Active Attributes can be sorted by clicking “Show only Active Attributes.”

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SamlIDPAdminGuide/LDAP_tree_Gluu_server.png?raw=true)

Organization can manage their required attribute from this big LDAP tree. Just
select the attribute and make that active / inactive from Gluu Server oxTrust GUI. 


![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SamlIDPAdminGuide/Active_inactive.png?raw=true)

If the organization needs more attributes or has custom attributes, they can be added from the Gluu Server GUI. Click on “Add attribute” and a page like this will appear:

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

Trust Relationship is the mechanism to create bridge between any Service
Provider ( SP ) and Gluu Server SAML IDP. 
Trust Relationships can be created by Gluu Server administrator from Gluu Server
GUI ( as known as: Gluu oxTrust ).  

### How to create Trust Relationship

In order to create a trust relationship with any SP: 

* Go to SAML → Trust Relationships
* Click on “Add Relationship”
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/Add_Relationships.png?raw=true)
* A new page will appear. Here, Gluu Server Administrator need to provide all informations regarding SP to establish Trust Relationship from Gluu Server. 
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/TR_new_page.png?raw=true)
    * _Display Name_: Name of the Trust Relationship ( it should be unique for every trust relationship ) 
    * _Description_: Little description. Purpose and SSO link can be added here.
    * _Metadata Type_: Depending on trusted party’s metadata (SP), there are four available types in Gluu Server
        * _File_: If SP has uploadable metadata in XML format, this option works best.
        * _URI_: If the metadata of SP has url link and accessible from internet, Gluu Server Administrator need to use this option. 
        * _Generate_: Using Gluu Server to generate configuration files for SP is another big option when the SP is inhouse application or “Shibboleth SP” is installed or going to be installed in target application site (SP).  [How to install Shibboleth SP](http://www.gluu.org/docs/articles/apache-saml/) will help user to  configure and install Shibboleth SP on their own area.

        * _Federation_: If target application ( SP ) is affiliated with any Federation server (i.e: InCommon, NJEdge etc. ), this option of “Metadata Type” is required. 
        Select “Federation” in Metadata Type and another drop down menu called “Select Federation” will appear. From this drop menu select desired Federation. 
        In order to create this documentation we took “InCommon” Federation as an example.


    * Public certifiate: Upload public certificate for this SP server. Please note that: public certificate’s CN (common name) MUST HAVE TO maintain the hostname of the SP server. If SP has no certificate then keep this option blank and IdP will generate a self signed certificate for SP.

    * Released: Release required attributes. Available attributes can be grabbed from upper left corner. 

    * More configuration: If SP require custom relying party and/or custom MetadataFilter configuration, that can be achieved from options named: 
        * Configure MetadataFilters: Click on this option and Gluu Server will allow you to configure MetadataFilters with Gluu Server own oxTrust GUI.
        * IMAGE
        * Configure specific Relying Party: If Gluu Server administrator “check” this option A new link will appear which allows Gluu Server Administrator to modify various Relying party configurations like SAML2SSO, SAML2AttributeQuery, ShibbolethSSO etc through “Click and Play” way. 

After addition of this new Trust Relationship, Gluu Server Administrator will
observe a confirmation page like below. Please note that, for testing purpose we
did not provided any certificate and IdP created those key and cert by itself.
Message is indicating such operation. Below image is showing a sample Trust
Relation after a successful creation.


## Log Viewer

Gluu Server administrator can view / trace any log from system with Gluu
Server's "Log Viewer" feature.  Any log can be displayed from Web UI with few clicks. To enable this feature click on “Configuration” → “Configure log viewer”

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/LogViewer/Click_log_viewer.png?raw=true)

Click on “Add log template”, two new boxes will appear. Left box is the name/description of the log and right box require the real path of this log file. As for example in the below image,  we are going to configure two logs: 1. oxTrust log and 2. oxAuth log

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/LogViewer/Log_template.png?raw=true)

Log files which were configured in previous section can be viewed with this “View log file” feature. Click “Configuration” → “View Log File”

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/LogViewer/View_Log_file.png?raw=true)

Now, select / click on desired allowed log file and insert a value for “Display last lines count”. Gluu Server will show last 400 ( or, any selected value lines ) in GUI like below:

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/LogViewer/Final_log_viewer.png?raw=true)


## FAQ 

* I have a new SP, what I need to do to create a Trust Relationship from Gluu Server SAML IDP? 
    * Different type of SPs allowed different types of SSO. Basically there are
two types of SPs. IDP-inititate SSO and SP-initiated SSO. You need to know what
kind of SSO it is. 
        * For SP-initiated SSO, you need to know: 
            * Required attributes by SP.  
            * Metadata of SP. 
            * SSO endpoint / testing endpoint which end user will use to log
            into SP.   

        * For IDP-initiated SSO, you need to know: 
            * Required attribute by SP. 
            * Metadata of SP ( if possible )
            * SSO endpoint ( if possible )

* From where I can get the metadata of IDP? 
    * Gluu Server IDP metadata is available online with the link: `https://<hostname>/idp/shibboleth`

* Can you please tell me what kind of certificates Gluu Server using? 
    * [Certificates](http://www.gluu.org/docs/admin-guide/certificates/) in Gluu Server             

* How can I get the IDP's SAML cert? 
    * SAML certificate is available in your IDP's metadata. Metadata can be collected in [this](https://support.gluu.org/questions/36/idp-certificate-entityid-location-http-redirect-location-etc/) way. 


