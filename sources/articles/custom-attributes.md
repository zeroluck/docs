# Custom Attributes

LDAP attributes, SAML attributes, OpenID Connect user claims--whatever you call
them--many organizations have business-specific information about people that needs
to be shared with applications. For simplicity, this article will refer to them as
"attributes." Existing standard schemas like the LDAP `inetOrgPerson` standard, or
the OpenID Connect `id_token` user claims define attributes like first name, last
name and email address. Where possible, we recommend you use these. But what if
there is an attribute that is just not in any standard schema? This article will
explain what you need to do to configure the Gluu Server to support your new
attributes, and give you some advice along the way with regard to best practices.
We'll use fictional Company Acme Inc., which has requirements
for "acmeCustNumber" and "acmeStateLicenseNumber"

## LDAP Schema

The first step is to make sure that your LDAP server can persist these attributes.
Each LDAP server implementation manages schema in its own way. The most common
LDAP server backend for the Gluu Server is OpenDJ, so this article will use this
platform as an example. This schema should also work for 389DS. If you are using
OpenLDAP or another platform, just refer to the respective documentation.

In LDAP, "schema" refers to the `attribute` and `objectclass` definitions.
In OpenDJ, schema is stored in `{opendj-home}/config/schema`. If your company has
custom schema, it may be simpler to make a separate file that contains your
definitions (rather than using the built-in attribute management features, which
would store the schema in a default file, `100-user.ldif` in OpenDJ. Don't stress
about the OID value in the schema definition. If your company has a standard
OID management process in place, by all means use it. But otherwise just make
sure the OID is unique. Be careful about defining attributes as single-value
(you may change your mind later). Also, in your objectclasses, avoid
requiring attributes with `MUST`.

Below is a sample schema file for fictional OpenDJ. For more information see
the [documentation](http://opendj.forgerock.org/opendj-server/doc/admin-guide/#chap-schema)

``101-acme.ldif``

    dn: cn=schema
    objectClass: top
    objectClass: ldapSubentry
    objectClass: subschema
    cn: schema
    attributeTypes: ( acmeCustNumber-oid NAME 'acmeCustNumber' EQUALITY
      caseIgnoreMatch ORDERING caseIgnoreOrderingMatch SUBSTR caseIgnoreSubstringsMatch
      SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 )
    attributeTypes: ( acmeStateLicenseNumber-oid NAME 'acmeStateLicenseNumber' EQUALITY
      caseIgnoreMatch ORDERING caseIgnoreOrderingMatch SUBSTR caseIgnoreSubstringsMatch
      SYNTAX 1.3.6.1.4.1.1466.115.121.1.15)
    objectClasses:  ( teaperson-oid NAME 'teaPerson' SUP top
      MAY ( acmeCustNumber $ acmeStateLicenseNumber ) )

## Register Attribute in the Gluu Server

The Gluu Server needs to know which attributes are available. Each attribute that
you want to make available must have a corresponding LDAP entry under
`ou=attributes,o=<org-inum>,o=gluu`. If you browse your LDAP server after
performing a Gluu Server base installation, you will see that many commonly
used attributes are already there. When an LDAP entry exists for your attribute,
it is considered to be "registered."

There are two ways you can regsiter an attribute. If you are an LDAP geek, you
can just create an LDIF file with the correct information, and load it in the
LDAP server that is storing your configuration. If you want to quickly spool
up new Gluu Servers, this is probably the quickest way to handle it.

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

If you just have a couple of attributes, you can also use the oxTrust Web
interface to add the attributes. See screenshot below, and refer to the
oxTrust [documentation](../admin-guide/saml/outbound-saml.md/#ldap-attributes/) for an explanation of all these fields.

## OpenID Scopes

In SAML, attributes are released directly to websites, so there is not much
you need to do. In OpenID Connect, there is a little more complexity. OpenID
Connect defines scopes, which let you group attributes together, and to provide
a human understandable description of the attributes. This improves usability
when you need to prompt a person to approve the disclosure of attributes to
a third party. For example, instead of asking the user if its ok to release
her address, city, state, and country, and providing a description of each
attribute, it may be easier to ask the person if its ok to release "mailing
address information." In situations where the attributes may confuse the person,
OpenID Scopes are a really good thing.

An example of the default Gluu Server authorization request:

![OpenID Connect Scope Authorization Screenshot](../img/openid_connect/authz_screenshot.png)

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
information would be persisted in the attribute LDAP data. At some point this
will happen (see [Jira issue](http://ox.gluu.org/jira/browse/OXTRUST-169)). But 
in the meantime, this is controlled by oxauth.xml. So if you want to publish 
that a claim is available, you'll need to update this section:

    <claims-supported>
        <claim>uid</claim>
        <claim>givenName</claim>
        <claim>sn</claim>
        <claim>displayName</claim>
        <claim>mail</claim>
    </claims-supported>

## Letting the world know about your custom schema

While OpenID Connect Discovery provides one place where you can publish
information about your claims, and which scopes are must be requested
to get a certain claim, its meant for computers to read, not people.
For this reason, its a good idea to publish a schema definition guide
that people can refer to. Gluu has a 
[sample federation public site](http://www.gluu.co/sample-federation)
that you may want to look at if you needs some ideas about how to present
the information.
