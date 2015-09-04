
## oxauth-ldap.properties

These are the properties oxTrust uses to connect to Lightweight
Directory Access Protocol (LDAP):

 * __bindDN__

   Authenticate with this unique entry, and bind to the LDAP server
   using the given domain name `dn` (initiate an LDAP session). 
   Typically, a single LDAP entry consists of entries like 
   `dn: dc=example,dc=com`.

 * __bindPassword__

   Authenticate to the LDAP server using this password. This value
   refers to the LDAP entry `userPassword`.

 * __servers__ 

   Define both the server name and the according port to use. The
   default value is `localhost:1636`.

 * __useSSL__ 

   Enable an SSL connection for encrypted data transmission. For this
   entry use either `TRUE` to enable SSL, or `false` to disable SSL.

 * __maxconnections__ `3`

   Define the maximum number of connections at the same time. The 
   default value is set to `3`.

