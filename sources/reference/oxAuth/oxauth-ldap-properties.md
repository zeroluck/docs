
## oxauth-ldap.properties

These are the properties oxTrust uses to connect to Lightweight
Directory Access Protocol (LDAP):

 * __bindDN__

   Authenticate with this unique entry, and bind to the LDAP server
   using the given domain name `dn` (initiate an LDAP session). 
   Typically, a single entry consists of entries like 
   `dn: dc=example,dc=com`.

 * __bindPassword__

 * __servers__ `localhost:1636`

 * __useSSL__ `TRUE | false`

 * __maxconnections__ `3`

