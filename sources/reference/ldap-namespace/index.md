# LDAP Namespace 

The LDAP Namespace, or Directory Information Tree (DIT) structure, is the convention for naming
entries in LDAP so that they form a hierarchical tree structure.

In general, the Gluu Server tries to keep the data pretty flat. But at times, we use the 
namespace to store information that is relative to a certain entry. 

There are two root namespaces in the Gluu Server: `o=gluu` and `o=site`. The `o=gluu` namespace
is used to store all the important configuration and entity data. The `o=site` DIT is used
only when identities are being synchronized from an external LDAP server using the Gluu
Server Cache Refresh feature.

The following table has a list of all the major branches of the tree under `o=gluu`:

| base DN                                  | Description                                               |
| ---------------------------------------- | --------------------------------------------------------- |
| ou=appliances,o=gluu                     | oxTrust configuration information for the instance        |
| o=1234,o=gluu                            | organization entry, ipV6 style id by default              | 
| ou=people,o=1234,o=gluu                  | User entities                                             |
| ou=groups,o=1234,o=gluu                  | Group entities                                            |
| ou=clients,o=1234,o=gluu                 | OAuth2 client entities                                    |
| ou=attributes,o=1234,o=gluu              | Attribute or user claim metadata                          |
| ou=scopes,o=1234,o=gluu                  | Oauth2 scope entities                                     |
| ou=session,o=1234,o=gluu                 | oxAuth Session data (if persistent sessions are enabled   |
| ou=uma,o=1234,o=gluu                     | UMA policies, scopes, and resource sets                   |
| ou=push,o=1234,o=gluu                    | Mobile device metadata used by oxPush                     |
| ou=federation,o=1234,o=gluu              | OAuth2 federation metadata                                |
| ou=oxProx,o=1234,o=gluu                  | oxProx configuration data                                 |
| 



