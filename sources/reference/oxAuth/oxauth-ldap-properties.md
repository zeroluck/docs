
## oxauth-ldap.properties

The Gluu Server uses [Lightweight Directory Access Protocol
(LDAP)][ldap] for persistence to store [oxTrust][oxtrust] and oxAuth
data, and to cache user entries. The Gluu Server packages include Gluu
[OpenDJ][opendj], which is our fork of OpenDJ 2.6.0, the last open
source release by [Forgerock][forgerock]. It is possible to use any
[LDAP][ldap] server, as long as you have the schema and security under
control.

We publish the latest schema in our community-edition-setup project. The
schema that we publish for Gluu OpenDJ should also work for [Forgerock
OpenDJ][forgerock-opendj], [UnboundID][unboundid] LDAP server, and
[Oracle Directory Server Enterprise Edition (ODSEE)][odsee].

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

[forgerock]: https://en.wikipedia.org/wiki/ForgeRock "Forgerock, Wikipedia"

[forgerock-opendj]: http://opendj.forgerock.org/ "OpenDJ Directory Services Project"

[ldap]: https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol "Lightweight Directory Access Protocol (LDAP), Wikipedia"

[odsee]: http://www.oracle.com/technetwork/middleware/id-mgmt/overview/index-085178.html "Oracle Directory Server Enterprise Edition (ODSEE)"

[opendj]: https://en.wikipedia.org/wiki/OpenDJ "OpenDJ, Wikipedia"

[oxtrust]: ../oxTrust/ "oxTrust documentation"

[ssl]: https://en.wikipedia.org/wiki/Transport_Layer_Security "Transport Layer Security (TLS), Wikipedia"

[unboundid]: https://www.unboundid.com/ "UnboundiD"
