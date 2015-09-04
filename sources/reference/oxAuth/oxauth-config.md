
## oxauth-config.xml

This file consists of several sections that we explain in more detail in
the according subchapter.

The general structure of the configuration file is like that:

    <?xml version="1.0" encoding="UTF-8"?>
    <configuration>
        <appliance-inum>%(inumAppliance)s</appliance-inum>
        ...

    </configuration>

The sections are listed according to their order in the configuration file.

- [Basic settings](./configuration/basic-settings.md)

- [Server mode](./configuration/server-mode.md)

- [Update interval](./configuration/update-interval.md)

- [Supported response types](./configuration/supported-response-types.md)

- [Supported grant types](./configuration/supported-grant-types.md)

- [Supported algorithms a user can login with](./configuration/supported-algorithms-a-user-can-login-with.md)

- [Supported encryption algorithms](./configuration/supported-encryption-algorithms.md)

- [Supported ID token signing algorithms](./configuration/supported-id-token-signing-algorithms.md)


 * Supported ID token encryption algorithms

 * Supported request object signing algorithms

 * Supported request object encryption algorithms

 * Supported request object encryption encoding values

 * Supported token endpoint authentication methods

 * Supported token endpoint authentication signing algorithm values

 * Supported display values

 * Supported claim types

 * Supported claims

 * Service documentation

 * Supported locales for claims

 * Supported locales for user interfaces

 * Supported claims parameters

 * Supported request parameters

 * Supported request uri parameters

 * Required request uri registration

 * Uri for operation policy

 * Uri for type-of-service

 * Connection behaviour

 * Default signature algorithms

 * Federation availability

 * Dynamic registration of custom stuff

 * oxOpenID connect version

 * Authorization filters

 * Custom client filters

    <?xml version="1.0" encoding="UTF-8"?>
    <configuration>

        <grant-types-supported>
            <grant-type>authorization_code</grant-type>
            <grant-type>implicit</grant-type>
            <grant-type>urn:ietf:params:oauth:grant-type:jwt-bearer</grant-type>
        </grant-types-supported>

        <!-- AMR enables an OpenID Connect client to request a specific method
        of authentication -->
        <amr-values-supported>
            <!-- amr>basic</amr-->
        </amr-values-supported>

        <subject-types-supported>
            <subject-type>public</subject-type>
            <subject-type>pairwise</subject-type>
        </subject-types-supported>

        <userinfo-signing-alg-values-supported>
            <userinfo-signing-alg>HS256</userinfo-signing-alg>
            <userinfo-signing-alg>HS384</userinfo-signing-alg>
            <userinfo-signing-alg>HS512</userinfo-signing-alg>
            <userinfo-signing-alg>RS256</userinfo-signing-alg>
            <userinfo-signing-alg>RS384</userinfo-signing-alg>
            <userinfo-signing-alg>RS512</userinfo-signing-alg>
            <userinfo-signing-alg>ES256</userinfo-signing-alg>
            <userinfo-signing-alg>ES384</userinfo-signing-alg>
            <userinfo-signing-alg>ES512</userinfo-signing-alg>
        </userinfo-signing-alg-values-supported>

        <userinfo-encryption-alg-values-supported>
            <userinfo-encryption-alg>RSA1_5</userinfo-encryption-alg>
            <userinfo-encryption-alg>RSA-OAEP</userinfo-encryption-alg>
            <userinfo-encryption-alg>A128KW</userinfo-encryption-alg>
            <userinfo-encryption-alg>A256KW</userinfo-encryption-alg>
            <!--userinfo-encryption-alg>dir</userinfo-encryption-alg-->
            <!--userinfo-encryption-alg>ECDH-ES</userinfo-encryption-alg-->
            <!--userinfo-encryption-alg>ECDH-ES+A128KW</userinfo-encryption-alg-->
            <!--userinfo-encryption-alg>ECDH-ES+A256KW</userinfo-encryption-alg-->
        </userinfo-encryption-alg-values-supported>

        <userinfo-encryption-enc-values-supported>
            <userinfo-encryption-enc>A128CBC+HS256</userinfo-encryption-enc>
            <userinfo-encryption-enc>A256CBC+HS512</userinfo-encryption-enc>
            <userinfo-encryption-enc>A128GCM</userinfo-encryption-enc>
            <userinfo-encryption-enc>A256GCM</userinfo-encryption-enc>
        </userinfo-encryption-enc-values-supported>

        <id-token-signing-alg-values-supported>
            <id-token-signing-alg>HS256</id-token-signing-alg>
            <id-token-signing-alg>HS384</id-token-signing-alg>
            <id-token-signing-alg>HS512</id-token-signing-alg>
            <id-token-signing-alg>RS256</id-token-signing-alg>
            <id-token-signing-alg>RS384</id-token-signing-alg>
            <id-token-signing-alg>RS512</id-token-signing-alg>
            <id-token-signing-alg>ES256</id-token-signing-alg>
            <id-token-signing-alg>ES384</id-token-signing-alg>
            <id-token-signing-alg>ES512</id-token-signing-alg>
        </id-token-signing-alg-values-supported>

        <id-token-encryption-alg-values-supported>
            <id-token-encryption-alg>RSA1_5</id-token-encryption-alg>
            <id-token-encryption-alg>RSA-OAEP</id-token-encryption-alg>
            <id-token-encryption-alg>A128KW</id-token-encryption-alg>
            <id-token-encryption-alg>A256KW</id-token-encryption-alg>
            <!--id-token-encryption-alg>dir</id-token-encryption-alg-->
            <!--id-token-encryption-alg>ECDH-ES</id-token-encryption-alg-->
            <!--id-token-encryption-alg>ECDH-ES+A128KW</id-token-encryption-alg-->
            <!--id-token-encryption-alg>ECDH-ES+A256KW</id-token-encryption-alg-->
        </id-token-encryption-alg-values-supported>

        <id-token-encryption-enc-values-supported>
            <id-token-encryption-enc>A128CBC+HS256</id-token-encryption-enc>
            <id-token-encryption-enc>A256CBC+HS512</id-token-encryption-enc>
            <id-token-encryption-enc>A128GCM</id-token-encryption-enc>
            <id-token-encryption-enc>A256GCM</id-token-encryption-enc>
        </id-token-encryption-enc-values-supported>

        <request-object-signing-alg-values-supported>
            <request-object-signing-alg>HS256</request-object-signing-alg>
            <request-object-signing-alg>HS384</request-object-signing-alg>
            <request-object-signing-alg>HS512</request-object-signing-alg>
            <request-object-signing-alg>RS256</request-object-signing-alg>
            <request-object-signing-alg>RS384</request-object-signing-alg>
            <request-object-signing-alg>RS512</request-object-signing-alg>
            <request-object-signing-alg>ES256</request-object-signing-alg>
            <request-object-signing-alg>ES384</request-object-signing-alg>
            <request-object-signing-alg>ES512</request-object-signing-alg>
        </request-object-signing-alg-values-supported>

        <request-object-encryption-alg-values-supported>
            <request-object-encryption-alg>RSA1_5</request-object-encryption-alg>
            <request-object-encryption-alg>RSA-OAEP</request-object-encryption-alg>
            <request-object-encryption-alg>A128KW</request-object-encryption-alg>
            <request-object-encryption-alg>A256KW</request-object-encryption-alg>
            <!--request-object-encryption-alg>dir</request-object-encryption-alg-->
            <!--request-object-encryption-alg>ECDH-ES</request-object-encryption-alg-->
            <!--request-object-encryption-alg>ECDH-ES+A128KW</request-object-encryption-alg-->
            <!--request-object-encryption-alg>ECDH-ES+A256KW</request-object-encryption-alg-->
        </request-object-encryption-alg-values-supported>

        <request-object-encryption-enc-values-supported>
            <request-object-encryption-enc>A128CBC+HS256</request-object-encryption-enc>
            <request-object-encryption-enc>A256CBC+HS512</request-object-encryption-enc>
            <request-object-encryption-enc>A128GCM</request-object-encryption-enc>
            <request-object-encryption-enc>A256GCM</request-object-encryption-enc>
        </request-object-encryption-enc-values-supported>

        <token-endpoint-auth-methods-supported>
            <token-endpoint-auth-method>client_secret_basic</token-endpoint-auth-method>
            <token-endpoint-auth-method>client_secret_post</token-endpoint-auth-method>
            <token-endpoint-auth-method>client_secret_jwt</token-endpoint-auth-method>
            <token-endpoint-auth-method>private_key_jwt</token-endpoint-auth-method>
        </token-endpoint-auth-methods-supported>

        <token-endpoint-auth-signing-alg-values-supported>
            <token-endpoint-auth-signing-alg>HS256</token-endpoint-auth-signing-alg>
            <token-endpoint-auth-signing-alg>HS384</token-endpoint-auth-signing-alg>
            <token-endpoint-auth-signing-alg>HS512</token-endpoint-auth-signing-alg>
            <token-endpoint-auth-signing-alg>RS256</token-endpoint-auth-signing-alg>
            <token-endpoint-auth-signing-alg>RS384</token-endpoint-auth-signing-alg>
            <token-endpoint-auth-signing-alg>RS512</token-endpoint-auth-signing-alg>
            <token-endpoint-auth-signing-alg>ES256</token-endpoint-auth-signing-alg>
            <token-endpoint-auth-signing-alg>ES384</token-endpoint-auth-signing-alg>
            <token-endpoint-auth-signing-alg>ES512</token-endpoint-auth-signing-alg>
        </token-endpoint-auth-signing-alg-values-supported>

        <display-values-supported>
            <display-value>page</display-value>
            <!--display-value>popup</display-value-->
            <!--display-value>touch</display-value-->
            <!--display-value>wap</display-value-->
        </display-values-supported>

        <claim-types-supported>
            <claim-type>normal</claim-type>
            <!--claim-type>distributed</claim-type-->
        </claim-types-supported>

        <claims-supported>
            <claim>uid</claim>
            <claim>displayName</claim>
            <claim>givenName</claim>
            <claim>sn</claim>
            <claim>mail</claim>
        </claims-supported>

        <service-documentation>http://gluu.org/docs</service-documentation>

        <claims-locales-supported>
            <claim-locale>en</claim-locale>
            <!--claim-locale>en-GB</claim-locale-->
            <!--claim-locale>en-CA</claim-locale-->
            <!--claim-locale>fr-FR</claim-locale-->
            <!--claim-locale>fr-CA</claim-locale-->
        </claims-locales-supported>

        <ui-locales-supported>
            <ui-locale>en</ui-locale>
            <ui-locale>es</ui-locale>
            <!--ui-locale>en-GB</ui-locale-->
            <!--ui-locale>en-CA</ui-locale-->
            <!--ui-locale>fr-FR</ui-locale-->
            <!--ui-locale>fr-CA</ui-locale-->
        </ui-locales-supported>

        <claims-parameter-supported>true</claims-parameter-supported>

        <request-parameter-supported>true</request-parameter-supported>

        <request-uri-parameter-supported>true</request-uri-parameter-supported>

        <require-request-uri-registration>false</require-request-uri-registration>

        <op-policy-uri>http://ox.gluu.org/doku.php?id=oxauth:policy</op-policy-uri>

        <op-tos-uri>http://ox.gluu.org/doku.php?id=oxauth:tos</op-tos-uri>

        <authorization-code-lifetime>600</authorization-code-lifetime>
        <refresh-token-lifetime>14400</refresh-token-lifetime>
        <id-token-lifetime>3600</id-token-lifetime>
        <short-lived-access-token-lifetime>3600</short-lived-access-token-lifetime>
        <long-lived-access-token-lifetime>31536000</long-lived-access-token-lifetime>

        <!-- if session id is not used during some time then it's removed automatically.
             Lifetime in seconds, 86400 seconds = 1 day  -->
        <session-id-unused-lifetime>86400</session-id-unused-lifetime>
        <session-id-enabled>true</session-id-enabled>

        <uma-add-scopes-automatically>false</uma-add-scopes-automatically>
        <uma-requester-permission-token-lifetime>3600</uma-requester-permission-token-lifetime>
        <uma-keep-client-during-resource-set-registration>true</uma-keep-client-during-resource-set-registration>

        <!-- Clean service interval in seconds -->
        <clean-service-interval>600</clean-service-interval>

        <refresh-user-session-timeout-enabled>true</refresh-user-session-timeout-enabled>
        <refresh-user-session-timeout>1800</refresh-user-session-timeout>

        <default-signature-algorithm>RS256</default-signature-algorithm>
        <RS256-keyid>1</RS256-keyid>
        <RS384-keyid>2</RS384-keyid>
        <RS512-keyid>3</RS512-keyid>
        <ES256-keyid>4</ES256-keyid>
        <ES384-keyid>5</ES384-keyid>
        <ES512-keyid>6</ES512-keyid>

        <federation-enabled>false</federation-enabled>
        <!-- Federation check interval in seconds. Checks whether data in trusts are still valid
        (e.g.) if RP redirectUri still exist in metadata, if no then remove from trust automatically.
         86400 seconds = 24 hours -->
        <federation-check-interval>86400</federation-check-interval>
        <!--Federation skip policy values: OR, AND. Used in case there is more than one federation trust for
        given redirect_uri.-->
        <federation-skip-policy>OR</federation-skip-policy>
        <!-- Federation scope policy. Possible values: JOIN.
        Currently JOIN is the only supported value, means joining all scopes of trust list.-->
        <federation-scope-policy>JOIN</federation-scope-policy>
        <federation-signing-alg>RS512</federation-signing-alg>
        <federation-signing-kid>1</federation-signing-kid>

        <!-- Dynamic registration custom stuff -->
        <dynamic-registration-custom-object-class>oxAuthClientCustomAttributes</dynamic-registration-custom-object-class>

        <dynamic-registration-custom-attribute-supported>
            <dynamic-registration-custom-attribute>oxAuthTrustedClient</dynamic-registration-custom-attribute>
            <dynamic-registration-custom-attribute>myCustomAttr1</dynamic-registration-custom-attribute>
            <dynamic-registration-custom-attribute>myCustomAttr2</dynamic-registration-custom-attribute>
        </dynamic-registration-custom-attribute-supported>

        <oxOpenIDConnectVersion>openidconnect-1.0</oxOpenIDConnectVersion>

        <organization-inum>%(inumOrg)s</organization-inum>
        <oxID>https://%(hostname)s/oxid/service/gluu/inum</oxID>

        <dynamic-registration-enabled>true</dynamic-registration-enabled>
        <!-- Value in seconds or 0 if they do not expire -->
        <dynamic-registration-expiration-time>86400</dynamic-registration-expiration-time>

        <trusted-client-enabled>true</trusted-client-enabled>

        <auth-filters-enabled>false</auth-filters-enabled>
        <auth-filters>
            <auth-filter>
                <!--filter>(&amp;(associatedClient=*{0}*)(myPinCode={1}))</filter-->
                <filter>(&amp;(mail=*{0}*)(inum={1}))</filter>
                <!-- If bind=true oxAuth should try to bind to entry which it found by filter specified above -->
                <bind>false</bind>
                <base-dn>o=gluu</base-dn>
            </auth-filter>
            <auth-filter>
                <filter>uid={0}</filter>
                <bind>true</bind>
                <bind-password-attribute>pwd</bind-password-attribute>
                <base-dn>o=gluu</base-dn>
            </auth-filter>
        </auth-filters>

        <!-- Custom client filters to be able identify client by custom id. -->
        <client-auth-filters-enabled>false</client-auth-filters-enabled>
        <client-auth-filters>
            <client-auth-filter>
                <filter>myCustomAttr1={0}</filter>
                <base-dn>ou=clients,o=%(inumOrg)s,o=gluu</base-dn>
            </client-auth-filter>
            <!--client-auth-filter>
                <filter>(&amp;(myCustomAttr1={0})(myCustomAttr2={0}))</filter>
                <base-dn>ou=clients,o=%(inumOrg)s,o=gluu</base-dn>
            </client-auth-filter-->
        </client-auth-filters>

    </configuration>


