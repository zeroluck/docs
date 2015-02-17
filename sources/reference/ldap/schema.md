# Schema

Below are schema for OpenDJ and OpenLDAP.  OpenDJ schema should work for 389DS too:  

 * [OpenDJ](https://github.com/GluuFederation/community-edition-setup/tree/master/static/opendj)
 * [OpenLDAP](https://github.com/GluuFederation/community-edition-setup/tree/master/static/openldap)

### Objectclass gluuAppliance
 * __Description__ 
 * __blowfishPassword__ Blowfish crypted text
 * __c__ 
 * __description__ 
 * __displayName__ 
 * __gluuAdditionalBandwidth__ Track bandwidth requirements for the Gluu Server instance
 * __gluuAdditionalMemory__ Track additional memory requirements for the Gluu Server instance.
 * __gluuApplianceDnsServer__ Persist the DNS server that should be used for the Gluu Server instance.
 * __gluuAppliancePollingInterval__ Set the frequency of the health status update of the Gluu Server
 * __gluuBandwidthRX__ Track data received by the Gluu Server
 * __gluuBandwidthTX__ Track data sent by the Gluu Server
 * __gluuBillingEmail__ Billing Alert Email Address
 * __gluuCentreonEmail__ TODO - in use? Email Address to send monitoring alerts
 * __gluuDSstatus__ Monitor health of the instance LDAP server.
 * __gluuFederationHostingEnabled__ oxTrust flag for the federation feature. Values enabled or disabled.
 * __gluuFreeDiskSpace__ Monitor free disk space on the Gluu Server instance
 * __gluuFreeMemory__ Monitor free memory on the Gluu Server instance
 * __gluuFreeSwap__ Monitor swap space on the Gluu Server instance
 * __gluuGroupCount__ Monitor the number of groups. TODO - Remove?
 * __gluuHTTPstatus__ Monitor HTTP availability of the Gluu Server instance
 * __gluuHostname__ The hostname of the Gluu Server instance
 * __gluuInvoiceNo__ TODO - in use?
 * __gluuIpAddress__ IP address of the Gluu Server instance
 * __gluuJiraEmail__ TODO - in use? Jira Alert Email Address
 * __gluuLastUpdate__ Monitors last time the server was able to connect to the monitoring system.
 * __gluuLifeRay__ None
 * __gluuLoadAvg__ Montior the average CPU load for a Gluu Server instance.
 * __gluuManageIdentityPermission__ TODO - in use?
 * __gluuManager__ Used to specify if a person has the manager role
 * __gluuMaxLogSize__ Maximum Log File Size
 * __gluuOrgProfileMgt__ enable or disable profile management feature in oxTrust
 * __gluuPaidUntil__ TODO - in use?
 * __gluuPaymentProcessorTimestamp__ TODO - in use?
 * __gluuPersonCount__ Monitor the number of people in the LDAP severs for a Gluu Server instance
 * __gluuPrivacyEmail__ Privacy Alert Email Address used by oxTrust.
 * __gluuPrivate__ TODO - in use?
 * __gluuPublishIdpMetadata__ Gluu Server flag to publish the IDP metadata via the web server
 * __gluuResizeInitiated__ TODO - in use?
 * __gluuSPTR__ TODO - in use?
 * __gluuScimEnabled__ oxTrust SCIM feature - enabled or disabled
 * __gluuShibAssertionsIssued__ Monitors activity of Gluu Server Shibboleth IDP
 * __gluuShibFailedAuth__ Monitors failed login attempts on Gluu Server Shibboleth IDP
 * __gluuShibSecurityEvents__ Monitors security events on Gluu Server Shibboleth IDP
 * __gluuShibSuccessfulAuths__ Monitors login attempts on Gluu Server Shibboleth IDP
 * __gluuSmtpFromEmailAddress__ SMTP From Email Address
 * __gluuSmtpFromName__ SMTP From Name
 * __gluuSmtpHost__ SMTP Host
 * __gluuSmtpPassword__ SMTP User Password
 * __gluuSmtpPort__ SMTP Port
 * __gluuSmtpRequiresAuthentication__ SMTP Requires Authentication
 * __gluuSmtpRequiresSsl__ SMTP Requires SSL
 * __gluuSmtpUserName__ SMTP User Name
 * __gluuSslExpiry__ SAML Trust Relationship configuration
 * __gluuStatus__ Status of the entry, used by many objectclasses
 * __gluuSvnEmail__ SVN Alert Email Address
 * __gluuSystemUptime__ Monitors how long the Gluu Server instance has been running.
 * __gluuTargetRAM__ Monitors total available RAM on Gluu Server instance
 * __gluuUrl__ Gluu instance URL
 * __gluuVDSenabled__ oxTrust VDS enabled or disabled
 * __gluuVDSstatus__ Gluu VDS configuration
 * __gluuVdsCacheRefreshEnabled__ None
 * __gluuVdsCacheRefreshLastUpdate__ None
 * __gluuVdsCacheRefreshLastUpdateCount__ None
 * __gluuVdsCacheRefreshPollingInterval__ None
 * __gluuVdsCacheRefreshProblemCount__ None
 * __gluuWhitePagesEnabled__ None
 * __iname__ None
 * __inum__ XRI i-number
 * __inumFN__ XRI i-number sans punctuation
 * __o__ 
 * __oxAuthenticationLevel__ None
 * __oxAuthenticationMode__ None
 * __oxClusterType__ Type of the underlying clustering mechanism
 * __oxClusteredServers__ List of the clustering partners of this server
 * __oxIDPAuthentication__ Custom IDP authentication configuration
 * __oxLogViewerConfig__ Log viewer configuration
 * __oxMemcachedServerAddress__ Initialization string for memcached client
 * __oxSmtpConfiguration__ SMTP configuration
 * __oxTrustStoreCert__ oxPush device configuration
 * __oxTrustStoreConf__ oxPush application configuration
 * __passwordResetAllowed__ Is password reset mechanics allowed
 * __softwareVersion__ None
 * __userPassword__ 
 * __oxTrustCacheRefreshServerIpAddress__ None

### Objectclass gluuAttribute
 * __Description__ 
 * __description__ 
 * __displayName__ 
 * __gluuAttributeEditType__ Specify in oxTrust who can update an attribute, admin or user
 * __gluuAttributeName__ Specify an identifier for an attribute. May be multi-value where an attribute has two names, like givenName and first-name.
 * __gluuAttributeOrigin__ Specify the person objectclass associated with the attribute, used for display purposes in oxTrust.
 * __gluuAttributeSystemEditType__ TODO - still required?
 * __gluuAttributeType__ Data type of attribute. Values can be string, photo, numeric, date
 * __gluuAttributeUsageType__ TODO - Usage? Value can be OpenID
 * __gluuAttributeViewType__ Specify in oxTrust who can view an attribute, admin or user
 * __gluuCategory__ TODO - in use? Used to group attributes together.
 * __gluuSAML1URI__ SAML 1 uri of attribute
 * __gluuSAML2URI__ SAML 2 uri of attribute
 * __gluuStatus__ Status of the entry, used by many objectclasses
 * __iname__ None
 * __inum__ XRI i-number
 * __objectClass__ 
 * __oxAttributeType__ NameId or attribute
 * __oxMultivaluedAttribute__ None
 * __oxNameIdType__ NameId Type
 * __oxSCIMCustomAttribute__ None
 * __oxSourceAttribute__ Source Attribute for this Attribute
 * __seeAlso__ 
 * __urn__ None
 * __gluuLdapAttributeName__ Used by oxAuth and oxTrust to specify the LDAP attribute of the name.
 * __oxAuthClaimName__ Used by oxAuth in conjunction with gluuLdapAttributeName to map claims to attributes in LDAP.

### Objectclass gluuGroup
 * __Description__ 
 * __c__ 
 * __description__ 
 * __displayName__ 
 * __gluuGroupType__ Type of Group. Not used.
 * __gluuGroupVisibility__ Group visibility. Not used.
 * __gluuStatus__ Status of the entry, used by many objectclasses
 * __iname__ None
 * __inum__ XRI i-number
 * __member__ 
 * __o__ 
 * __owner__ 
 * __seeAlso__ 

### Objectclass gluuInumMap
 * __Description__ 
 * __gluuStatus__ Status of the entry, used by many objectclasses
 * __inum__ XRI i-number
 * __primaryKeyAttrName__ Primary Key Attribute Name
 * __primaryKeyValue__ Primary Key Value
 * __secondaryKeyAttrName__ Secondary Key Attribute Name
 * __secondaryKeyValue__ Secondary Key Value
 * __tertiaryKeyAttrName__ Tertiary Key Attribute Name
 * __tertiaryKeyValue__ Tertiary Key Value

### Objectclass gluuInvoice
 * __Description__ 
 * __gluuInvoiceAmount__ TODO - in use?
 * __gluuInvoiceDate__ TODO - in use?
 * __gluuInvoiceLineItemName__ TODO - in use?
 * __gluuInvoiceNumber__ TODO - in use?
 * __gluuInvoiceProductNumber__ TODO - in use?
 * __gluuInvoiceQuantity__ TODO - in use?
 * __gluuInvoiceStatus__ TODO - in use?
 * __inum__ XRI i-number

### Objectclass gluuOrganization
 * __Description__ 
 * __c__ 
 * __county__ ISO 3166-1 Alpha-2 Country Code
 * __deployedAppliances__ Track which appliances are deployed at an organization.
 * __description__ 
 * __displayName__ 
 * __gluuAddPersonCapability__ Organizational attribute to control whether new users can be added via the oxTrust GUI.
 * __gluuAdditionalUsers__ TODO : use unclear
 * __gluuApplianceUpdateRequestList__ Used by the Gluu Server to request an update
 * __gluuCustomMessage__ oxTrust custom welcome message
 * __gluuFaviconImage__ TODO - Stores URL of favicon
 * __gluuFederationHostingEnabled__ oxTrust flag for the federation feature. Values enabled or disabled.
 * __gluuInvoiceNo__ TODO - in use?
 * __gluuLogoImage__ Logo used by oxTrust for default look and feel.
 * __gluuManageIdentityPermission__ TODO - in use?
 * __gluuManager__ Used to specify if a person has the manager role
 * __gluuManagerGroup__ Used in organizatoin entry to specifies the dn of the group that has admin priviledges in oxTrust.
 * __gluuOrgProfileMgt__ enable or disable profile management feature in oxTrust
 * __gluuOrgShortName__ Short description, as few letters as possible, no spaces.
 * __gluuOwnerGroup__ Deprecated. Use gluuManagerGroup
 * __gluuPaidUntil__ TODO - in use?
 * __gluuPaymentProcessorTimestamp__ TODO - in use?
 * __gluuProStoresUser__ TODO - remove
 * __gluuStatus__ Status of the entry, used by many objectclasses
 * __gluuTempFaviconImage__ Store location for upload of Favicon
 * __gluuThemeColor__ oxTrust login page configuration
 * __gluuWhitePagesEnabled__ None
 * __iname__ None
 * __inum__ XRI i-number
 * __l__ 
 * __mail__ 
 * __memberOf__ None
 * __nonProfit__ TODO - in use?
 * __o__ 
 * __objectClass__ 
 * __oxCreationTimestamp__ Registration time
 * __oxLinkLinktrack__ Linktrack link
 * __oxLinktrackEnabled__ Is Linktrack API configured
 * __oxLinktrackLogin__ Linktrack API login
 * __oxLinktrackPassword__ Linktrack API password
 * __oxRegistrationConfiguration__ Registration Configuration
 * __postalCode__ 
 * __proStoresToken__ None
 * __prostoresTimestamp__ None
 * __scimAuthMode__ SCIM Authorization mode
 * __scimGroup__ scim Group
 * __scimStatus__ scim status
 * __st__ 
 * __street__ 
 * __telephoneNumber__ 
 * __title__ 
 * __uid__ 
 * __userPassword__ 

### Objectclass gluuPasswordResetRequest
 * __Description__ 
 * __creationDate__ Creation Date used for password reset requests
 * __oxGuid__ A random string to mark temporary tokens
 * __personInum__ Inum of a person

### Objectclass gluuPerson
 * __Description__ 
 * __associatedClient__ 
 * __c__ 
 * __displayName__ 
 * __givenName__ 
 * __gluuManagedOrganizations__ Used to track with which organizations a person is associated
 * __gluuOptOuts__ White pages attributes restricted by person in oxTrust profile management
 * __gluuStatus__ Status of the entry, used by many objectclasses
 * __gluuWhitePagesListed__ Allow Publication
 * __iname__ None
 * __inum__ XRI i-number
 * __mail__ 
 * __memberOf__ None
 * __o__ 
 * __oxAuthPersistentJWT__ oxAuth Persistent JWT
 * __oxCreationTimestamp__ Registration time
 * __oxExternalUid__ None
 * __oxInviteCode__ Invite Code
 * __oxLastLogonTime__ Last logon time
 * __oxTrustActive__ None
 * __oxTrustAddresses__ None
 * __oxTrustEmail__ None
 * __oxTrustEntitlements__ None
 * __oxTrustExternalId__ None
 * __oxTrustImsValue__ None
 * __oxTrustMetaCreated__ None
 * __oxTrustMetaLastModified__ None
 * __oxTrustMetaLocation__ None
 * __oxTrustMetaVersion__ None
 * __oxTrustNameFormatted__ None
 * __oxTrustPhoneValue__ None
 * __oxTrustPhotos__ None
 * __oxTrustProfileURL__ None
 * __oxTrustRole__ None
 * __oxTrustTitle__ None
 * __oxTrustUserType__ None
 * __oxTrusthonorificPrefix__ None
 * __oxTrusthonorificSuffix__ None
 * __oxTrustx509Certificate__ None
 * __persistentId__ PersistentId
 * __middleName__ Middle name(s)
 * __nickname__ Casual name of the End-User
 * __preferredUsername__ Shorthand Name
 * __profile__ Profile page URL of the person
 * __picture__ Profile picture URL of the person
 * __website__ Web page or blog URL of the person
 * __emailVerified__ True if the e-mail address of the person has been verified; otherwise false
 * __gender__ Gender of the person either female or male
 * __birthdate__ Birthday of the person, represented as an ISO 8601:2004 [ISO8601â€‘2004] YYYY-MM-DD format
 * __zoneinfo__ time zone database representing the End-User
 * __locale__ Locale of the person, represented as a BCP47 [RFC5646] language tag
 * __phoneNumberVerified__ True if the phone number of the person has been verified, otherwise false
 * __address__ OpenID Connect formatted JSON object representing the address of the person
 * __updatedAt__ Time the information of the person was last updated. Seconds from 1970-01-01T0:0:0Z
 * __preferredLanguage__ 
 * __role__ Role
 * __secretAnswer__ Secret Answer
 * __secretQuestion__ Secret Question
 * __seeAlso__ 
 * __sn__ 
 * __cn__ 
 * __transientId__ TransientId
 * __uid__ 
 * __userPassword__ 

### Objectclass gluuSAMLconfig
 * __Description__ 
 * __description__ 
 * __displayName__ 
 * __federationRules__ Track rules for the federation in Gluu SAML config. Deprecated as multi-party federation management should move to Jagger.
 * __gluuContainerFederation__ SAML Trust Relationship federation info
 * __gluuEntityId__ Specifies SAML trust relationship entity ID
 * __gluuIsFederation__ Used in oxTrust to specify if a SAML Trust Relationship is a federation. It could also be a website
 * __gluuProfileConfiguration__ SAML Trust Relationship attribute
 * __gluuReleasedAttribute__ oxTrust reference for the dn of the released attribute
 * __gluuRulesAccepted__ TODO - use unknown for Gluu SAML config
 * __gluuSAMLMetaDataFilter__ Metadata filter in SAML trust relationship
 * __gluuSAMLTrustEngine__ SAML trust relationship configuration
 * __gluuSAMLmaxRefreshDelay__ SAML trust relationship refresh time
 * __gluuSAMLspMetaDataFN__ SAML Trust Relationship file location of metadata
 * __gluuSAMLspMetaDataSourceType__ SAML Trust Relationship SP metadata type - file, URI, federation
 * __gluuSAMLspMetaDataURL__ SAML Trust Relationship URI location of metadata
 * __gluuSpecificRelyingPartyConfig__ SAML Trust Relationship configuration
 * __gluuStatus__ Status of the entry, used by many objectclasses
 * __gluuTrustContact__ oxTrust login page configuration
 * __gluuTrustDeconstruction__ TODO - in use?
 * __gluuValidationLog__ None
 * __gluuValidationStatus__ None
 * __iname__ None
 * __inum__ XRI i-number
 * __o__ 
 * __objectClass__ 
 * __oxAuthPostLogoutRedirectURI__ oxAuth Post Logout Redirect URI
 * __url__ None

### Objectclass oxAuthClient
 * __Description__ 
 * __associatedPerson__ Reference the dn of a person.
 * __displayName__ 
 * __inum__ XRI i-number
 * __oxAuthAppType__ oxAuth App Type
 * __oxAuthClientIdIssuedAt__ oxAuth Client Issued At
 * __oxAuthClientSecret__ oxAuth Client Secret
 * __oxAuthClientSecretExpiresAt__ Date client expires
 * __oxAuthClientURI__ oxAuth Client URI
 * __oxAuthClientUserGroup__ oxAuth Client User group
 * __oxAuthContact__ oxAuth Contact
 * __oxAuthDefaultAcrValues__ oxAuth Default Acr Values
 * __oxAuthDefaultMaxAge__ oxAuth Default Max Age
 * __oxAuthFederationId__ oxAuth Federation ID attribute
 * __oxAuthFederationMetadataURI__ oxAuth Federation metadata URI attribute
 * __oxAuthGrantType__ oxAuth Grant Type
 * __oxAuthIdTokenEncryptedResponseAlg__ oxAuth ID Token Encrypted Response Alg
 * __oxAuthIdTokenEncryptedResponseEnc__ oxAuth ID Token Encrypted Response Enc
 * __oxAuthIdTokenSignedResponseAlg__ oxAuth ID Token Signed Response Alg
 * __oxAuthInitiateLoginURI__ oxAuth Initiate Login URI
 * __oxAuthJwksURI__ oxAuth JWKs URI
 * __oxAuthLogoURI__ oxAuth Logo URI
 * __oxAuthPolicyURI__ oxAuth Policy URI
 * __oxAuthPostLogoutRedirectURI__ oxAuth Post Logout Redirect URI
 * __oxAuthRedirectURI__ oxAuth Redirect URI
 * __oxAuthRegistrationAccessToken__ oxAuth Registration Access Token
 * __oxAuthRequestObjectSigningAlg__ oxAuth Request Object Signing Alg
 * __oxAuthRequestURI__ oxAuth Request URI
 * __oxAuthRequireAuthTime__ oxAuth Require Authentication Time
 * __oxAuthResponseType__ oxAuth Response Type
 * __oxAuthScope__ oxAuth Attribute Scope
 * __oxAuthSectorIdentifierURI__ oxAuth Sector Identifier URI
 * __oxAuthSignedResponseAlg__ oxAuth Signed Response Alg
 * __oxAuthSubjectType__ oxAuth Subject Type
 * __oxAuthTokenEndpointAuthMethod__ oxAuth Token Endpoint Auth Method
 * __oxAuthTosURI__ oxAuth TOS URI
 * __oxAuthTrustedClient__ oxAuth Trusted Client
 * __oxAuthUserInfoEncryptedResponseAlg__ oxAuth User Info Encrypted Response Alg
 * __oxAuthUserInfoEncryptedResponseEnc__ oxAuth User Info Encrypted Response Enc
 * __oxLastAccessTime__ Last access time
 * __oxLastLogonTime__ Last logon time

### Objectclass oxAuthConfiguration
 * __Description__ 
 * __ou__ 
 * __oxAuthConfCustomAuthMethod__ Custom authentication method
 * __oxAuthConfDynamic__ oxAuth Dynamic Configuration
 * __oxAuthConfErrors__ oxAuth Errors Configuration
 * __oxAuthConfIdPythonScript__ Custom id generation
 * __oxAuthConfLdapAuth__ LDAP authentication configuration
 * __oxAuthConfStatic__ oxAuth Static Configuration
 * __oxAuthConfWebKeys__ oxAuth Web Keys Configuration

### Objectclass oxAuthCustomScope
 * __Description__ 
 * __defaultScope__ Track the default scope for an custom OAuth2 Scope.
 * __description__ 
 * __displayName__ 
 * __inum__ XRI i-number
 * __oxAuthClaim__ oxAuth Attribute Claim

### Objectclass oxAuthFederationMetadata
 * __Description__ 
 * __displayName__ 
 * __inum__ XRI i-number
 * __oxAuthFederationMetadataIntervalCheck__ oxAuth Federation metadata interval check attribute
 * __oxAuthFederationOP__ oxAuth Federation OP attribute
 * __oxAuthFederationRP__ oxAuth Federation RP attribute
 * __oxAuthRedirectURI__ oxAuth Redirect URI

### Objectclass oxAuthFederationOP
 * __Description__ 
 * __displayName__ 
 * __inum__ XRI i-number
 * __oxAuthFederationOpDomain__ oxAuth Federation OP domain attribute
 * __oxAuthFederationOpId__ oxAuth Federation OP ID attribute
 * __oxAuthX509PEM__ oxAuth x509 in PEM format
 * __oxAuthX509URL__ oxAuth x509 URL

### Objectclass oxAuthFederationRP
 * __Description__ 
 * __displayName__ 
 * __inum__ XRI i-number
 * __oxAuthRedirectURI__ oxAuth Redirect URI
 * __oxAuthX509PEM__ oxAuth x509 in PEM format
 * __oxAuthX509URL__ oxAuth x509 URL

### Objectclass oxAuthFederationRequest
 * __Description__ 
 * __displayName__ 
 * __inum__ XRI i-number
 * __oxAuthFederationOpDomain__ oxAuth Federation OP domain attribute
 * __oxAuthFederationOpId__ oxAuth Federation OP ID attribute
 * __oxAuthFederationRequestType__ oxAuth Federation request type attribute
 * __oxAuthRedirectURI__ oxAuth Redirect URI

### Objectclass oxAuthFederationTrust
 * __Description__ 
 * __displayName__ 
 * __inum__ XRI i-number
 * __oxAuthFederationId__ oxAuth Federation ID attribute
 * __oxAuthFederationMetadataURI__ oxAuth Federation metadata URI attribute
 * __oxAuthFederationTrustStatus__ oxAuth Federation Trust Status attribute
 * __oxAuthRedirectURI__ oxAuth Redirect URI
 * __oxAuthReleasedScope__ oxAuth released scope attribute
 * __oxAuthSkipAuthorization__ oxAuth skip authorization attribute

### Objectclass oxAuthSessionId
 * __Description__ 
 * __lastModifiedTime__ 
 * __oxAuthAuthenticationTime__ oxAuth Authentication Time
 * __oxAuthPermissionGranted__ oxAuth Permission Granted
 * __oxAuthPermissionGrantedMap__ oxAuth Permission Granted Map
 * __oxAuthUserDN__ oxAuth User DN
 * __uniqueIdentifier__ 

### Objectclass oxAuthToken
 * __Description__ 
 * __createTimestamp__ 
 * __oxAuthAuthenticationTime__ oxAuth Authentication Time
 * __oxAuthAuthorizationCode__ oxAuth authorization code
 * __oxAuthCreation__ oxAuth Creation
 * __oxAuthExpiration__ oxAuth Expiration
 * __oxAuthGrantId__ oxAuth grant id
 * __oxAuthGrantType__ oxAuth Grant Type
 * __oxAuthJwtRequest__ oxAuth JWT Request
 * __oxAuthNonce__ oxAuth nonce
 * __oxAuthScope__ oxAuth Attribute Scope
 * __oxAuthTokenCode__ oxAuth Token Code
 * __oxAuthTokenType__ oxAuth Token Type
 * __oxAuthUserId__ oxAuth user id
 * __oxAuthenticationLevel__ None
 * __oxAuthenticationMode__ None
 * __uniqueIdentifier__ 

### Objectclass oxAuthUmaPolicy
 * __Description__ 
 * __description__ 
 * __displayName__ 
 * __inum__ XRI i-number
 * __oxAuthUmaScope__ URI reference of scope descriptor
 * __oxPolicyScript__ ox policy script
 * __programmingLanguage__ programming language

### Objectclass oxAuthUmaRPT
 * __Description__ 
 * __oxAmHost__ am host
 * __oxAuthAuthenticationTime__ oxAuth Authentication Time
 * __oxAuthClientId__ oxAuth Client id
 * __oxAuthCreation__ oxAuth Creation
 * __oxAuthExpiration__ oxAuth Expiration
 * __oxAuthTokenCode__ oxAuth Token Code
 * __oxAuthUserId__ oxAuth user id
 * __oxUmaPermission__ ox uma permission
 * __uniqueIdentifier__ 

### Objectclass oxAuthUmaResourceSet
 * __Description__ 
 * __displayName__ 
 * __inum__ XRI i-number
 * __owner__ 
 * __oxAssociatedClient__ Associate the dn of an OAuth2 client with a person or UMA Resource Set.
 * __oxAuthUmaScope__ URI reference of scope descriptor
 * __oxFaviconImage__ URI for a graphic icon
 * __oxGroup__ User group
 * __oxId__ Identifier
 * __oxResource__ Host path
 * __oxRevision__ Revision
 * __oxType__ ox type

### Objectclass oxAuthUmaResourceSetPermission
 * __Description__ 
 * __oxAmHost__ am host
 * __oxAuthExpiration__ oxAuth Expiration
 * __oxAuthUmaScope__ URI reference of scope descriptor
 * __oxConfigurationCode__ ox configuration code
 * __oxHost__ ox host
 * __oxResourceSetId__ ox resource set id
 * __oxTicket__ ox ticket

### Objectclass oxAuthUmaScopeDescription
 * __Description__ 
 * __displayName__ 
 * __inum__ XRI i-number
 * __owner__ 
 * __oxFaviconImage__ URI for a graphic icon
 * __oxIconUrl__ ox icon url
 * __oxId__ Identifier
 * __oxPolicyRule__ Revision
 * __oxRevision__ Revision
 * __oxType__ ox type
 * __oxUrl__ ox url

### Objectclass oxEntry
 * __Description__ 
 * __displayName__ 
 * __iname__ None
 * __inum__ XRI i-number

### Objectclass oxLink
 * __Description__ 
 * __description__ 
 * __oxGuid__ A random string to mark temporary tokens
 * __oxLinkCreator__ Link Creator
 * __oxLinkExpirationDate__ Link Expiration Date
 * __oxLinkLinktrack__ Linktrack link
 * __oxLinkModerated__ Is Link Moderated?
 * __oxLinkModerators__ Link Moderators
 * __oxLinkPending__ Pending Registrations

### Objectclass oxLiteralNode
 * __Description__ 
 * __literalBinaryValue__ OX literalValue
 * __literalValue__ OX literalValue
 * __organizationalOwner__ OX organizationalOwner
 * __owner__ 
 * __targetRelationalXdiStatement__ OX TargetRelationalXdiStatement
 * __x__ OX XRI Component
 * __xdiStatement__ OX xdiStatement
 * __xri__ OX XRI address

### Objectclass oxNode
 * __Description__ 
 * __organizationalOwner__ OX organizationalOwner
 * __owner__ 
 * __sourceRelationalXdiStatement__ OX SourceRelationalXdiStatement
 * __targetRelationalXdiStatement__ OX TargetRelationalXdiStatement
 * __x__ OX XRI Component
 * __xdiStatement__ OX xdiStatement
 * __xri__ OX XRI address

### Objectclass oxProxAccessToken
 * __Description__ 
 * __oxAuthCreation__ oxAuth Creation
 * __oxAuthExpiration__ oxAuth Expiration
 * __oxProxyAccessToken__ oxProx access token
 * __oxProxyClientId__ oxProx client id

### Objectclass oxProxClient
 * __Description__ 
 * __displayName__ 
 * __inum__ XRI i-number
 * __oxProxyClaimMapping__ oxProx claim mapping
 * __oxProxyScope__ oxProx scope
 * __oxProxyToOpClientMapping__ oxProx client mapping to op client

### Objectclass oxProxConfiguration
 * __Description__ 
 * __ou__ 
 * __oxProxConf__ oxProx Configuration
 * __oxScriptDn__ Script object DN

### Objectclass oxProxOp
 * __Description__ 
 * __c__ 
 * __displayName__ 
 * __inum__ XRI i-number
 * __l__ 
 * __oxDomain__ domain
 * __oxId__ Identifier
 * __oxX509PEM__ x509 in PEM format
 * __oxX509URL__ x509 URL

### Objectclass oxPushApplication
 * __Description__ 
 * __displayName__ 
 * __oxId__ Identifier
 * __oxName__ Name
 * __oxPushApplicationConf__ oxPush application configuration

### Objectclass oxPushDevice
 * __Description__ 
 * __oxAuthUserId__ oxAuth user id
 * __oxId__ Identifier
 * __oxPushApplication__ oxPush application DN
 * __oxPushDeviceConf__ oxPush device configuration
 * __oxType__ ox type

### Objectclass oxScript
 * __Description__ 
 * __inum__ XRI i-number
 * __oxScript__ Attribute that contains script (python, java script)
 * __oxScriptType__ Attribute that contains script type (e.g. python, java script)

### Objectclass oxTrustConfiguration
 * __Description__ 
 * __ou__ 
 * __oxTrustConfApplication__ oxTrust Application Configuration

### Objectclass vdDirectoryView
 * __Description__ 
 * __o__ 

### Objectclass vdapcontainer
 * __Description__ 
 * __ou__ 

### Objectclass vdlabel
 * __Description__ 
 * __o__ 


