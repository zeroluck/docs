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

## Attributes' metadata

Simply modifying your LDAP schema (more on it below) isn't enough for the Gluu Server to become able to use your newly added attributes right away. It needs to know which of those attributes will be available for its workflows (and which exactly workflows). Each attribute that you want to make available must have a corresponding LDAP
entry under `ou=attributes,o=<org-inum>,o=gluu`, also called attribute's metadata. If you browse your LDAP
server after performing a Gluu Server base installation, you will see
that many commonly used attributes are already there. When an LDAP entry
exists for your attribute, it is considered to be "registered".

## Register Attribute in the Gluu Server

There are two ways you can register an attribute. The most user-frendly and straightforward way is to create your custom attributes one by one using oxTrust web UI. Unless you need to create a huge amount of entries, or have very specific requierments, this method is strictly recommended and should be able to provide most of your everyday needs.
But if you are an LDAP geek, or just sure that previous method can't be used in your case, your next option is to edit LDAP directory used by Gluu directly. You can just create an LDIF file with the correct information, and
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

## OpenID Scopes

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
