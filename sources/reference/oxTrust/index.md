# oxTrust Configuration

oxTrust is a [JBoss][jboss] Seam application that provides
organizational cloud identity management services, including REST
service endpoints and a user friendly cloud identity management console
(aka a GUI).

oxTrust is tightly coupled with oxAuth. oxAuth configuration is stored
in [LDAP][ldap], and it would be hard to generate the right
configuration entries without oxTrust. The projects are separate
projects because in a high throughput cluster deployment, many oxAuth
servers are needed versus a few oxTrust instances.

## oxTrust.properties

The oxTrust has quite a few properties to control its behaviour. This
consists of general properties, SVN-related properties as well as
display and authentication properties.

### General properties

 * __applianceInum__ 

 * __orgInum__ 

 * __orgDisplayName__ 

 * __orgShortName__ 

 * __idp.url__ 

 * __appliance.url__ 

 * __keystore.path__ 

 * __keystore.password__ 

 * __person-objectClass-types__ `inetOrgPerson, gluuPerson`

 * __person-objectClass-displayNames__ `inetOrgPerson, gluuPerson`

### SVN-related properties

 * __svn.configuration-store.root__ 

 * __svn.configuration-store.user__ 

 * __svn.configuration-store.password__ 

 * __person.allow-modification__ enables or disables the allowance to
   modify a person entry. Use `TRUE` to allow (default value), and
   `false` to forbid.

 * __site.update-appliance-status__ change the update appliance state
   for the site. Use `true` to allow, and `FALSE` to forbid (default
   value).

 * __persist-in-svn__ control the state of persistance in the SVN. Use
   `true` to enable, and `FALSE` to disable (default value).

 * __baseDN__ set the base domain name of oxTrust. The default value is
   `o=gluu`.

 * __schema.add.attribute.attributeTypes__ `( %%s-oid NAME '%%s' EQUALITY caseIgnoreMatch ORDERING caseIgnoreOrderingMatch SUBSTR caseIgnoreSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 USAGE userApplications X-SCHEMA-FILE '100-user.ldif' X-ORIGIN 'gluu' )`

 * __schema.add-without-attribute-types.objectClass.objectClasses__ `( %%s-oid NAME '%%s' SUP top STRUCTURAL MUST objectClass X-SCHEMA-FILE '100-user.ldif' X-ORIGIN 'gluu' )`

 * __schema.add-with-attribute-types.objectClass.objectClasses__ `( %%s-oid NAME '%%s' SUP top STRUCTURAL MUST objectClass MAY ( %%s ) X-SCHEMA-FILE '100-user.ldif' X-ORIGIN 'gluu' )`

### Display properties

These properties refer to visual settings of oxTrust.

 * __photo.repository.root-dir__ sets the path to the root directory of
   photographs. The default value is `/var/photos`.

 * __photo.repository.thumb-width__ sets the thumb with of a photo. 
   The default value is `300` pixels.

 * __photo.repository.thumb-height__ sets the thumb height of a photo.
   The default value is `300` pixels.

 * __photo.repository.count-levels__ sets the count level per photo
   repository. The default value is `3`.

 * __photo.repository.count-folders-per-level__ sets the number of
   folders per level. The default value is `20`.

 * __velocity.log__ this entry defines the filename in which the
   velocity is kept. The default value is `/opt/tomcat/logs/velocity.log`.

 * __logo.location__ this entry defines the directory name for the
   photos. The default value is `/var/photos`.

### Authentication properties 

These properties refer to authentication settings of oxTrust.

 * __gluuSP.shared.attributes__ `uid, mail, sn, givenName`

 * __gluuSP.metadata__ `/opt/idp/metadata`

 * __shibboleth2.idp.root-dir__ `/opt/idp`

 * __shibboleth2.federation.root-dir__ `/opt/shibboleth-federation`

 * __shibboleth2.sp.conf-dir__ `/etc/shibboleth`

 * __configGeneration__ `enabled | DISABLED`

 * __idp.securityCert__ 

 * __idp.securityKey__ 

 * __.securityCert__ 

 * __idp.securityKeyPassword__ 

 * __idp.bindDN__ 

 * __idp.bindPassword__ 

 * __idp.useSSL__ `TRUE | false`

 * __idp.ldap.server__ 

 * __mysql.url__ `jdbc:mysql:///localhost`

 * __mysql.user__ `idp`

 * __mysql.password__ 

 * __ldifStoreDir__ `/var/removedldif/`

 * __cacertsLocation__ holds the value
   `/usr/java/latest/jre/lib/security/cacerts`. This option defines a
   keystore to be used for downloaded SSL certificates. It is a good idea
   to have all trusted root CA at this keystore. It defaults to the Tomcat
   SSL keystore that is defined in `server.xml`.

 * __cacertsPassphrase__ If this option is present it will be used as a
   passphrase to a keystore that is defined in the tag `cacertsLocation`.
   It is only needed if `cacertsLocation` is defined and is protected by 
   password. For default jre cacerts behavior (empty password) - leace 
   commented.

 * __certDir__ holds the value `/etc/certs/`. This is the location of
   certificates used in configuration files.

 * __certDirTemp__ holds the value `/etc/certs/temp`. This is the
   temporary location for certificates while user performs update
   procedures.

 * __servicesRestartTrigger__ holds the filename
   `/opt/gluu/trigger_restart_of_services_delete_me_to_do_so`. Deleting
   this file works as a trigger that restarts the appliance services.

 * __oxtrust.auth.mode__  set this tag to `basic` without the quotation to use basic authentication or leave it blank to use oxAuth

 * __oxauth.authorize.url__ 
 * __oxauth.token.url__ 
 * __oxauth.token.validation.url__ 
 * __oxauth.checksession.url__ 
 * __oxauth.userinfo.url__ 
 * __oxauth.logout.url__ 

 * __oxauth.client.id__ 
 * __oxauth.client.credentials__ 
 * __oxauth.client.password__ 
 * __oxauth.client.scope__ `openid+profile+address+email`

## oxTrustLdap.properties

These are the properties oxTrust uses to connect to [LDAP][ldap]
services:

 * __bindDN__ define the [LDAP][ldap] domain name to bind to

 * __bindPassword__ define the [LDAP][ldap] passwort to bind to

 * __servers__ define the [LDAP][ldap] hostname, and the according
   network port for the connection. The default value is `localhost:1636`
   for localhost on port `1636`.

 * __useSSL__ enable this tag to initiate a secure connection via SSL.
   Set this tag to `TRUE`, or `false` if otherwise wanted.


 * __maxconnections__ set this entry to define the maximum number of
   parallel connections. The default value is set to `3`.

 * __baseConfigurationDN__ define the [LDAP][ldap] domain name for base
   configuration

 * __createLdapConfigurationEntryIfNotExist__ if an [LDAP][ldap]
   configuration entry does not exist it can be created, automatically. Set
   this tag to `TRUE`, or `false` if otherwise wanted.

[jboss]: https://en.wikipedia.org/wiki/WildFly "JBoss, Wildfly, Wikipedia"

[ldap]: https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol "Lightweight Directory Access Protocol (LDAP), Wikipedia"

