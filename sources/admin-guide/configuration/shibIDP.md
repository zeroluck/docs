# Gluu Server - Shibboleth IDP

## Introduction

Gluu Server is the combination of OpenID Connect and SAML. This chapter is
basically coverinig the SAML section of Gluu Server.  Gluu Server's SAML section is tightly integrated with [Shibboleth](https://shibboleth.net/). 

## LDAP Attributes

Gluu server released all standard attributes. The administrator of Gluu Server
is able to see all attributes from Web UI Configuration. 

Other than standard attribute, Gluu Server allows administrator to create and
map any custom attributes in ldap. Gluu Server GUI has such feature.

An “Active” attribute list can be seen from the Configuration → Attributes section. 
The Gluu Server has a large ldap tree which includes all standard attributes. Not all are necessarily “Active”. Active Attributes can be sorted by clicking “Show only Active Attributes.”

After clicking an attribute, the server Administrator can make edits as needed,
such as changing an attribute from Inactive to Active, as shown below.

* IMAGE

If the organization needs more attributes or has custom attributes, they can be added from the Gluu Server GUI. Click on “Add attribute” and a page like this will appear:

* IMAGE

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

## Log Viewer

Gluu Server administrator can view / trace any log from system with Gluu
Server's "Log Viewer" feature. 

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
    * There are basically three types of certificates here in Gluu Server. 
        * Apache SSL certificate: 
             

* How can I get the IDP's SAML cert? 
    * 


