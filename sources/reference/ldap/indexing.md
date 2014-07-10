# Indexing

All databases need proper indexing to function. This is particularly true for LDAP servers. 
There should never be any `sub` or `one` scoped searches to the LDAP server that are not
properly indexed. Because indexing is implemenation specific, the following guidelines 
should provide a good starting point. The LDAP server logs should be periodically analyzed to
identify un-indexed searches. The exact indexing requirements may vary based on custom attributes,
and custom authentication and authorization requirements.

## OpenDJ Indexing

## 389DS Indexing

## OpenLDAP Indexing configuration

