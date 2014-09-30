# How to calculate and release new attribute in oxTrust 

There are two types of attributes. 1. Standard LDAP attributes 2. Custom
attributes by Organization. Procedure is little bit different for these two
types of attribute which are stated below.

## Standard LDAP attributes

Go to Configuration → Attributes, click on “Show all attributes”. These are
standard LDAP attributes which are already configured in our Gluu Server. If our
desired attribute is in this list, we do not need to “create” it then but we
just need to calculate and map in Gluu Server.

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/Attribute_mapping/standard_attribute.png?raw=true)

### How to calculate a new attribute
Let's say we need to release “Description” for every user. Our first job is to check if this
“Description” attribute is in Gluu Server list or not. As we can see, it is
there. So, let's move for calculation.

* Search for “description” in customer's backend. We need to know how customer is releasing this attribute in their Active Directory / LDAP server. Let's say they are releasing this attribute as “ABCdEsCription=Director of Engineering”. We need to map this “ABCdEsCription” attribute to “Description” of Gluu server.

### How to map a new attribute:

* Go to “Configuration” → “Cache Refresh”
* Maximize “Customer Backend key/attributes”
    * “Source attribute”
        * Add the value of customer backend's attribute which will supply value for our new custom attribute.
            ![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/Attribute_mapping/source_attribute.png?raw=true)
        * Scroll down to “Attribute Mapping”
        * Click on “Add source attribute to destination attribute mapping”
        * Left side box should include customer AD's information and right side box should include Gluu Server's attribute name just like below. 
            ![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/Attribute_mapping/map_attribute_description.png?raw=true)
        * Click on “Update” and wait for Cache Refresh to populate this value inside Gluu server.
* How to check status
Search for any user with “uid” in Gluu Server and if “Description” is available for this user, mapping is done.
