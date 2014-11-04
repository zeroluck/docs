# SAML SP Configuration

## Shibboleth SP

The SP configuration can be set up from the IdP. For this purpose it is necessary to set up the trust relationship from the Gluu IdP. For convenience, the following shall cover adding trust relationships.
![SAML Menu](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/admin_saml_menu.png)

The Gluu Server Administrator can see the existing Trust Relationships by clickin on the *Trust Relationship* button from the menu. The following screen shall apear up on clicking the button.
![Add TR](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_saml_create.png)

The *Add Relationship button will open a new screen as shown below. From this screen, the Gluu Server Administrator can easily add a new Trust Relationship in the IdP.

### Trust Relationship
The Gluu Server administrator can add new Trust Relationship from the menu by selecting the *Trust Relationship* button from the *SAML* menu. The following screen shall appear.
![Add TR](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/SAMLTrustRelationships/admin_saml_newTR.png)

## Shibboleth SP Configuration

### Install Shibolleth SP Package
The Shibboleth Service Provider(SP) software runs a system service, and it is configured via an apache module. For CentOS it is necessary to add shib.repo to /etc/yum/repos.d and install with yum.
'''
# yum install shibboleth

# service shibd start

# chkconfig shibd on
'''

For other systems, please follow the instructions on the [Shibboleth SP Installation](https://spaces.internet2.edu/display/SHIB2/NativeSPLinuxInstall) page.
