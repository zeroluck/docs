# Schema

These are the attributes and objectclasses needed by oxTrust and oxAuth.

## Attributes
 * __oxAssociatedClient associatedClient__ Associate the dn of an OAuth2 client with a person or UMA Resource Set.
 * __associatedPerson__ Reference the dn of a person.
 * __blowfishPassword__ Blowfish crypted text
 * __county__ ISO 3166-1 Alpha-2 Country Code
 * __creationDate__ Creation Date used for password reset requests
 * __defaultScope__ Track the default scope for an custom OAuth2 Scope.
 * __deployedAppliances__ Track which appliances are deployed at an organization.
 * __federationRules__ Track rules for the federation in Gluu SAML config. Deprecated as multi-party federation management should move to Jagger.
 * __gluuAddPersonCapability__ Organizational attribute to control whether new users can be added via the oxTrust GUI.
 * __gluuAdditionalBandwidth__ Track bandwidth requirements for the Gluu Server instance
 * __gluuAdditionalMemory__ Track additional memory requirements for the Gluu Server instance.
 * __gluuAdditionalUsers__ TODO : use unclear
 * __gluuApplianceDnsServer__ Persist the DNS server that should be used for the Gluu Server instance.
 * __gluuAppliancePollingInterval__ Set the frequency of the health status update of the Gluu Server
 * __gluuBillingEmail__ Billing Alert Email Address
 * __gluuCentreonEmail__ Centreon Alert Email Address
 * __gluuJiraEmail__ Jira Alert Email Address
 * __gluuMaxLogSize__ Maximum Log File Size
 * __gluuOptOuts__ Attributes restricted by person
 * __gluuPrivacyEmail__ Privacy Alert Email Address
 * __gluuSmtpFromEmailAddress__ SMTP From Email Address
 * __gluuSmtpFromName__ SMTP From Name
 * __gluuSmtpHost__ SMTP Host
 * __gluuSmtpPassword__ SMTP User Password
 * __gluuSmtpPort__ SMTP Port
 * __gluuSmtpRequiresAuthentication__ SMTP Requires Authentication
 * __gluuSmtpRequiresSsl__ SMTP Requires SSL
 * __gluuSmtpUserName__ SMTP User Name
 * __gluuSvnEmail__ SVN Alert Email Address
 * __gluuWhitePagesListed__ Allow Publication
 * __inum__ XRI i-number
 * __inumFN__ XRI i-number sans punctuation
 * __literalBinaryValue__ OX literalValue
 * __literalValue__ OX literalValue
 * __myCustomAttr1__ MyCustomAttribute1
 * __myCustomAttr2__ MyCustomAttribute2
 * __organizationalOwner__ OX organizationalOwner
 * __oxAmHost__ am host
 * __oxAttributeType__ NameId or attribute
 * __oxAuthAppType__ oxAuth App Type
 * __oxAuthAuthenticationTime__ oxAuth Authentication Time
 * __oxAuthAuthorizationCode__ oxAuth authorization code
 * __oxAuthClaim__ oxAuth Attribute Claim
 * __oxAuthClientId__ oxAuth Client id
 * __oxAuthClientIdIssuedAt__ oxAuth Client Issued At
 * __oxAuthClientSecret__ oxAuth Client Secret
 * __oxAuthClientSecretExpiresAt__ Date client expires
 * __oxAuthClientURI__ oxAuth Client URI
 * __oxAuthClientUserGroup__ oxAuth Client User group
 * __oxAuthConfCustomAuthMethod__ Custom authentication method
 * __oxAuthConfDynamic__ oxAuth Dynamic Configuration
 * __oxAuthConfErrors__ oxAuth Errors Configuration
 * __oxAuthConfIdPythonScript__ Custom id generation
 * __oxAuthConfLdapAuth__ LDAP authentication configuration
 * __oxAuthConfStatic__ oxAuth Static Configuration
 * __oxAuthConfWebKeys__ oxAuth Web Keys Configuration
 * __oxAuthContact__ oxAuth Contact
 * __oxAuthCreation__ oxAuth Creation
 * __oxAuthDefaultAcrValues__ oxAuth Default Acr Values
 * __oxAuthDefaultMaxAge__ oxAuth Default Max Age
 * __oxAuthExpiration__ oxAuth Expiration
 * __oxAuthFederationId__ oxAuth Federation ID attribute
 * __oxAuthFederationMetadata__ oxAuth Federation metadata attribute
 * __oxAuthFederationMetadataIntervalCheck__ oxAuth Federation metadata interval check attribute
 * __oxAuthFederationMetadataURI__ oxAuth Federation metadata URI attribute
 * __oxAuthFederationOP__ oxAuth Federation OP attribute
 * __oxAuthFederationOpDomain__ oxAuth Federation OP domain attribute
 * __oxAuthFederationOpId__ oxAuth Federation OP ID attribute
 * __oxAuthFederationRP__ oxAuth Federation RP attribute
 * __oxAuthFederationRequestType__ oxAuth Federation request type attribute
 * __oxAuthFederationTrustStatus__ oxAuth Federation Trust Status attribute
 * __oxAuthGrantId__ oxAuth grant id
 * __oxAuthGrantType__ oxAuth Grant Type
 * __oxAuthIdTokenEncryptedResponseAlg__ oxAuth ID Token Encrypted Response Alg
 * __oxAuthIdTokenEncryptedResponseEnc__ oxAuth ID Token Encrypted Response Enc
 * __oxAuthIdTokenSignedResponseAlg__ oxAuth ID Token Signed Response Alg
 * __oxAuthInitiateLoginURI__ oxAuth Initiate Login URI
 * __oxAuthJwksURI__ oxAuth JWKs URI
 * __oxAuthJwtRequest__ oxAuth JWT Request
 * __oxAuthLogoURI__ oxAuth Logo URI
 * __oxAuthNonce__ oxAuth nonce
 * __oxAuthPermissionGranted__ oxAuth Permission Granted
 * __oxAuthPermissionGrantedMap__ oxAuth Permission Granted Map
 * __oxAuthPersistentJWT__ oxAuth Persistent JWT
 * __oxAuthPolicyURI__ oxAuth Policy URI
 * __oxAuthPostLogoutRedirectURI__ oxAuth Post Logout Redirect URI
 * __oxAuthRedirectURI__ oxAuth Redirect URI
 * __oxAuthRegistrationAccessToken__ oxAuth Registration Access Token
 * __oxAuthReleasedScope__ oxAuth released scope attribute
 * __oxAuthRequestObjectSigningAlg__ oxAuth Request Object Signing Alg
 * __oxAuthRequestURI__ oxAuth Request URI
 * __oxAuthRequireAuthTime__ oxAuth Require Authentication Time
 * __oxAuthResponseType__ oxAuth Response Type
 * __oxAuthScope__ oxAuth Attribute Scope
 * __oxAuthSectorIdentifierURI__ oxAuth Sector Identifier URI
 * __oxAuthSignedResponseAlg__ oxAuth Signed Response Alg
 * __oxAuthSkipAuthorization__ oxAuth skip authorization attribute
 * __oxAuthSubjectType__ oxAuth Subject Type
 * __oxAuthTokenCode__ oxAuth Token Code
 * __oxAuthTokenEndpointAuthMethod__ oxAuth Token Endpoint Auth Method
 * __oxAuthTokenType__ oxAuth Token Type
 * __oxAuthTosURI__ oxAuth TOS URI
 * __oxAuthTrustedClient__ oxAuth Trusted Client
 * __oxAuthUmaScope__ URI reference of scope descriptor
 * __oxAuthUserDN__ oxAuth User DN
 * __oxAuthUserId__ oxAuth user id
 * __oxAuthUserInfoEncryptedResponseAlg__ oxAuth User Info Encrypted Response Alg
 * __oxAuthUserInfoEncryptedResponseEnc__ oxAuth User Info Encrypted Response Enc
 * __oxAuthX509PEM__ oxAuth x509 in PEM format
 * __oxAuthX509URL__ oxAuth x509 URL
 * __oxClusterType__ Type of the underlying clustering mechanism
 * __oxClusteredServers__ List of the clustering partners of this server
 * __oxConfigurationCode__ ox configuration code
 * __oxCreationTimestamp__ Registration time
 * __oxDomain__ domain
 * __oxFaviconImage__ URI for a graphic icon
 * __oxGroup__ User group
 * __oxGuid__ A random string to mark temporary tokens
 * __oxHost__ ox host
 * __oxIDPAuthentication__ Custom IDP authentication configuration
 * __oxIconUrl__ ox icon url
 * __oxId__ Identifier
 * __oxInviteCode__ Invite Code
 * __oxLastAccessTime__ Last access time
 * __oxLastLogonTime__ Last logon time
 * __oxLinkCreator__ Link Creator
 * __oxLinkExpirationDate__ Link Expiration Date
 * __oxLinkLinktrack__ Linktrack link
 * __oxLinkModerated__ Is Link Moderated?
 * __oxLinkModerators__ Link Moderators
 * __oxLinkPending__ Pending Registrations
 * __oxLinktrackEnabled__ Is Linktrack API configured
 * __oxLinktrackLogin__ Linktrack API login
 * __oxLinktrackPassword__ Linktrack API password
 * __oxLogViewerConfig__ Log viewer configuration
 * __oxMemcachedServerAddress__ Initialization string for memcached client
 * __oxName__ Name
 * __oxNameIdType__ NameId Type
 * __oxPolicyRule__ Revision
 * __oxPolicyScript__ ox policy script
 * __oxProxConf__ oxProx Configuration
 * __oxProxyAccessToken__ oxProx access token
 * __oxProxyClaimMapping__ oxProx claim mapping
 * __oxProxyClientId__ oxProx client id
 * __oxProxyScope__ oxProx scope
 * __oxProxyToOpClientMapping__ oxProx client mapping to op client
 * __oxPushApplication__ oxPush application DN
 * __oxPushApplicationConf__ oxPush application configuration
 * __oxPushDeviceConf__ oxPush device configuration
 * __oxRegistrationConfiguration__ Registration Configuration
 * __oxResource__ Host path
 * __oxResourceSetId__ ox resource set id
 * __oxRevision__ Revision
 * __oxScript__ Attribute that contains script (python, java script)
 * __oxScriptDn__ Script object DN
 * __oxScriptType__ Attribute that contains script type (e.g. python, java script)
 * __oxSmtpConfiguration__ SMTP configuration
 * __oxSourceAttribute__ Source Attribute for this Attribute
 * __oxTicket__ ox ticket
 * __oxTrustConfApplication__ oxTrust Application Configuration
 * __oxTrustCustAttrB__ scim status
 * __oxTrustStoreCert__ oxPush device configuration
 * __oxTrustStoreConf__ oxPush application configuration
 * __oxType__ ox type
 * __oxUmaPermission__ ox uma permission
 * __oxUrl__ ox url
 * __oxX509PEM__ x509 in PEM format
 * __oxX509URL__ x509 URL
 * __passwordResetAllowed__ Is password reset mechanics allowed
 * __persistentId__ PersistentId
 * __personInum__ Inum of a person
 * __primaryKeyAttrName__ Primary Key Attribute Name
 * __primaryKeyValue__ Primary Key Value
 * __programmingLanguage__ programming language
 * __registrationDate__ Registration date
 * __role__ Role
 * __scimAuthMode__ SCIM Authorization mode
 * __scimGroup__ scim Group
 * __scimStatus__ scim status
 * __secondaryKeyAttrName__ Secondary Key Attribute Name
 * __secondaryKeyValue__ Secondary Key Value
 * __secretAnswer__ Secret Answer
 * __secretQuestion__ Secret Question
 * __sourceRelationalXdiStatement__ OX SourceRelationalXdiStatement
 * __targetRelationalXdiStatement__ OX TargetRelationalXdiStatement
 * __tertiaryKeyAttrName__ Tertiary Key Attribute Name
 * __tertiaryKeyValue__ Tertiary Key Value
 * __transientId__ TransientId
 * __x__ OX XRI Component
 * __xdiStatement__ OX xdiStatement
 * __xri__ OX XRI address
 * __middleName oxTrustMiddleName__ Middle name(s)
 * __nickname oxTrustnickname__ Casual name of the End-User
 * __preferredUsername__ Shorthand Name
 * __profile__ Profile page URL of the person
 * __picture photo1__ Profile picture URL of the person
 * __website__ Web page or blog URL of the person
 * __emailVerified__ True if the e-mail address of the person has been verified; otherwise false
 * __gender__ Gender of the person either female or male
 * __birthdate__ Birthday of the person, represented as an ISO 8601:2004 [ISO8601‑2004] YYYY-MM-DD format
 * __zoneinfo timezone__ time zone database representing the End-User
 * __locale oxTrustLocale__ Locale of the person, represented as a BCP47 [RFC5646] language tag
 * __phoneNumberVerified__ True if the phone number of the person has been verified, otherwise false
 * __address__ OpenID Connect formatted JSON object representing the address of the person
 * __updatedAt__ Time the information of the person was last updated. Seconds from 1970-01-01T0:0:0Z
## Objectclasses 
 * __gluuPerson__ 
    * associatedClient
    * c
    * displayName
    * givenName
    * gluuManagedOrganizations
    * gluuOptOuts
    * gluuStatus
    * gluuWhitePagesListed
    * iname
    * inum
    * mail
    * memberOf
    * o
    * oxAuthPersistentJWT
    * oxCreationTimestamp
    * oxExternalUid
    * oxInviteCode
    * oxLastLogonTime
    * oxTrustActive
    * oxTrustAddresses
    * oxTrustEmail
    * oxTrustEntitlements
    * oxTrustExternalId
    * oxTrustImsValue
    * 
    * oxTrustMetaCreated
    * oxTrustMetaLastModified
    * oxTrustMetaLocation
    * oxTrustMetaVersion
    * oxTrustNameFormatted
    * oxTrustPhoneValue
    * oxTrustPhotos
    * oxTrustProfileURL
    * oxTrustRole
    * oxTrustTitle
    * oxTrustUserType
    * oxTrusthonorificPrefix
    * oxTrusthonorificSuffix
    * oxTrustx509Certificate
    * persistentId
    * middleName
    * nickname
    * preferredUsername
    * profile
    * picture
    * website
    * emailVerified
    * gender
    * birthdate
    * zoneinfo
    * locale
    * phoneNumberVerified
    * address
    * updatedAt
    * preferredLanguage
    * role
    * secretAnswer
    * secretQuestion
    * seeAlso
    * sn
    * 
    * transientId
    * uid
    * userPassword
 * __gluuGroup__ 
    * c
    * description
    * displayName
    * gluuGroupType
    * gluuGroupVisibility
    * gluuStatus
    * iname
    * inum
    * member
    * o
    * owner
    * seeAlso
 * __gluuOrganization__ 
    * c
    * county
    * deployedAppliances
    * description
    * displayName
    * gluuAddPersonCapability
    * gluuAdditionalUsers
    * gluuApplianceUpdateReuestList
    * gluuCustomMessage
    * gluuFaviconImage
    * gluuFederationHostingEnabled
    * gluuInvoiceNo
    * gluuLogoImage
    * gluuManageIdentityPermission
    * gluuManager
    * gluuManagerGroup
    * gluuOrgProfileMgt
    * gluuOrgShortName
    * gluuOwnerGroup
    * gluuPaidUntil
    * gluuPaymentProcessorTimestamp
    * gluuProStoresUser
    * gluuStatus
    * gluuTempFaviconImage
    * gluuThemeColor
    * gluuWhitePagesEnabled
    * iname
    * inum
    * l
    * mail
    * memberOf
    * nonProfit
    * o
    * objectClass
    * oxCreationTimestamp
    * oxLinkLinktrack
    * oxLinktrackEnabled
    * oxLinktrackLogin
    * oxLinktrackPassword
    * oxRegistrationConfiguration
    * postalCode
    * proStoresToken
    * prostoresTimestamp
    * scimAuthMode
    * scimGroup
    * scimStatus
    * st
    * street
    * telephoneNumber
    * title
    * uid
    * userPassword
 * __gluuAppliance__ 
    * blowfishPassword
    * c
    * description
    * displayName
    * gluuAdditionalBandwidth
    * gluuAdditionalMemory
    * gluuApplianceDnsServer
    * gluuAppliancePollingInterval
    * gluuBandwidthRX
    * gluuBandwidthTX
    * gluuBillingEmail
    * gluuCentreonEmail
    * gluuDSstatus
    * gluuFederationHostingEnabled
    * gluuFreeDiskSpace
    * gluuFreeMemory
    * gluuFreeSwap
    * gluuGroupCount
    * gluuHTTPstatus
    * gluuHostname
    * gluuInvoiceNo
    * gluuIpAddress
    * gluuJiraEmail
    * gluuLastUpdate
    * gluuLifeRay
    * gluuLoadAvg
    * gluuManageIdentityPermission
    * gluuManager
    * gluuMaxLogSize
    * gluuOrgProfileMgt
    * gluuPaidUntil
    * gluuPaymentProcessorTimestamp
    * gluuPersonCount
    * gluuPrivacyEmail
    * gluuPrivate
    * gluuPublishIdpMetadata
    * gluuResizeInitiated
    * gluuSPTR
    * gluuScimEnabled
    * gluuShibAssertionsIssued
    * gluuShibFailedAuth
    * gluuShibSecurityEvents
    * gluuShibSuccessfulAuths
    * gluuSmtpFromEmailAddress
    * gluuSmtpFromName
    * gluuSmtpHost
    * gluuSmtpPassword
    * gluuSmtpPort
    * gluuSmtpRequiresAuthentication
    * gluuSmtpRequiresSsl
    * gluuSmtpUserName
    * gluuSslExpiry
    * gluuStatus
    * gluuSvnEmail
    * gluuSystemUptime
    * gluuTargetRAM
    * gluuUrl
    * gluuVDSenabled
    * gluuVDSstatus
    * gluuVdsCacheRefreshEnabled
    * gluuVdsCacheRefreshLastUpdate
    * gluuVdsCacheRefreshLastUpdateCount
    * gluuVdsCacheRefreshPollingInterval
    * gluuVdsCacheRefreshProblemCount
    * gluuWhitePagesEnabled
    * iname
    * inum
    * inumFN
    * o
    * oxAuthenticationLevel
    * oxAuthenticationMode
    * oxClusterType
    * oxClusteredServers
    * oxIDPAuthentication
    * oxLogViewerConfig
    * oxMemcachedServerAddress
    * oxSmtpConfiguration
    * oxTrustStoreCert
    * oxTrustStoreConf
    * passwordResetAllowed
    * softwareVersion
    * userPassword
 * __gluuAttribute__ 
    * description
    * displayName
    * gluuAttributeEditType
    * gluuAttributeName
    * gluuAttributeOrigin
    * gluuAttributePrivacyLevel
    * gluuAttributeSystemEditType
    * gluuAttributeType
    * gluuAttributeUsageType
    * gluuAttributeViewType
    * gluuCategory
    * gluuSAML1URI
    * gluuSAML2URI
    * gluuStatus
    * iname
    * inum
    * objectClass
    * oxAttributeType
    * oxMultivaluedAttribute
    * oxNameIdType
    * oxSCIMCustomAttribute
    * oxSourceAttribute
    * seeAlso
    * urn
    * gluuLdapAttributeName
 * __gluuSAMLconfig__ 
    * description
    * displayName
    * federationRules
    * gluuContainerFederation
    * gluuEntityId
    * gluuIsFederation
    * gluuProfileConfiguration
    * gluuReleasedAttribute
    * gluuRulesAccepted
    * gluuSAMLMetaDataFilter
    * gluuSAMLTrustEngine
    * gluuSAMLmaxRefreshDelay
    * gluuSAMLspMetaDataFN
    * gluuSAMLspMetaDataSourceType
    * gluuSAMLspMetaDataURL
    * gluuSpecificRelyingPartyConfig
    * gluuStatus
    * gluuTrustContact
    * gluuTrustDeconstruction
    * gluuValidationLog
    * gluuValidationStatus
    * iname
    * inum
    * o
    * objectClass
    * oxAuthPostLogoutRedirectURI
    * url
 * __gluuInumMap__ 
    * gluuStatus
    * inum
    * primaryKeyAttrName
    * primaryKeyValue
    * secondaryKeyAttrName
    * secondaryKeyValue
    * tertiaryKeyAttrName
    * tertiaryKeyValue
 * __gluuInvoice__ 
    * gluuInvoiceAmount
    * gluuInvoiceDate
    * gluuInvoiceLineItemName
    * gluuInvoiceNumber
    * gluuInvoiceProductNumber
    * gluuInvoiceQuantity
    * gluuInvoiceStatus
    * inum
 * __gluuPasswordResetRequest__ 
    * creationDate
    * oxGuid
    * personInum
 * __oxLink__ 
    * description
    * oxGuid
    * oxLinkCreator
    * oxLinkExpirationDate
    * oxLinkLinktrack
    * oxLinkModerated
    * oxLinkModerators
    * oxLinkPending
 * __vdapcontainer__ 
    * ou
 * __vdDirectoryView__ 
    * o
 * __vdlabel__ 
    * o
 * __oxEntry__ 
    * displayName
    * iname
    * inum
 * __oxNode__ 
    * organizationalOwner
    * owner
    * sourceRelationalXdiStatement
    * targetRelationalXdiStatement
    * x
    * xdiStatement
    * xri
 * __oxAuthClient__ 
    * associatedPerson
    * displayName
    * inum
    * oxAuthAppType
    * oxAuthClientIdIssuedAt
    * oxAuthClientSecret
    * oxAuthClientSecretExpiresAt
    * oxAuthClientURI
    * oxAuthClientUserGroup
    * oxAuthContact
    * oxAuthDefaultAcrValues
    * oxAuthDefaultMaxAge
    * oxAuthFederationId
    * oxAuthFederationMetadataURI
    * oxAuthGrantType
    * oxAuthIdTokenEncryptedResponseAlg
    * oxAuthIdTokenEncryptedResponseEnc
    * oxAuthIdTokenSignedResponseAlg
    * oxAuthInitiateLoginURI
    * oxAuthJwksURI
    * oxAuthLogoURI
    * oxAuthPolicyURI
    * oxAuthPostLogoutRedirectURI
    * oxAuthRedirectURI
    * oxAuthRegistrationAccessToken
    * oxAuthRequestObjectSigningAlg
    * oxAuthRequestURI
    * oxAuthRequireAuthTime
    * oxAuthResponseType
    * oxAuthScope
    * oxAuthSectorIdentifierURI
    * oxAuthSignedResponseAlg
    * oxAuthSubjectType
    * oxAuthTokenEndpointAuthMethod
    * oxAuthTosURI
    * oxAuthTrustedClient
    * oxAuthUserInfoEncryptedResponseAlg
    * oxAuthUserInfoEncryptedResponseEnc
    * oxLastAccessTime
    * oxLastLogonTime
 * __oxAuthCustomScope__ 
    * defaultScope
    * description
    * displayName
    * inum
    * oxAuthClaim
 * __oxAuthFederationRP__ 
    * displayName
    * inum
    * oxAuthRedirectURI
    * oxAuthX509PEM
    * oxAuthX509URL
 * __oxAuthFederationOP__ 
    * displayName
    * inum
    * oxAuthFederationOpDomain
    * oxAuthFederationOpId
    * oxAuthX509PEM
    * oxAuthX509URL
 * __oxAuthFederationMetadata__ 
    * displayName
    * inum
    * oxAuthFederationMetadataIntervalCheck
    * oxAuthFederationOP
    * oxAuthFederationRP
    * oxAuthRedirectURI
 * __oxAuthFederationRequest__ 
    * displayName
    * inum
    * oxAuthFederationOpDomain
    * oxAuthFederationOpId
    * oxAuthFederationRequestType
    * oxAuthRedirectURI
 * __oxAuthFederationTrust__ 
    * displayName
    * inum
    * oxAuthFederationId
    * oxAuthFederationMetadataURI
    * oxAuthFederationTrustStatus
    * oxAuthRedirectURI
    * oxAuthReleasedScope
    * oxAuthSkipAuthorization
 * __oxAuthSessionId__ 
    * lastModifiedTime
    * oxAuthAuthenticationTime
    * oxAuthPermissionGranted
    * oxAuthPermissionGrantedMap
    * oxAuthUserDN
    * uniqueIdentifier
 * __oxAuthConfiguration__ 
    * ou
    * oxAuthConfCustomAuthMethod
    * oxAuthConfDynamic
    * oxAuthConfErrors
    * oxAuthConfIdPythonScript
    * oxAuthConfLdapAuth
    * oxAuthConfStatic
    * oxAuthConfWebKeys
 * __oxTrustConfiguration__ 
    * ou
    * oxTrustConfApplication
 * __oxAuthUmaResourceSet__ 
    * displayName
    * inum
    * owner
    * oxAssociatedClient
    * oxAuthUmaScope
    * oxFaviconImage
    * oxGroup
    * oxId
    * oxResource
    * oxRevision
    * oxType
 * __oxAuthUmaScopeDescription__ 
    * displayName
    * inum
    * owner
    * oxFaviconImage
    * oxIconUrl
    * oxId
    * oxPolicyRule
    * oxRevision
    * oxType
    * oxUrl
 * __oxAuthUmaResourceSetPermission__ 
    * oxAmHost
    * oxAuthExpiration
    * oxAuthUmaScope
    * oxConfigurationCode
    * oxHost
    * oxResourceSetId
    * oxTicket
 * __oxAuthToken__ 
    * createTimestamp
    * oxAuthAuthenticationTime
    * oxAuthAuthorizationCode
    * oxAuthCreation
    * oxAuthExpiration
    * oxAuthGrantId
    * oxAuthGrantType
    * oxAuthJwtRequest
    * oxAuthNonce
    * oxAuthScope
    * oxAuthTokenCode
    * oxAuthTokenType
    * oxAuthUserId
    * oxAuthenticationLevel
    * oxAuthenticationMode
    * uniqueIdentifier
 * __oxAuthUmaRPT__ 
    * oxAmHost
    * oxAuthAuthenticationTime
    * oxAuthClientId
    * oxAuthCreation
    * oxAuthExpiration
    * oxAuthTokenCode
    * oxAuthUserId
    * oxUmaPermission
    * uniqueIdentifier
 * __oxAuthUmaPolicy__ 
    * description
    * displayName
    * inum
    * oxAuthUmaScope
    * oxPolicyScript
    * programmingLanguage
 * __oxLiteralNode__ 
    * literalBinaryValue
    * literalValue
    * organizationalOwner
    * owner
    * targetRelationalXdiStatement
    * x
    * xdiStatement
    * xri
 * __oxProxConfiguration__ 
    * ou
    * oxProxConf
    * oxScriptDn
 * __oxProxOp__ 
    * c
    * displayName
    * inum
    * l
    * oxDomain
    * oxId
    * oxX509PEM
    * oxX509URL
 * __oxProxClient__ 
    * displayName
    * inum
    * oxProxyClaimMapping
    * oxProxyScope
    * oxProxyToOpClientMapping
 * __oxProxAccessToken__ 
    * oxAuthCreation
    * oxAuthExpiration
    * oxProxyAccessToken
    * oxProxyClientId
 * __oxScript__ 
    * inum
    * oxScript
    * oxScriptType
 * __oxPushApplication__ 
    * displayName
    * oxId
    * oxName
    * oxPushApplicationConf
 * __oxPushDevice__ 
    * oxAuthUserId
    * oxId
    * oxPushApplication
    * oxPushDeviceConf
    * oxType


