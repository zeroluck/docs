# Schema

## Objectclasses

| Objectclass                    | Description                               | Used by Applications |
| ------------------------------ | ----------------------------------------- | -------------------- |
| gluuPerson                     | Basic person attributes                   | oxAuth, oxTrust      | 
| gluuGroup                      | Group attributes                          | oxAuth, oxTrust      |
| gluuOrganization               | Organization attributes                   | oxTrust              |
| gluuAppliance                  | Configuration of Gluu Server Instance     | oxAuth, oxTrust      |
| gluuAttribute                  | Metadata about user claims (attributes)   | oxTrust, oxAuth      |
| gluuSAMLconfig                 | SAML Trust relationship data              | oxTrust              |
| gluuInumMap                    |                                           |                      |
| gluuInvoice                    |                                           |                      |
| gluuPasswordResetRequest       |                                           |                      |
| oxLink                         |                                           |                      |
| vdapcontainer                  | Deprecated                                |                      |
| vdDirectoryView                | Deprecated                                |                      |
| vdlabel                        | Deprecated                                |                      |
| oxEntry                        |                                           |                      |
| oxNode                         |                                           |                      |
| oxAuthClient                   |                                           |                      |
| oxAuthCustomScope              |                                           |                      |
| oxAuthFederationRP             |                                           |                      |
| oxAuthFederationOP             |                                           |                      |
| oxAuthFederationMetadata       |                                           |                      |
| oxAuthFederationRequest        |                                           |                      |
| oxAuthFederationTrust          |                                           |                      |
| oxAuthSessionId                |                                           |                      |
| oxAuthConfiguration            |                                           |                      |
| oxTrustConfiguration           |                                           |                      |
| oxAuthUmaResourceSet           |                                           |                      |
| oxAuthUmaScopeDescription      |                                           |                      |
| oxAuthUmaResourceSetPermission |                                           |                      |
| oxAuthToken                    |                                           |                      |
| oxAuthUmaRPT                   |                                           |                      |
| oxAuthUmaPolicy                |                                           |                      |
| oxLiteralNode                  |                                           |                      |
| oxProxConfiguration            |                                           |                      |
| oxProxOp                       |                                           |                      |
| oxProxClient                   |                                           |                      |
| oxProxAccessToken              |                                           |                      |
| oxScript                       |                                           |                      |

## Attributes

These are the ldap attribute in use by the Gluu Server

| Attribute Name                     | Description                                  | Used By                  |
| ---------------------------------- | -------------------------------------------- | ------------------------ |
| associatedClient                   | Reference to the DN of a client object       | oxAuth, oxTrust          |
| associatedPerson                   |                                              |                          |
| blowfishPassword                   |                                              |                          |
| county                             |                                              |                          |
| creationDate                       |                                              |                          |
| defaultScope                       |                                              |                          |
| deployedAppliances                 |                                              |                          |
| federationRules                    |                                              |                          |
| gluuAddPersonCapability            |                                              |                          |
| gluuAdditionalBandwidth            |                                              |                          |
| gluuAdditionalMemory               |                                              |                          |
| gluuAdditionalUsers                |                                              |                          |
| gluuApplianceDnsServer             |                                              |                          |
| gluuAppliancePollingInterval       |                                              |                          |
| gluuApplianceUpdateReuestList      |                                              |                          |
| gluuAttributeEditType              |                                              |                          |
| gluuAttributeName                  |                                              |                          |
| gluuAttributeOrigin                |                                              |                          |
| gluuAttributePrivacyLevel          |                                              |                          |
| gluuAttributeSystemEditType        |                                              |                          |
| gluuAttributeType                  |                                              |                          |
| gluuAttributeUsageType             |                                              |                          |
| gluuAttributeViewType              |                                              |                          |
| gluuBandwidthRX                    |                                              |                          |
| gluuBandwidthTX                    |                                              |                          |
| gluuBillingEmail                   |                                              |                          |
| gluuCategory                       |                                              |                          |
| gluuCentreonEmail                  |                                              |                          |
| gluuContainerFederation            |                                              |                          |
| gluuCustomMessage                  |                                              |                          |
| gluuDSstatus                       |                                              |                          |
| gluuEntityId                       |                                              |                          |
| gluuFaviconImage                   |                                              |                          |
| gluuFederationHostingEnabled       |                                              |                          |
| gluuFreeDiskSpace                  |                                              |                          |
| gluuFreeMemory                     |                                              |                          |
| gluuFreeSwap                       |                                              |                          |
| gluuGroupCount                     |                                              |                          |
| gluuGroupType                      |                                              |                          |
| gluuGroupVisibility                |                                              |                          |
| gluuHTTPstatus                     |                                              |                          |
| gluuHostname                       |                                              |                          |
| gluuInvoiceAmount                  |                                              |                          |
| gluuInvoiceDate                    |                                              |                          |
| gluuInvoiceLineItemName            |                                              |                          |
| gluuInvoiceNo                      |                                              |                          |
| gluuInvoiceNumber                  |                                              |                          |
| gluuInvoiceProductNumber           |                                              |                          |
| gluuInvoiceQuantity                |                                              |                          |
| gluuInvoiceStatus                  |                                              |                          |
| gluuIpAddress                      |                                              |                          |
| gluuIsFederation                   |                                              |                          |
| gluuJiraEmail                      |                                              |                          |
| gluuLastUpdate                     |                                              |                          |
| gluuLifeRay                        |                                              |                          |
| gluuLoadAvg                        |                                              |                          |
| gluuLogoImage                      |                                              |                          |
| gluuManageIdentityPermission       |                                              |                          |
| gluuManagedOrganizations           |                                              |                          |
| gluuManager                        |                                              |                          |
| gluuManagerGroup                   |                                              |                          |
| gluuMaxLogSize                     |                                              |                          |
| gluuOptOuts                        |                                              |                          |
| gluuOrgProfileMgt                  |                                              |                          |
| gluuOrgShortName                   |                                              |                          |
| gluuOwnerGroup                     |                                              |                          |
| gluuPaidUntil                      |                                              |                          |
| gluuPaymentProcessorTimestamp      |                                              |                          |
| gluuPersonCount                    |                                              |                          |
| gluuPrivacyEmail                   |                                              |                          |
| gluuPrivate                        |                                              |                          |
| gluuProStoresUser                  |                                              |                          |
| gluuProfileConfiguration           |                                              |                          |
| gluuPublishIdpMetadata             |                                              |                          |
| gluuReleasedAttribute              |                                              |                          |
| gluuResizeInitiated                |                                              |                          |
| gluuRulesAccepted                  |                                              |                          |
| gluuSAML1URI                       |                                              |                          |
| gluuSAML2URI                       |                                              |                          |
| gluuSAMLMetaDataFilter             |                                              |                          |
| gluuSAMLTrustEngine                |                                              |                          |
| gluuSAMLmaxRefreshDelay            |                                              |                          |
| gluuSAMLspMetaDataFN               |                                              |                          |
| gluuSAMLspMetaDataSourceType       |                                              |                          |
| gluuSAMLspMetaDataURL              |                                              |                          |
| gluuSLAManager                     |                                              |                          |
| gluuSPTR                           |                                              |                          |
| gluuScimEnabled                    |                                              |                          |
| gluuShibAssertionsIssued           |                                              |                          |
| gluuShibFailedAuth                 |                                              |                          |
| gluuShibSecurityEvents             |                                              |                          |
| gluuShibSuccessfulAuths            |                                              |                          |
| gluuSmtpFromEmailAddress           |                                              |                          |
| gluuSmtpFromName                   |                                              |                          |
| gluuSmtpHost                       |                                              |                          |
| gluuSmtpPassword                   |                                              |                          |
| gluuSmtpPort                       |                                              |                          |
| gluuSmtpRequiresAuthentication     |                                              |                          |
| gluuSmtpRequiresSsl                |                                              |                          |
| gluuSmtpUserName                   |                                              |                          |
| gluuSpecificRelyingPartyConfig     |                                              |                          |
| gluuSslExpiry                      |                                              |                          |
| gluuStatus                         |                                              |                          |
| gluuSvnEmail                       |                                              |                          |
| gluuSystemUptime                   |                                              |                          |
| gluuTargetRAM                      |                                              |                          |
| gluuTempFaviconImage               |                                              |                          |
| gluuThemeColor                     |                                              |                          |
| gluuTrustContact                   |                                              |                          |
| gluuTrustDeconstruction            |                                              |                          |
| gluuUrl                            |                                              |                          |
| gluuVDSenabled                     |                                              |                          |
| gluuVDSstatus                      |                                              |                          |
| gluuValidationLog                  |                                              |                          |
| gluuValidationStatus               |                                              |                          |
| gluuVdsCacheRefreshEnabled         |                                              |                          |
| gluuVdsCacheRefreshLastUpdate      |                                              |                          |
| gluuVdsCacheRefreshLastUpdateCount |                                              |                          |
| gluuVdsCacheRefreshPollingInterval |                                              |                          |
| gluuVdsCacheRefreshProblemCount    |                                              |                          |
| gluuWhitePagesEnabled              |                                              |                          |
| gluuWhitePagesListed               |                                              |                          |
| iname                              |                                              |                          |
| inum                               |                                              |                          |
| inumFN                             |                                              |                          |
| literalBinaryValue                 |                                              |                          |
| literalValue                       |                                              |                          |
| memberOf                           |                                              |                          |
| myCustomAttr1                      |                                              |                          |
| myCustomAttr2                      |                                              |                          |
| nonProfit                          |                                              |                          |
| organizationalOwner                |                                              |                          |
| oxAmHost                           |                                              |                          |
| oxAssociatedClient                 |                                              |                          |
| oxAttributeType                    |                                              |                          |
| oxAuthAppType                      |                                              |                          |
| oxAuthAuthenticationTime           |                                              |                          |
| oxAuthAuthorizationCode            |                                              |                          |
| oxAuthClaim                        |                                              |                          |
| oxAuthClientId                     |                                              |                          |
| oxAuthClientIdIssuedAt             |                                              |                          |
| oxAuthClientSecret                 |                                              |                          |
| oxAuthClientSecretExpiresAt        |                                              |                          |
| oxAuthClientURI                    |                                              |                          |
| oxAuthClientUserGroup              |                                              |                          |
| oxAuthConfCustomAuthMethod         |                                              |                          |
| oxAuthConfDynamic                  |                                              |                          |
| oxAuthConfErrors                   |                                              |                          |
| oxAuthConfIdPythonScript           |                                              |                          |
| oxAuthConfLdapAuth                 |                                              |                          |
| oxAuthConfStatic                   |                                              |                          |
| oxAuthConfWebKeys                  |                                              |                          |
| oxAuthContact                      |                                              |                          |
| oxAuthCreation                     |                                              |                          |
| oxAuthDefaultAcrValues             |                                              |                          |
| oxAuthDefaultMaxAge                |                                              |                          |
| oxAuthExpiration                   |                                              |                          |
| oxAuthFederationId                 |                                              |                          |
| oxAuthFederationMetadata           |                                              |                          |
| oxAuthFederationMetadataIntervalCheck |                                              |                          |
| oxAuthFederationMetadataURI        |                                              |                          |
| oxAuthFederationOP                 |                                              |                          |
| oxAuthFederationOpDomain           |                                              |                          |
| oxAuthFederationOpId               |                                              |                          |
| oxAuthFederationRP                 |                                              |                          |
| oxAuthFederationRequestType        |                                              |                          |
| oxAuthFederationTrustStatus        |                                              |                          |
| oxAuthGrantId                      |                                              |                          |
| oxAuthGrantType                    |                                              |                          |
| oxAuthIdTokenEncryptedResponseAlg  |                                              |                          |
| oxAuthIdTokenEncryptedResponseEnc  |                                              |                          |
| oxAuthIdTokenSignedResponseAlg     |                                              |                          |
| oxAuthInitiateLoginURI             |                                              |                          |
| oxAuthJwksURI                      |                                              |                          |
| oxAuthJwtRequest                   |                                              |                          |
| oxAuthLogoURI                      |                                              |                          |
| oxAuthNonce                        |                                              |                          |
| oxAuthPermissionGranted            |                                              |                          |
| oxAuthPermissionGrantedMap         |                                              |                          |
| oxAuthPersistentJWT                |                                              |                          |
| oxAuthPolicyURI                    |                                              |                          |
| oxAuthPostLogoutRedirectURI        |                                              |                          |
| oxAuthRedirectURI                  |                                              |                          |
| oxAuthRegistrationAccessToken      |                                              |                          |
| oxAuthReleasedScope                |                                              |                          |
| oxAuthRequestObjectSigningAlg      |                                              |                          |
| oxAuthRequestURI                   |                                              |                          |
| oxAuthRequireAuthTime              |                                              |                          |
| oxAuthResponseType                 |                                              |                          |
| oxAuthScope                        |                                              |                          |
| oxAuthSectorIdentifierURI          |                                              |                          |
| oxAuthSignedResponseAlg            |                                              |                          |
| oxAuthSkipAuthorization            |                                              |                          |
| oxAuthSubjectType                  |                                              |                          |
| oxAuthTokenCode                    |                                              |                          |
| oxAuthTokenEndpointAuthMethod      |                                              |                          |
| oxAuthTokenType                    |                                              |                          |
| oxAuthTosURI                       |                                              |                          |
| oxAuthTrustedClient                |                                              |                          |
| oxAuthUmaScope                     |                                              |                          |
| oxAuthUserDN                       |                                              |                          |
| oxAuthUserId                       |                                              |                          |
| oxAuthUserInfoEncryptedResponseAlg |                                              |                          |
| oxAuthUserInfoEncryptedResponseEnc |                                              |                          |
| oxAuthX509PEM                      |                                              |                          |
| oxAuthX509URL                      |                                              |                          |
| oxAuthenticationLevel              |                                              |                          |
| oxAuthenticationMode               |                                              |                          |
| oxClusterType                      |                                              |                          |
| oxClusteredServers                 |                                              |                          |
| oxConfigurationCode                |                                              |                          |
| oxCreationTimestamp                |                                              |                          |
| oxDomain                           |                                              |                          |
| oxExternalUid                      |                                              |                          |
| oxFaviconImage                     |                                              |                          |
| oxGroup                            |                                              |                          |
| oxGuid                             |                                              |                          |
| oxHost                             |                                              |                          |
| oxIDPAuthentication                |                                              |                          |
| oxIconUrl                          |                                              |                          |
| oxId                               |                                              |                          |
| oxInviteCode                       |                                              |                          |
| oxLastAccessTime                   |                                              |                          |
| oxLastLogonTime                    |                                              |                          |
| oxLinkCreator                      |                                              |                          |
| oxLinkExpirationDate               |                                              |                          |
| oxLinkLinktrack                    |                                              |                          |
| oxLinkModerated                    |                                              |                          |
| oxLinkModerators                   |                                              |                          |
| oxLinkPending                      |                                              |                          |
| oxLinktrackEnabled                 |                                              |                          |
| oxLinktrackLogin                   |                                              |                          |
| oxLinktrackPassword                |                                              |                          |
| oxLogViewerConfig                  |                                              |                          |
| oxMemcachedServerAddress           |                                              |                          |
| oxMultivaluedAttribute             |                                              |                          |
| oxName                             |                                              |                          |
| oxNameIdType                       |                                              |                          |
| oxPolicyRule                       |                                              |                          |
| oxPolicyScript                     |                                              |                          |
| oxProxConf                         |                                              |                          |
| oxProxyAccessToken                 |                                              |                          |
| oxProxyClaimMapping                |                                              |                          |
| oxProxyClientId                    |                                              |                          |
| oxProxyScope                       |                                              |                          |
| oxProxyToOpClientMapping           |                                              |                          |
| oxPushApplication                  |                                              |                          |
| oxPushApplicationConf              |                                              |                          |
| oxPushDeviceConf                   |                                              |                          |
| oxRegistrationConfiguration        |                                              |                          |
| oxResource                         |                                              |                          |
| oxResourceSetId                    |                                              |                          |
| oxRevision                         |                                              |                          |
| oxSCIMCustomAttribute              |                                              |                          |
| oxScript                           |                                              |                          |
| oxScriptDn                         |                                              |                          |
| oxScriptType                       |                                              |                          |
| oxSmtpConfiguration                |                                              |                          |
| oxSourceAttribute                  |                                              |                          |
| oxTicket                           |                                              |                          |
| oxTrustActive                      |                                              |                          |
| oxTrustAddresses                   |                                              |                          |
| oxTrustConfApplication             |                                              |                          |
| oxTrustCustAttrB                   |                                              |                          |
| oxTrustEmail                       |                                              |                          |
| oxTrustEntitlements                |                                              |                          |
| oxTrustExternalId                  |                                              |                          |
| oxTrustImsValue                    |                                              |                          |
| oxTrustLocale                      |                                              |                          |
| oxTrustMetaCreated                 |                                              |                          |
| oxTrustMetaLastModified            |                                              |                          |
| oxTrustMetaLocation                |                                              |                          |
| oxTrustMetaVersion                 |                                              |                          |
| oxTrustMiddleName                  |                                              |                          |
| oxTrustNameFormatted               |                                              |                          |
| oxTrustNickName                    |                                              |                          |
| oxTrustPhoneValue                  |                                              |                          |
| oxTrustPhotos                      |                                              |                          |
| oxTrustProfileURL                  |                                              |                          |
| oxTrustRole                        |                                              |                          |
| oxTrustStoreCert                   |                                              |                          |
| oxTrustStoreConf                   |                                              |                          |
| oxTrustTitle                       |                                              |                          |
| oxTrustUserType                    |                                              |                          |
| oxTrusthonorificPrefix             |                                              |                          |
| oxTrusthonorificSuffix             |                                              |                          |
| oxTrustx509Certificate             |                                              |                          |
| oxType                             |                                              |                          |
| oxUmaPermission                    |                                              |                          |
| oxUrl                              |                                              |                          |
| oxX509PEM                          |                                              |                          |
| oxX509URL                          |                                              |                          |
| passwordResetAllowed               |                                              |                          |
| persistentId                       |                                              |                          |
| personInum                         |                                              |                          |
| photo1                             |                                              |                          |
| primaryKeyAttrName                 |                                              |                          |
| primaryKeyValue                    |                                              |                          |
| proStoresToken                     |                                              |                          |
| programmingLanguage                |                                              |                          |
| prostoresTimestamp                 |                                              |                          |
| registrationDate                   |                                              |                          |
| role                               |                                              |                          |
| scimAuthMode                       |                                              |                          |
| scimGroup                          |                                              |                          |
| scimStatus                         |                                              |                          |
| secondaryKeyAttrName               |                                              |                          |
| secondaryKeyValue                  |                                              |                          |
| secretAnswer                       |                                              |                          |
| secretQuestion                     |                                              |                          |
| softwareVersion                    |                                              |                          |
| sourceRelationalXdiStatement       |                                              |                          |
| targetRelationalXdiStatement       |                                              |                          |
| tertiaryKeyAttrName                |                                              |                          |
| tertiaryKeyValue                   |                                              |                          |
| timezone                           |                                              |                          |
| transientId                        |                                              |                          |
| url                                |                                              |                          |
| urn                                |                                              |                          |
| x                                  |                                              |                          |
| xdiStatement                       |                                              |                          |
| xri                                |                                              |                          |


## OpenDJ Schema

[Github](https://github.com/GluuFederation/community-edition-setup/tree/master/static)

## 389DS

[99ox.ldif](http://todo.github.com)

## OpenLDAP 

[ox.schema](http://todo.github.com)



