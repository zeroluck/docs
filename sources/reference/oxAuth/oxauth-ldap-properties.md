
## oxauth-ldap.properties

These are the properties oxTrust uses to connect to Lightweight Directory Access Protocol (LDAP):

 * __bindDN__

   Authenticate with this unique entry, and bind to the LDAP server.
   Typically, a single entry consists of several pieces such as a common
   name `cn`, and a domain component `dc`.

 * __bindPassword__

 * __servers__ `localhost:1636`

 * __useSSL__ `TRUE | false`

 * __maxconnections__ `3`

