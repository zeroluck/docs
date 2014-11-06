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

## Install Shibolleth SP Package
The Shibboleth Service Provider(SP) software runs a system service, and it is configured via an apache module. For CentOS it is necessary to add shib.repo to /etc/yum/repos.d and install with yum.

*$ yum install shibboleth*

*$ service shibd start*

*$ chkconfig shibd on*

For other systems, please follow the instructions on the [Shibboleth SP Installation](https://spaces.internet2.edu/display/SHIB2/NativeSPLinuxInstall) page.

## Copy Files From Archive

Please copy the following files to the */etc/shibboleth* folder.

*$ cp attribute-map.xml /etc/shibboleth/attribute-map.xml*

*$ cp shibboleth2.xml /etc/shibboleth/shibboleth2.xml*

*$ cp idp-metadata.xml /etc/shibboleth/idp-metadata.xml*

*$ cp sp-metadata.xml /etc/shibboleth/sp-metadata.xml*

> **Note**

> IdP and SP metadata filenames are unique for each IdP and SP. The SP metadata is based on the i-number for the trust relationship.
> The IdP metadata is based on the i-number for the organization.

## Add Server Certificate to Metadata

Please update the server certificate in shibboleth2.xml at the following location.

*$ vi /etc/shibboleth/shibboleth2.xml*

	< ds:X509Certificate >

	* * * * * * * * * * * * * * * 

	Insert pem format of the key 

	* * * * * * * * * * * * * * * 

	< / ds: X509Certificate >

## Update Hostnames and Ports in Configuration File

Please edit the hostname in secure session section in _shibboleth2.xml_ file.

*$ vi /etc/shibboleth/shibboleth2.xml*

	< Host Name="hostname" >

	< Path name="secure" authType="shibboleth" requireSession="true"/ >

	< /Host >

> **Note**

> Hostname and port should match the Apache's ServerName and Port directives.

Edit the _httpd.conf_ file to set UseCanonicalName On:

	UseCanonicalName: On

## Protect Folder with Shibboleth SSO

Add the following to _httpsd.conf_ file to protect directories.

*$ vi /etc/httpd/conf/httpd.conf*

	< Directory "_path to directories_" >

	 AuthType shibboleth

	 ShibRequestSetting requireSession 1

	 ShibUseHeaders On

	 require valid-user

	< / Directory >

## Restart shibd and apache httpd

*$ service httd restart*

*$ service shibd restart*

Try to access _https://hostname/Shibboleth.sso/Status_
