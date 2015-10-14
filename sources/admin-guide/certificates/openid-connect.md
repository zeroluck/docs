# oxAuth Cryptographic Key Management

The cryptographic keys are published in oxAuth in the JWK endpoint. A
JSON Web Key (JWK) is a JavaScript Object Notation (JSON) data structure
that represents a cryptographic key.

You can get JWK endpoint by using OpenID Connect Discovery and reading
the OpenID Connect Configuration Endpoint. For example:

http://seed.gluu.org/.well-known/openid-configuration

    {
        ...
        "jwks_uri": "https://seed.gluu.org/oxauth/seam/resource/restv1/oxauth/jwks",
        ...
    }
    
https://seed.gluu.org/oxauth/seam/resource/restv1/oxauth/jwks

    {"keys": [
        {
            "kty": "RSA",
            "kid": "1",
            "use": "sig",
            "alg": "RS256",
            "n": "...",
            "e": "...",
            "x5c": ["..."]
        },
        {
            "kty": "RSA",
            "kid": "2",
            "use": "sig",
            "alg": "RS384",
            "n": "...",
            "e": "...",
            "x5c": ["..."]
        },
        {
            "kty": "RSA",
            "kid": "3",
            "use": "sig",
            "alg": "RS512",
            "n": "...",
            "e": "...",
            "x5c": ["..."]
        },
        {
            "kty": "EC",
            "kid": "4",
            "use": "sig",
            "alg": "EC",
            "crv": "P-256",
            "x": "...",
            "y": "...",
            "x5c": ["..."]
        },
        {
            "kty": "EC",
            "kid": "5",
            "use": "sig",
            "alg": "EC",
            "crv": "P-384",
            "x": "...",
            "y": "...",
            "x5c": ["..."]
        },
        {
            "kty": "EC",
            "kid": "6",
            "use": "sig",
            "alg": "EC",
            "crv": "P-521",
            "x": "...",
            "y": "...",
            "x5c": ["..."]
        }
    ]}

## Updating Cryptographic Keys (JWS)

In order to generate new cryptographic keys, go to the oxAuth source
directory and run the following command:

    $ mvn -Dtest=org.xdi.oxauth.ws.rs.SignatureTest -DfailIfNoTests=false test

The command output will generate cryptographic keys for the algorithms:
RS256, RS384, RS512, ES256, ES384 and ES512.

Update or add the desired new cryptographic keys in the configuration
file at this location:

    /opt/tomcat/conf/oxauth-web-keys.json

In order to force oxAuth to reload the configuration files these steps
are needed:

 - Delete the LDAP configuration entries at `ou=configuration,o=ORGANIZATION_INUM,o=gluu`
 - Restart the Apache Tomcat service
