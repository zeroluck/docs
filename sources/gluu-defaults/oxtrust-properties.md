[TOC]
# Configuration
## oxTrust Configuration
This page explains the JSON Configuration under the Configuration Tab in the Configuration menu.

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-json_menu.png)

## oxtrust.properties

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-json_oxtrustproperties.png)

The following fields are available for edit in the menu.

* _idpLdapServer:_ the name of the server with port
* _baseDN:_ the base doaim name of oxtrust. The default is `o=gluu`
* _orgIname:_ 
* _orgSupportEmail:_ the support email address of the Gluu Server installation
* _applianceInum:_ the [INUM][inum] of the appliance
* _applianceUrl:_ the [URI][uri] of the appliance
* _baseEndpoint:_ 
* _schemaAddObjectClassWithAttributeTypesDefinition:_ the schema to add various attribute types
* _schemaAddObjectClassWithoutAttributeTypesDefinition:_ the schema to add various attribute types

## personObjectClassTypes
This class holds the relation between the person entry and it's relative object class. The examples are given below.
* _item 1:_ inetOrgPerson
* _item 2:_ gluuPerson

## personObjectClassDisplayNames
This class holds the relation betwee the display name of the person and the relative object class. The examples are given below.
* _item 1:_ inetOrgPerson
* _item 2:_ gluuPerson
* _schemaAddAttributeDefenition:_ 

## contactObjectClassDisplayNames 
Items can be added under this class by clicking on the `+ item` button.

* _photoRepositoryRootDir:_ the path to the root directory of photographs
* _photoRepositoryThumbWidth:_ the thumb with of a photo
* _photoRepositoryThumbheight:_ sets the thumb height of a photo
* _photoRepositoryCountLevels:_ the count level per photo repository
* _photoRepositoryCountFoldersPerLevel:_ he number of folders per level
* _authMode:_ set this tag to `basic` to use basic authentication or leave it blank to use oxAuth
* _ldifStore:_ the path to the [LDIF][ldif] store
* _shibboleth2IdpRootDir:_ the root directory for the shibboleth plugin
* _shibboleth2SpConfDir:_ the configuration directory for the shibboleth plugin
* _pokenApplicationSecret:_
* _updateAplicanceStatus:_  the update appliance state for the site. Use `true` to allow, and `false` to forbid (default value)
* _svnConfigurationStoreRoot:_ he root of the [SVN][svn] configuration store
* _svnConfigurationStorePassword:_ the password of the [SVN][svn] configuration store
* _keystorePath:_ the path to the keystore
* _keystorePassword:_ the password to the keystore
* _allowPersonModification:_ enables or disables the allowance to modify a person entry. Use `true` to allow (default value), and  `false` otherwise
* _idpUrl:_ the [uri][uri] of the [OpenID][openid] provider that is in use
* _velocityLog:_ the velocity log filename with path
* _spMetadataPath:_the path to the Gluu Server metadata
* _logoLocation:_ the directory name for the images and logos that are used
* _idpSecurityKey:_ the security key of the [OpenID][openid] provider
* _idpSecurityKeyPassowrd:_ the security password of the [OpenID][openid] provider
* _idpSecurityCert:_ the security certificate of the machine

## gluuSpAttributes
Items can be added here by clicking on the `+ item` button.

* _configGeneration:_ this entry controls the automatic generation of the configuration files. Use `enable` to allow and `disable` otherwise
* _idpLdapProtocol:_ the protocol used by the [LDAP][ldap] server
* _orgInum:_ the [INUM][inum] of the organization
* _idpBindDn:_ the domain name of the [OpenID][openid] provider
* _idpBindPassowrd:_ the password for the [OpenID][openid] provider
* _idpUserFields:_ 
* _gluuSpCert:_ the certificate name and location of the Gluu Server
* _mysqlUrl:_ the MySql connector as [URI][uri]
* _shibboleth2FederationRootDir:_ the root directory for the [Shobboleth][shibboleth] federation plugin
* _cacheRefreshEnabled:_ the value of the cache refresh mechanism. Use `true` to enable and `false` otherwise
* _cacheRefreshIntervalMinutes:_ the time in minutes counting down to next cache-refresh event
* _caCertsLocation:_ the keystore to use for downloaded [SSL][ssl] certificates
* _caCertsPassphrase:_ the password for the caCerts keystore
* _tempCertDir:_ the temporary location for certificates while certificate update procedure
* _certDir:_ the locaiton of certificates used in configuration files
* _servicesRestartTrigger:_ the location of the file which will restart the applicance server if deleted
* _persistSVN:_ the state of persistence in [SVN][svn]. Use `true` to enable or `false` otherwise
* _oxAuthAuthorizeUrl:_ the authorization [URI][uri] for oxAuth
* _oxAuthTokenUrl:_ the token [URI][uri] for oxAuth
* _oxAuthValidateTokenUrl:_ the [URI][uri] for oxAuth token validation
* _oxAuthEndSessionUrl:_ the [URI][uri] for oxAuth session termination
* _oxAuthLogoutUrl:_ the [URI][uri] for logging out of oxAuth
* _oxAuthTokenValidationUrl:_ the [URI][uri] for oxAuth token validation
* _oxAuthUserInfo:_ the [URI][uri] for oxAuth user information
* _oxAuthSectorIdentifierUrl:_ the [URI][uri] for oxAuth sector identifier
* _oxAuthClientId:_the identification number for oxAuth client
* _oxAuthClientPassowrd:_ the password for oxAuth client
* _oxAuthClientScope:_ the scope of the oxAuth client
* _loginRedirectUrl:_ the redirect [URI][uri] for oxAuth
* _logoutRedirectUrl:_ the [URI][uri] for oxAuth 

## clusteredInums
Items can be added here by clicking on the `+ item` button.

* _clientAssociationAttribute:_ the attribute which identifies the [OpenID][openid] client
* _oxAuthIssuers:_ the [URI][uri] of the issuer authorization server
* _ignoreValidation:_ the control to check/ignore token validation. Use `true` to validate or `false` otherwise
* _umaIssuer:_ the [URI][uri] of the issuer authorization server
* _umaClientId:_ the identification of the [UMA][uma] client
* _umaClientKeyId:_ 
* _umaResourceId:_
* _umaScope:_ the scopes available for this resource
* _cssLocation:_ the path to the CSS files
* _jsLocation:_ the path to the JS files

[inum]: https://en.wikipedia.org/wiki/INum_Initiative "INUM definition in wikipedia"
[uri]: https://en.wikipedia.org/wiki/Uniform_Resource_Identifier "Uniform Resource Identifier"
[ldif]: https://en.wikipedia.org/wiki/LDAP_Data_Interchange_Format "LDAP Data Interchange Format"
[svn]: https://en.wikipedia.org/wiki/Apache_Subversion "Apache Subversion"
[openid]: https://en.wikipedia.org/wiki/OpenID "OpenID Connect"
[shibboleth]: https://en.wikipedia.org/wiki/Shibboleth_%28Internet2%29 "Shibboleth"
[ssl]: https://en.wikipedia.org/wiki/Transport_Layer_Security "Secure Sockets Layer"
[uma]: https://en.wikipedia.org/wiki/User-Managed_Access "User-Managed Access"
