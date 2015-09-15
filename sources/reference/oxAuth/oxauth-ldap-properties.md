
## oxauth-ldap.properties

These are the properties [oxTrust][oxtrust] uses to connect to
[Lightweight Directory Access Protocol (LDAP)][ldap]:

 * __bindDN__

   Authenticate with this unique entry, and bind to the LDAP server
   using the given domain name `dn` (initiate an LDAP session). 
   Typically, a single LDAP entry consists of entries like 
   `dn: dc=example,dc=com`.

 * __bindPassword__

   Authenticate to the LDAP server using this password. This value
   refers to the LDAP entry `userPassword`.

 * __servers__

   Define both the server name and the according network port to use. 
   The default value is `localhost:1636` for the local machine, and 
   port `1636`.

 * __useSSL__

   Enable an [SSL][ssl] connection for encrypted data transmission. For
   this entry use either `TRUE` to enable [SSL][ssl], or `false` to
   disable [SSL][ssl].

 * __maxconnections__

   Define the maximum number of connections at the same time. The 
   default value is set to `3`.

[ldap]: https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol "Lightweight Directory Access Protocol (LDAP), Wikipedia"

[oxtrust]: ../oxTrust/ "oxTrust documentation"

[ssl]: https://en.wikipedia.org/wiki/Transport_Layer_Security "Transport Layer Security (TLS), Wikipedia"
