
## oxauth-config.xml

The configuration for oxAuth is a file in [XML format][xml]. It consists
of several sections that we explain in more detail in the according
subchapter.

The general structure of the configuration file is like that:

    <?xml version="1.0" encoding="UTF-8"?>
    <configuration>
        <appliance-inum>%(inumAppliance)s</appliance-inum>
        ...

    </configuration>

The sections are listed according to their order in the configuration file.

### Basic settings

The basic settings describe the general setup of the Gluu Server.

* `appliance-inum`: the [iNum code][inum] the appliances refer to
* `issuer`: the according hostname, or specific uri of the issuer
* `login-page`: the login page for the according hostname, or uri
* `authorization-page`: the oxAuth authorization page

```
<appliance-inum>%(inumAppliance)s</appliance-inum>
<issuer>https://%(hostname)s</issuer>
<login-page>https://%(hostname)s/oxauth/login.seam</login-page>
<authorization-page>https://%(hostname)s/oxauth/authorize.seam</authorization-page>
```

The Gluu Server allows connections via [Security Assertion Markup
Language (SAML)][saml], and an [OpenID][openid] Connect Identity
Provider that can be configured for [Single Sign-On (SSO)][sso] to any
SAML 2.0 or OpenID Connect protected application.

To do a proper single sign-on, use the following tags to specify the
endpoints the Gluu Server communicates with:

* `base-endpoint`: the remote station for basic communication
* `authorization-endpoint`: the remote station for general authorization
* `token-endpoint`: the remote station for token-based communication
* `userinfo-endpoint`: the remote station to receive user information from
* `clientinfo-endpoint`: the remote station to receive client information from
* `check-session-iframe`: the name of the [iframe][iframe] that is associated to the current session
* `end-session-endpoint`: the remote station to terminate the current session
* `jwks-uri`: the uri for authorization via [JSON Web Key Set (JWKS)][jwk]
* `registration-endpoint`: the remote station to register the connection
* `validate-token-endpoint`: the remote station to validate authorization tokens
* `federation-metadata-endpoint`: the remote station for [Active Directory Federation Services (ADFS)][adfs-wikipedia] metadata
* `federation-endpoint`: the remote station for using the [Active Directory Federation Services (ADFS)][adfs-wikipedia]
* `openid-discovery-endpoint`: the remote station for the [OpenID][openid] Discovery service 
* `openid-configuration-endpoint`: the remote station for the [OpenID][openid] configuration
* `id-generation-endpoint`: the remote station to generate the ID
* `introspection-endpoint`: the remote station for further introspection

```
<base-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1</base-endpoint>
<authorization-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/authorize</authorization-endpoint>
<token-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/token</token-endpoint>
<userinfo-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/userinfo</userinfo-endpoint>
<clientinfo-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/clientinfo</clientinfo-endpoint>
<check-session-iframe>https://%(hostname)s/oxauth/opiframe.seam</check-session-iframe>
<end-session-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/end_session</end-session-endpoint>
<jwks-uri>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/jwks</jwks-uri>
<registration-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/register</registration-endpoint>
<validate-token-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/validate</validate-token-endpoint>
<federation-metadata-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/federationmetadata</federation-metadata-endpoint>
<federation-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/federation</federation-endpoint>
<openid-discovery-endpoint>https://%(hostname)s/.well-known/webfinger</openid-discovery-endpoint>
<openid-configuration-endpoint>https://%(hostname)s/.well-known/openid-configuration</openid-configuration-endpoint>
<id-generation-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/id</id-generation-endpoint>
<introspection-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/introspection</introspection-endpoint>
```

Additionally, the Gluu Server includes an [User-Managed Access
(UMA)][uma] Authorization Server (AS) that can be used to enforce
policies for access to any API or web resource. UMA is a profile of
[OAuth2][oauth2] that is complimentary to [OpenID][openid] Connect. UMA
defines [REST][rest]ful, [JSON][json]-based, standardized flows and
constructs for access management. Use this tag to configure the
according endpoint:

* `uma-configuration-endpoint`: uri that defines the endpoint

```
<uma-configuration-endpoint>https://%(hostname)s/oxauth/seam/resource/restv1/oxauth/uma-configuration</uma-configuration-endpoint>
```

### Server mode

This entry sets the mode of the Gluu oxAuth Server. Possible modes are
`memory` and `ldap`.

* memory: run the oxAuth server in `in-memory` mode.

* ldap: run the oxAuth server in `ldap` mode. This is required to work
  in cluster, and this is the default setting.

```
<mode>ldap</mode>
```

### Update interval

This entry sets the value for the interval the configuration is updated
from the LDAP server. The value represents the interval in seconds
whereas 3600 seconds represent 1 hour.

```
<configuration-update-interval>3600</configuration-update-interval>
```

### Supported response types

This entry defines the various response types that are supported by the
Gluu Server. The following combinations are possible:

* `code`: Authorization Code Grant Type
* `token`: Implicit Grant Type
* `id_token`: ID Token
* `code id_token`: Authorization Code Grant Type and Implicit Grant Type
* `token id_token`: Implicit Grant Type and ID Token
* `code token`: Authorization Code Grant Type and Implicit Grant Type
* `code token id_token`: Authorization Code Grant Type, Implicit Grant Type, and ID Token

To enable the desired combinations from the list above activate the
according tag `response-type`:

```
<response-types-supported>
    <response-type>code</response-type>
    <response-type>token</response-type>
    <response-type>id_token</response-type>
    <response-type>code id_token</response-type>
    <response-type>token id_token</response-type>
    <response-type>code token</response-type>
    <response-type>code token id_token</response-type>
</response-types-supported>
```

### Supported grant types

These grant types are supported:

* `authorization_code`: use an authorization code as grant as described in [oxwiki-authorization]
* `implicit`:
* `client_credentials`:
* `refresh_token`: as described in [OAuth 2.0][rfc6749]
* `urn:ietf:params:oauth:grant-type:jwt-bearer`:

The last entry from the list above refers to JSON Web Token (JWT)
Profile for OAuth 2.0 Client Authentication and Authorization Grants as
described in the according [IETF document][ietf-jwk].

```
<grant-types-supported>
    <grant-type>authorization_code</grant-type>
    <grant-type>implicit</grant-type>
    <grant-type>urn:ietf:params:oauth:grant-type:jwt-bearer</grant-type>
</grant-types-supported>
```

### Support for Authentication Methods References (AMR)

AMR abbreviates the term Authentication Methods References. In general,
it is a [JSON][json] array of case sensitive strings that are
identifiers for authentication methods used in the authentication. In
this specific case, AMR enables an [OpenID][openid] Connect client to
request a specific method of authentication, and is turned off by
default.

```
<amr-values-supported>
    <!-- amr>basic</amr-->
</amr-values-supported>
```

### Supported subject types

This entry defines the supported subject types. Possible values are
`public` and `pairwise`.

```
<subject-types-supported>
    <subject-type>public</subject-type>
    <subject-type>pairwise</subject-type>
</subject-types-supported>
```

### Supported algorithms a user can login with

Currently, the Gluu Server supports these algorithms for login
procedures:

* HS256: [HMAC][hmac] using [SHA-256][sha2] hash algorithm.
* HS384: [HMAC][hmac] using [SHA-384][sha2] hash algorithm.
* HS512: [HMAC][hmac] using [SHA-512][sha2] hash algorithm.
* RS256: [RSASSA-PKCS-v1_5][rsassa] using [SHA-256][sha2] hash algorithm.
* RS384: [RSASSA-PKCS-v1_5][rsassa] using [SHA-384][sha2] hash algorithm.
* RS512: [RSASSA-PKCS-v1_5][rsassa] using [SHA-512][sha2] hash algorithm.
* ES256: [ECDSA][ecdsa] using P-256 curve and [SHA-256][sha2] hash algorithm.
* ES384: [ECDSA][ecdsa] using P-384 curve and [SHA-384][sha2] hash algorithm.
* ES512: [ECDSA][ecdsa] using P-521 curve and [SHA-512][sha2] hash algorithm.

```
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
```

### Supported encryption algorithms

Currently, the Gluu Server supports these algorithms for data encryption:

* RSA1_5: RSA 1.5 (PKCS #1) according to [RFC 2313][rfc2313] and [RFC 3447][rfc3447].
* RSA-OAEP: RSA with [Optimal asymmetric encryption padding (OAEP)][oaep] with the default parameters specified by [RFC 3447][rfc3447] in section A.2.1.
* A128KW: [Advanced Encryption Standard (AES)][aes] Key Wrap Algorithm ([RFC 3394][rfc3394]) using 128 bit keys.
* A256KW: [Advanced Encryption Standard (AES)][aes] Key Wrap Algorithm ([RFC 3394][rfc3394]) using 256 bit keys.

Though listed in the configuration file, these algorithms are not
enabled, currently:

* `dir`: Direct use of a shared symmetric key as the [Content Encryption Key (CEK)][glossary-of-cryptographic-keys] for the block encryption step (rather than using the symmetric key to wrap the CEK).
* `ECDH-ES`: Elliptic Curve Diffie-Hellman Ephemeral Static ([RFC
6090][rfc6090]) key agreement using the Concat KDF, as defined in section 5.8.1 of [NIST.800-56A][nist-SP800-56AR2], with the agreed-upon key being used directly as the [Content Encryption Key (CEK)][glossary-of-cryptographic-keys] (rather than being used to wrap the CEK).
* `ECDH-ES+A128KW`: Elliptic Curve Diffie-Hellman Ephemeral Static key agreement per "ECDH-ES", but where the agreed-upon key is used to wrap the [Content Encryption Key (CEK)][glossary-of-cryptographic-keys] with the "A128KW" function (rather than being used directly as the CEK).
* `ECDH-ES+A256KW`: Elliptic Curve Diffie-Hellman Ephemeral Static key agreement per "ECDH-ES", but where the agreed-upon key is used to wrap the [Content Encryption Key (CEK)][glossary-of-cryptographic-keys] with the "A256KW" function (rather than being used directly as the CEK).

```
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
```

### Supported encryption encoding values

These encryption encoding values are supported:

* A128CBC+HS256: [AES][aes]_128_CBC_HMAC_SHA_256 authenticated encryption using a 256 bit key
* A256CBC+HS512: [AES][aes]_256_CBC_HMAC_SHA_512 authenticated encryption using a 512 bit key
* A128GCM: [Advanced Encryption Standard (AES)][aes] in [Galois/Counter Mode (GCM)][gcm] ([NIST.800-38D][nist-SP800-38D]) using a 128 bit key
* A256GCM: [Advanced Encryption Standard (AES)][aes] in [Galois/Counter Mode (GCM)][gcm] ([NIST.800-38D][nist-SP800-38D]) using a 256 bit key

```
<userinfo-encryption-enc-values-supported>
    <userinfo-encryption-enc>A128CBC+HS256</userinfo-encryption-enc>
    <userinfo-encryption-enc>A256CBC+HS512</userinfo-encryption-enc>
    <userinfo-encryption-enc>A128GCM</userinfo-encryption-enc>
    <userinfo-encryption-enc>A256GCM</userinfo-encryption-enc>
</userinfo-encryption-enc-values-supported>
```

### Supported ID token signing algorithms

Currently, the Gluu Server supports these algorithms to sign an ID
token:

* HS256: [HMAC][hmac] using [SHA-256][sha2] hash algorithm.
* HS384: [HMAC][hmac] using [SHA-384][sha2] hash algorithm.
* HS512: [HMAC][hmac] using [SHA-512][sha2] hash algorithm.
* RS256: [RSASSA-PKCS-v1_5][rsassa] using [SHA-256][sha2] hash algorithm.
* RS384: [RSASSA-PKCS-v1_5][rsassa] using [SHA-384][sha2] hash algorithm.
* RS512: [RSASSA-PKCS-v1_5][rsassa] using [SHA-512][sha2] hash algorithm.
* ES256: [ECDSA][ecdsa] using P-256 curve and [SHA-256][sha2] hash algorithm.
* ES384: [ECDSA][ecdsa] using P-384 curve and [SHA-384][sha2] hash algorithm.
* ES512: [ECDSA][ecdsa] using P-521 curve and [SHA-512][sha2] hash algorithm.

```
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
```

### Supported ID token encryption algorithms

Currently, the Gluu Server supports these encryption algorithms for
ID tokens:

* RSA1_5: RSA 1.5 (PKCS #1) according to [RFC 2313][rfc2313] and [RFC 3447][rfc3447].
* RSA-OAEP: RSA with [Optimal asymmetric encryption padding (OAEP)][oaep] with the default parameters specified by [RFC 3447][rfc3447] in section A.2.1.
* A128KW: [Advanced Encryption Standard (AES)][aes] Key Wrap Algorithm ([RFC 3394][rfc3394]) using 128 bit keys.
* A256KW: [Advanced Encryption Standard (AES)][aes] Key Wrap Algorithm ([RFC 3394][rfc3394]) using 256 bit keys.

Though listed in the configuration file, these algorithms are not
enabled, currently:

* `dir`: Direct use of a shared symmetric key as the [Content Encryption Key (CEK)][glossary-of-cryptographic-keys] for the block encryption step (rather than using the symmetric key to wrap the CEK).
* `ECDH-ES`: Elliptic Curve Diffie-Hellman Ephemeral Static ([RFC 6090][rfc6090]) key agreement using the Concat KDF, as defined in section 5.8.1 of [NIST.800-56A][nist-SP800-56AR2], with the agreed-upon key being used directly as the [Content Encryption Key (CEK)][glossary-of-cryptographic-keys] (rather than being used to wrap the CEK).
* `ECDH-ES+A128KW`: Elliptic Curve Diffie-Hellman Ephemeral Static key agreement per "ECDH-ES", but where the agreed-upon key is used to wrap the [Content Encryption Key (CEK)][glossary-of-cryptographic-keys] with the "A128KW" function (rather than being used directly as the CEK).
* `ECDH-ES+A256KW`: Elliptic Curve Diffie-Hellman Ephemeral Static key agreement per "ECDH-ES", but where the agreed-upon key is used to wrap the [Content Encryption Key (CEK)][glossary-of-cryptographic-keys] with the "A256KW" function (rather than being used directly as the CEK).

```
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

```

### Supported encryption encoding values for ID tokens

These encryption encoding values for ID tokens are supported:

* A128CBC+HS256: [AES][aes]_128_CBC_HMAC_SHA_256 authenticated encryption using a 256 bit key
* A256CBC+HS512: [AES][aes]_256_CBC_HMAC_SHA_512 authenticated encryption using a 512 bit key
* A128GCM: [Advanced Encryption Standard (AES)][aes] in [Galois/Counter Mode (GCM)][gcm] ([NIST.800-38D][nist-SP800-38D]) using a 128 bit key
* A256GCM: [Advanced Encryption Standard (AES)][aes] in [Galois/Counter Mode (GCM)][gcm] ([NIST.800-38D][nist-SP800-38D]) using a 256 bit key

```
<id-token-encryption-enc-values-supported>
    <id-token-encryption-enc>A128CBC+HS256</id-token-encryption-enc>
    <id-token-encryption-enc>A256CBC+HS512</id-token-encryption-enc>
    <id-token-encryption-enc>A128GCM</id-token-encryption-enc>
    <id-token-encryption-enc>A256GCM</id-token-encryption-enc>
</id-token-encryption-enc-values-supported>
```

### Supported request object signing algorithms

Currently, the Gluu Server supports these algorithms to sign a request
object:

* HS256: [HMAC][hmac] using [SHA-256][sha2] hash algorithm.
* HS384: [HMAC][hmac] using [SHA-384][sha2] hash algorithm.
* HS512: [HMAC][hmac] using [SHA-512][sha2] hash algorithm.
* RS256: [RSASSA-PKCS-v1_5][rsassa] using [SHA-256][sha2] hash algorithm.
* RS384: [RSASSA-PKCS-v1_5][rsassa] using [SHA-384][sha2] hash algorithm.
* RS512: [RSASSA-PKCS-v1_5][rsassa] using [SHA-512][sha2] hash algorithm.
* ES256: [ECDSA][ecdsa] using P-256 curve and [SHA-256][sha2] hash algorithm.
* ES384: [ECDSA][ecdsa] using P-384 curve and [SHA-384][sha2] hash algorithm.
* ES512: [ECDSA][ecdsa] using P-521 curve and [SHA-512][sha2] hash algorithm.

```
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
```

### Supported request object encryption algorithms

Currently, the Gluu Server supports these encryption algorithms for
request objects:

* RSA1_5: RSA 1.5 (PKCS #1) according to [RFC 2313][rfc2313] and [RFC 3447][rfc3447].
* RSA-OAEP: RSA with [Optimal asymmetric encryption padding (OAEP)][oaep] with the default parameters specified by [RFC 3447][rfc3447] in section A.2.1.
* A128KW: [Advanced Encryption Standard (AES)][aes] Key Wrap Algorithm ([RFC 3394][rfc3394]) using 128 bit keys.
* A256KW: [Advanced Encryption Standard (AES)][aes] Key Wrap Algorithm ([RFC 3394][rfc3394]) using 256 bit keys.

Though listed in the configuration file, these algorithms are not
enabled, currently:

* `dir`: Direct use of a shared symmetric key as the [Content Encryption Key (CEK)][glossary-of-cryptographic-keys] for the block encryption step (rather than using the symmetric key to wrap the CEK).
* `ECDH-ES`: Elliptic Curve Diffie-Hellman Ephemeral Static ([RFC 6090][rfc6090]) key agreement using the Concat KDF, as defined in section 5.8.1 of [NIST.800-56A][nist-SP800-56AR2], with the agreed-upon key being used directly as the [Content Encryption Key (CEK)][glossary-of-cryptographic-keys] (rather than being used to wrap the CEK).
* `ECDH-ES+A128KW`: Elliptic Curve Diffie-Hellman Ephemeral Static key agreement per "ECDH-ES", but where the agreed-upon key is used to wrap the [Content Encryption Key (CEK)][glossary-of-cryptographic-keys] with the "A128KW" function (rather than being used directly as the CEK).
* `ECDH-ES+A256KW`: Elliptic Curve Diffie-Hellman Ephemeral Static key agreement per "ECDH-ES", but where the agreed-upon key is used to wrap the [Content Encryption Key (CEK)][glossary-of-cryptographic-keys] with the "A256KW" function (rather than being used directly as the CEK).

```
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
```

### Supported request object encryption encoding values

These encryption encoding values are supported:

* A128CBC+HS256: [AES][aes]_128_CBC_HMAC_SHA_256 authenticated encryption using a 256 bit key
* A256CBC+HS512: [AES][aes]_256_CBC_HMAC_SHA_512 authenticated encryption using a 512 bit key
* A128GCM: [Advanced Encryption Standard (AES)][aes] in [Galois/Counter Mode (GCM)][gcm] ([NIST.800-38D][nist-SP800-38D]) using a 128 bit key
* A256GCM: [Advanced Encryption Standard (AES)][aes] in [Galois/Counter Mode (GCM)][gcm] ([NIST.800-38D][nist-SP800-38D]) using a 256 bit key

```
<request-object-encryption-enc-values-supported>
    <request-object-encryption-enc>A128CBC+HS256</request-object-encryption-enc>
    <request-object-encryption-enc>A256CBC+HS512</request-object-encryption-enc>
    <request-object-encryption-enc>A128GCM</request-object-encryption-enc>
    <request-object-encryption-enc>A256GCM</request-object-encryption-enc>
</request-object-encryption-enc-values-supported>
```

### Supported token endpoint authentication methods

Currently, these methods are supported for token endpoint
authentication:

* `client_secret_basic`
* `client_secret_post`
* `client_secret_jwt`
* `private_key_jwt`

```
<token-endpoint-auth-methods-supported>
    <token-endpoint-auth-method>client_secret_basic</token-endpoint-auth-method>
    <token-endpoint-auth-method>client_secret_post</token-endpoint-auth-method>
    <token-endpoint-auth-method>client_secret_jwt</token-endpoint-auth-method>
    <token-endpoint-auth-method>private_key_jwt</token-endpoint-auth-method>
</token-endpoint-auth-methods-supported>
```

### Supported token endpoint authentication signing algorithm values

Currently, the Gluu Server supports these signing algorithms to
authenticate endpoints:

* HS256: [HMAC][hmac] using [SHA-256][sha2] hash algorithm.
* HS384: [HMAC][hmac] using [SHA-384][sha2] hash algorithm.
* HS512: [HMAC][hmac] using [SHA-512][sha2] hash algorithm.
* RS256: [RSASSA-PKCS-v1_5][rsassa] using [SHA-256][sha2] hash algorithm.
* RS384: [RSASSA-PKCS-v1_5][rsassa] using [SHA-384][sha2] hash algorithm.
* RS512: [RSASSA-PKCS-v1_5][rsassa] using [SHA-512][sha2] hash algorithm.
* ES256: [ECDSA][ecdsa] using P-256 curve and [SHA-256][sha2] hash algorithm.
* ES384: [ECDSA][ecdsa] using P-384 curve and [SHA-384][sha2] hash algorithm.
* ES512: [ECDSA][ecdsa] using P-521 curve and [SHA-512][sha2] hash algorithm.

```
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
```

### Supported display values

The Gluu Server supports these display values:

* `page`
* `popup`
* `touch`
* `wap`

As the default value, `page` is enabled, only.

```
<display-values-supported>
    <display-value>page</display-value>
    <!--display-value>popup</display-value-->
    <!--display-value>touch</display-value-->
    <!--display-value>wap</display-value-->
</display-values-supported>
```

### Supported claim types

Currently, the Gluu Server supports these claims:

* `normal`:
* `distributed`:

```
<claim-types-supported>
    <claim-type>normal</claim-type>
    <!--claim-type>distributed</claim-type-->
</claim-types-supported>
```

### Supported claims

The Gluu Server supports these values for claims:

* `uid`: a valid user id
* `displayName`: a previously chosen user name that is displayed
* `givenName`: a previously given user name
* `sn`: 
* `mail`: a stored email address for this user

```
<claims-supported>
    <claim>uid</claim>
    <claim>displayName</claim>
    <claim>givenName</claim>
    <claim>sn</claim>
    <claim>mail</claim>
</claims-supported>
```

### Service documentation

This entry keeps the path to the service documentation of the Gluu
Server.

```
<service-documentation>http://gluu.org/docs</service-documentation>
```

### Supported locales for claims

Currently, these languages are supported for claims:

* en: English

These languages are not enabled by default:

* en-GB: British English
* en-CA: Canadian English
* fr-FR: French 
* fr-CA: Canadian French

```
<claims-locales-supported>
    <claim-locale>en</claim-locale>
    <!--claim-locale>en-GB</claim-locale-->
    <!--claim-locale>en-CA</claim-locale-->
    <!--claim-locale>fr-FR</claim-locale-->
    <!--claim-locale>fr-CA</claim-locale-->
</claims-locales-supported>
```

### Supported locales for user interfaces

Currently, these languages are supported for claims:

* `en`: English
* `es`: Spanish

These languages are not enabled, yet:

* `en-GB`: British English
* `en-CA`: Canadian English
* `fr-FR`: French 
* `fr-CA`: Canadian French

```
<ui-locales-supported>
    <ui-locale>en</ui-locale>
    <ui-locale>es</ui-locale>
    <!--ui-locale>en-GB</ui-locale-->
    <!--ui-locale>en-CA</ui-locale-->
    <!--ui-locale>fr-FR</ui-locale-->
    <!--ui-locale>fr-CA</ui-locale-->
</ui-locales-supported>
```

### Supported claims parameters

To enable additional parameters for claims, the tag
`claims-parameter-supported` has to be set to `true` before, and
`false` otherwise.

```
<claims-parameter-supported>true</claims-parameter-supported>
```

### Supported request parameters

To enable additional parameters for request, the tag
`request-parameter-supported` has to be set to `true` before, and
`false` otherwise.

```
<request-parameter-supported>true</request-parameter-supported>
```

### Supported request uri parameters

To enable additional parameters for uri requests, the tag
`request-uri-parameter-supported` has to be set to `true` before, and
`false` otherwise.

```
<request-uri-parameter-supported>true</request-uri-parameter-supported>
```

### Required request uri registration

To require a request for uri registration, the tag
`require-request-uri-registration` has to be set to `true` before, and
`false` otherwise.

```
<require-request-uri-registration>false</require-request-uri-registration>
```

### Uri for operation policy

To define a certain oxAuth operation policy uri use the tag
`op-policy-uri`.

```
<op-policy-uri>http://ox.gluu.org/doku.php?id=oxauth:policy</op-policy-uri>
```

### Uri for type-of-service

To define a certain oxAuth type-of-service uri use the tag `op-tos-uri`.

```
<op-tos-uri>http://ox.gluu.org/doku.php?id=oxauth:tos</op-tos-uri>
```

### Connection behaviour

These tags control the behaviour of the connection:

* `authorization-code-lifetime`: sets the lifetime of the authorization code. The default is 600 seconds.
* `refresh-token-lifetime`: sets the interval the token is refreshed. The default value is 14400 seconds that represent 6 hours.
* `id-token-lifetime`: sets the lifetime of the id token. The default value os 3600 seconds that represents one hour.
* `short-lived-access-token-lifetime`: sets the short-lived access token
lifetime
* `long-lived-access-token-lifetime`: sets the long-lived access token lifetime

```
<authorization-code-lifetime>600</authorization-code-lifetime>
<refresh-token-lifetime>14400</refresh-token-lifetime>
<id-token-lifetime>3600</id-token-lifetime>
<short-lived-access-token-lifetime>3600</short-lived-access-token-lifetime>
<long-lived-access-token-lifetime>31536000</long-lived-access-token-lifetime>
```

These tags control the behaviour of a session:

* `session-id-unused-lifetime`: if the session id is not used during some
time then it is removed, automatically. The lifetime is set in seconds,
whereas 86400 seconds represent a single day.
* `session-id-enabled`: this tag is either `true` or `false` and displays
whether a session id is enabled or not
* `refresh-user-session-timeout-enabled`: this tag is either `true` or
`false` and defines whether the timeout is enabled to refresh a user
session. The default value is `true`.
* `refresh-user-session-timeout`: defines the duration of the timeout
after which the session is refreshed. The default value is set to 1800
seconds.

```
<session-id-unused-lifetime>86400</session-id-unused-lifetime>
<session-id-enabled>true</session-id-enabled>
<refresh-user-session-timeout-enabled>true</refresh-user-session-timeout-enabled>
<refresh-user-session-timeout>1800</refresh-user-session-timeout>
```

These tags control the [User Managed Access (UMA)][uma]:

* `uma-add-scopes-automatically`
* `uma-requester-permission-token-lifetime`
* `uma-keep-client-during-resource-set-registration`

```
<uma-add-scopes-automatically>false</uma-add-scopes-automatically>
<uma-requester-permission-token-lifetime>3600</uma-requester-permission-token-lifetime>
<uma-keep-client-during-resource-set-registration>true</uma-keep-client-during-resource-set-registration>
```

To adjust the time of the service interval use the value for the tag
`clean-service-interval`. The value is set in seconds, and the default
value is 600 seconds:

```
<clean-service-interval>600</clean-service-interval>

```

### Default signature algorithms

These entries define the default signature algorithm, and list the key
ids for the other signature algorithms that are available. These values
are part of the list:

* RS256: [RSASSA-PKCS-v1_5][rsassa] using [SHA-256][sha2] hash algorithm.
* RS384: [RSASSA-PKCS-v1_5][rsassa] using [SHA-384][sha2] hash algorithm.
* RS512: [RSASSA-PKCS-v1_5][rsassa] using [SHA-512][sha2] hash algorithm.
* ES256: [ECDSA][ecdsa] using P-256 curve and [SHA-256][sha2] hash algorithm.
* ES384: [ECDSA][ecdsa] using P-384 curve and [SHA-384][sha2] hash algorithm.
* ES512: [ECDSA][ecdsa] using P-521 curve and [SHA-512][sha2] hash algorithm.

```
<default-signature-algorithm>RS256</default-signature-algorithm>
<RS256-keyid>1</RS256-keyid>
<RS384-keyid>2</RS384-keyid>
<RS512-keyid>3</RS512-keyid>
<ES256-keyid>4</ES256-keyid>
<ES384-keyid>5</ES384-keyid>
<ES512-keyid>6</ES512-keyid>
```

### Federation settings

The entry `federation-enabled` sets the value for the [Active Directory
Federation Services (ADFS)][adfs-wikipedia] feature. `true` means
enabled, and `false` means disabled.

```
<federation-enabled>false</federation-enabled>
```

The entry `federation-check-interval` defines the federation check
interval in seconds. It checks whether data in trusts are still valid
for example if the request parameter (RP) `redirectUri` still exists in
metadata. If not then remove from trust automatically. The value `86400`
represents 24 hours.

```
<federation-check-interval>86400</federation-check-interval>
```

The entry `federation-skip-policy` defines the way the different
[Active Directory Federation Services (ADFS)][adfs-wikipedia] policies
are processed. Accepted values are `OR` and `AND`. This value is used in
case there is more than one federation trust for a given redirect uri.
The default value is `OR`.

```
<federation-skip-policy>OR</federation-skip-policy>
```

The entry `federation-scope-policy` defines the federation scope policy.
Currently, the only possible value is `JOIN` and means that all the
scopes of the trust list are joined.

```
<federation-scope-policy>JOIN</federation-scope-policy>
```

These entries set both the federation signing algorithm, and the
according signing key id. The default settings are `RS512` and `1`. For
a full list of possible values see the section about default signature
algorithms.

```
<federation-signing-alg>RS512</federation-signing-alg>
<federation-signing-kid>1</federation-signing-kid>
```

### Dynamic registration of custom object

Dynamic Client Registration is configurable because some servers may not
want to support this feature due to it opens you up to the possibility
of a [Denial-of-service attack (DOS) attack][dos]. To enable this
feature set the value for `dynamic-registration-enabled` to `true`,
otherwise to `false`.

```
<dynamic-registration-enabled>true</dynamic-registration-enabled>
```

The expiration time for Dynamic Client Registration allows to configure
a time in seconds for the client's account expiration, it can be set to
zero if the client account never expires.

```
<dynamic-registration-expiration-time>86400</dynamic-registration-expiration-time>
```

Dynamic Client Registration uses an inum generator service. You can
configure both the URL of the service under the tag `oxID`, and the
organization inum used by this service under the tag `organization`.

```
<oxID>https://%(hostname)s/oxid/service/gluu/inum</oxID>
<organization-inum>%(inumOrg)s</organization-inum>
```

To set a specific version for the connection via [OpenID][openid] use
the tag `oxOpenIDConnectVersion` like that:

```
<oxOpenIDConnectVersion>openidconnect-1.0</oxOpenIDConnectVersion>
```

Each custom object class can be registered dynamically. Set the the tag
`dynamic-registration-custom-object-class` to the referenced class name.

```
<dynamic-registration-custom-object-class>oxAuthClientCustomAttributes</dynamic-registration-custom-object-class>
```

Dynamic registration allows the usage of custom attributes using the tag
`dynamic-registration-custom-attribute`.

```
<dynamic-registration-custom-attribute-supported>
    <dynamic-registration-custom-attribute>oxAuthTrustedClient</dynamic-registration-custom-attribute>
    <dynamic-registration-custom-attribute>myCustomAttr1</dynamic-registration-custom-attribute>
    <dynamic-registration-custom-attribute>myCustomAttr2</dynamic-registration-custom-attribute>
</dynamic-registration-custom-attribute-supported>
```

Trusted clients have to be enabled, first. Set the tag
`trusted-client-enabled` to `true`, or `false` if otherwise wanted.

```
<trusted-client-enabled>true</trusted-client-enabled>
```

### Authorization LDAP filters

To use authorization [LDAP][ldap] filters you have to enable them,
first. Set the tag `auth-filters-enabled` to `true`:

```
<auth-filters-enabled>false</auth-filters-enabled>
```

Next, you can use the previously defined authorization filters. A filter
definition allows the following tags:

* `filter`: the condition for the filter
* `bind`: can be either `true` or `false`. If `true` oxAuth binds to the entry which is found by the filter as specified above
* `bind-password-attribute`: the name of the password attribute
* `base-dn`: the name of the base domain, for example `o=gluu`

```
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
```

### Custom LDAP client filters

oxAuth allows to define custom [LDAP][ldap] client filters. oxAuth uses
them to find clients in the [LDAP][ldap] Namespace, or Directory
Information Tree (DIT) structure. For detailed information regarding the
Gluu Server LDAP Namespace, have a look [here][glue-server-ldap-namespace].

To use custom [LDAP][ldap] client filters you have to enable them,
first. Set the tag `client-auth-filters-enabled` to `true`:

```
<client-auth-filters-enabled>`true`</client-auth-filters-enabled>
```

Next, you can use the previously defined authorization filters. A filter
definition allows the following tags:

* `filter`: the condition for the filter
* `bind`: can be either `true` or `false`. If `true` oxAuth binds to the entry which is found by the filter as specified above
* `bind-password-attribute`: the name of the password attribute
* `base-dn`: the name of the base domain, for example `o=gluu`

```
<client-auth-filters>
    <client-auth-filter>
        <filter>`myCustomAttr1={0}`</filter>
        <base-dn>`ou=clients,o=@!1111,o=gluu`</base-dn>
    </client-auth-filter>
    <!--client-auth-filter>
        <filter>`(&amp;(myCustomAttr1={0})(myCustomAttr2={0}))`</filter>
        <base-dn>`ou=clients,o=@!1111,o=gluu`</base-dn>
    </client-auth-filter-->
</client-auth-filters>
```

[adfs-msdn]: https://msdn.microsoft.com/en-us/library/bb897402.aspx "Active Directory Federation Services (ADFS), MSDN"

[adfs-wikipedia]: https://en.wikipedia.org/wiki/Active_Directory_Federation_Services "Active Directory Federation Services (ADFS), Wikipedia"

[aes]: https://en.wikipedia.org/wiki/Advanced_Encryption_Standard "Advanced Encryption Standard (AES), Wikipedia"

[dos]: https://en.wikipedia.org/wiki/Denial-of-service_attack "Denial-of-service attack (DOS), Wikipedia"

[ecdsa]: https://en.wikipedia.org/wiki/Elliptic_Curve_Digital_Signature_Algorithm "Elliptic Curve Digital Signature Algorithm (ECDSA), Wikipedia"

[glossary-of-cryptographic-keys]: https://en.wikipedia.org/wiki/Glossary_of_cryptographic_keys "Glossary of cryptographic keys"

[glue-server-ldap-namespace]: ../ldap-namespace/ "LDAP Namespace"

[gcm]: https://en.wikipedia.org/wiki/Galois/Counter_Mode "Galois/Counter Mode (GCM), Wikipedia"

[hmac]: https://en.wikipedia.org/wiki/Hash-based_message_authentication_code "Hash-based message authentication code (HMAC), Wikipedia"

[ietf-jwk]: https://tools.ietf.org/html/draft-ietf-oauth-jwt-bearer-12 "JSON Web Token (JWT) Profile for OAuth 2.0 Client Authentication and Authorization Grants, IETF draft"

[iframe]: https://en.wikipedia.org/wiki/HTML_element#Frames "HTML element: iframe, Wikipedia"

[inum]: https://en.wikipedia.org/wiki/INum_Initiative "INum Initiative, Wikipedia"

[json]: https://en.wikipedia.org/wiki/JSON "JSON, Wikipedia"

[jwk]: https://tools.ietf.org/html/rfc7517 "JSON Web Key (JWK), Internet Engineering Task Force (IETF), RFC 7517"

[ldap]: https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol "Lightweight Directory Access Protocol (LDAP), Wikipedia"

[nist-SP800-38D]: http://csrc.nist.gov/publications/nistpubs/800-38D/SP-800-38D.pdf "Recommendation for Block Cipher Modes of Operation: Galois/Counter Mode (GCM) and GMAC, National Institute of Standards and Technology (NIST), 2007"

[nist-SP800-56AR2]: http://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-56Ar2.pdf "Recommendation for Pair-Wise Key Establishment Schemes Using Discrete Logarithm Cryptography, Revision 2, National Institute of Standards and Technology (NIST), 2013"

[oaep]: https://en.wikipedia.org/wiki/Optimal_asymmetric_encryption_padding "Optimal asymmetric encryption padding (OAEP), Wikipedia"

[oauth2]: https://en.wikipedia.org/wiki/OAuth#OAuth_2.0 "OAuth 2.0, Wikipedia"

[openid]: https://en.wikipedia.org/wiki/OpenID "OpenID, Wikipedia"

[oxwiki-authorization]: http://ox.gluu.org/doku.php?id=oxauth:authorizationcodegrant "Authorization Code Grant"

[rest]: https://en.wikipedia.org/wiki/Representational_state_transfer "Representational State Transfer (REST), Wikipedia"

[rfc2313]: https://tools.ietf.org/html/rfc2313 "RFC 2313: Public-Key Cryptography Standards (PKCS #1): RSA Encryption Version 1.5, IETF"

[rfc3394]: https://tools.ietf.org/html/rfc3394 "RFC 3394: Advanced Encryption Standard (AES) Key Wrap Algorithm, IETF"

[rfc3447]: https://tools.ietf.org/html/rfc3447 "RFC 3447: Public-Key Cryptography Standards (PKCS) #1: RSA Cryptography, Specifications Version 2.1, IETF"

[rfc6090]: https://tools.ietf.org/html/rfc6090 "RFC 6090: Fundamental Elliptic Curve Cryptography Algorithms, IETF"

[rfc6749]: https://tools.ietf.org/html/rfc6749 "RFC 6749: The OAuth 2.0 Authorization Framework, IETF"

[rsassa]: https://tools.ietf.org/html/draft-ietf-jose-json-web-algorithms-14#page-12 "Digital Signature with RSASSA-PKCS1-V1_5, in JSON Web Algorithms (JWA), draft-ietf-jose-json-web-algorithms-14, July 2013"

[saml]: https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language "Security Assertion Markup Language (SAML), Wikipedia"

[sha2]: https://en.wikipedia.org/wiki/SHA-2 "Secure Hash Algorithm (SHA) SHA-2 familiy, Wikipedia"

[sso]: https://en.wikipedia.org/wiki/Single_sign-on "Single sign-on, Wikipedia"

[uma]: https://de.wikipedia.org/wiki/User-Managed_Access "User-Managed Access (UMA), Wikipedia"

[xml]: https://en.wikipedia.org/wiki/XML "XML, Wikipedia"
