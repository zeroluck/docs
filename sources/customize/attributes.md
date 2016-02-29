[TOC]
# Custom Attributes

LDAP attributes, SAML attributes, OpenID Connect user claims--whatever
you call them--many organizations have business-specific information
about people that needs to be shared with applications. For simplicity,
this article will refer to them as "attributes." Existing standard
schemes like the LDAP `inetOrgPerson` standard, or the OpenID Connect
`id_token` user claims define attributes like first name, last name and
email address. Where possible, we recommend you use these. But what if
there is an attribute that is just not in any standard schema? This
article will explain what you need to do to configure the Gluu Server to
support your new attributes, and give you some advice along the way with
regard to best practices. We will use fictional Company Acme Inc., which
has requirements for "acmeCustNumber" and "acmeStateLicenseNumber".

## Using oxTust
Additional attributes can be added from the Gluu Server GUI, oxTrust, by
clicking the **Add Attribute** button. Then, the following screen will
appear:

![Add Attribute Screen](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/admin_attribute_add.png)

* _Name:_ This field defines the name of the custom attribute which must
  be unique in the Gluu Server LDAP tree.

* _SAML1 URI:_ This field contains the SAML1 uri for the custom attribute.

* _SAML2 URI:_ This field contains the SAML2 uri for the custom attribute.

* _Display Name:_ This display name can be anything that is human readable.

* _Type:_ The attribute type should be selected from the drop-down menu.
  There are four attribute types supported by Gluu:
  1. Text
  2. Numeric
  3. Photo
  4. Date

* _Edit Type:_ This field defines the user who has access to edit the
  specific attributes.

* _View Type:_ This field defines the user who can view this attribute.

* _Privacy Level:_ Please select the desired privacy level from the
  drop-down menu. The privacy level has a specific range of 1 to 5.

* _Multivalued:_ Please select multivalue in this field if the attribute
  contains more than one value.

* _SCIM Attributes:_ If the attribute is a part of SCIM architecture select true.

* _Description:_ This contains a few words to describe the attribute.

* _Status:_ The status, when selected active, will release and publish
  the attribute in IdP.


## Using LDAP Command

The Gluu Server needs to know which attributes are available. Each
attribute that you want to make available must have a corresponding LDAP
entry under `ou=attributes,o=<org-inum>,o=gluu`. If you browse your LDAP
server after performing a Gluu Server base installation, you will see
that many commonly used attributes are already there. When an LDAP entry
exists for your attribute, it is considered to be "registered".

There are two ways you can register an attribute. If you are an LDAP
geek, you can just create an LDIF file with the correct information, and
load it in the LDAP server that is storing your configuration. If you
want to quickly spool up new Gluu Servers, this is probably the quickest
way to handle it.

    dn: inum=@!1111!0005!2B29,ou=attributes,o=@!1111,o=gluu
    objectClass: top
    objectClass: gluuAttribute
    inum: @!1111!0005!2B29
    description: How a person would want their name to be presented in writing.
    displayName: Display Name
    urn: urn:mace:dir:attribute-def:displayName
    gluuAttributeName: displayName
    gluuAttributeOrigin: gluuPerson
    gluuAttributeType: string
    gluuStatus: active
    gluuAttributeEditType: user
    gluuAttributeEditType: admin
    gluuAttributeViewType: user
    gluuAttributeViewType: admin

If you just have a couple of attributes, you can also use the oxTrust
Web interface to add the attributes. See the screenshot below, and refer
to the oxTrust
[documentation](http://www.gluu.org/docs/admin-guide/configuration/#attributes)
for an explanation of all these fields.

# OpenID Scopes

In SAML, attributes are released directly to websites, so there is not
much you need to do. In OpenID Connect, there is a little more
complexity. OpenID Connect defines scopes, which let you group
attributes together, and to provide a human understandable description
of the attributes. This improves usability when you need to prompt a
person to approve the disclosure of attributes to a third party. For
example, instead of asking the user if its ok to release her address,
city, state, and country, and providing a description of each attribute,
it may be easier to ask the person if its ok to release "mailing address
information." In situations where the attributes may confuse the person,
OpenID Scopes are a really good thing.

An example of the default Gluu Server authorization request can be seen
here:

![OpenID Connect Scope Authorization Screenshot](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/openid_connect/authz_screenshot.png)

So if you have custom attributes, you may need to define a custom OpenID Scope.
This is pretty easy to do using the oxTrust user interface, and you can just
select the attributes that you previously registered.

What attributes to put in what scopes depends on your privacy requirements.
If there is an attribute that is particularly sensitive, it may need its own
scope (i.e. a scope with just one attribute). A good example of this is
'dateOfBirth.' For minors, this can be sensitive information, and your
organization may need more control about which OpenID Connect clients with
which to share this scope.

In oxTrust configuration, be careful about making a scope available by
default. This would mean that any client that registers via Dynamic Client
Registration could request this scope. The OpenID Connect specification only
requires the release of the `openid` scope, which should just contain the
person identifier in the domain (i.e. for Google, this would be your Google id).
However, rules were meant to be broken, so if you have a reason to release
a scope by default, go for it!

## oxAuth Discovery configuration

Discovery enables clients to discover which attributes are available at an
OpenID Provider. Ideally, this would be controlled also from oxTrust and this
information would be persisted in the attribute LDAP data. But 
in the meantime, this is controlled by oxauth.xml. So if you want to publish 
that a claim is available, you'll need to update this section:

    <claims-supported>
        <claim>uid</claim>
        <claim>givenName</claim>
        <claim>sn</claim>
        <claim>displayName</claim>
        <claim>mail</claim>
    </claims-supported>

