# oxTrust Configuration

oxTrust is a JBoss Seam application that provides organizational cloud identity
management services, including REST service endpoints and a user friendly cloud
identity management console (aka a GUI). 

oxTrust is tightly coupled with oxAuth. oxAuth configuration is stored in LDAP,
and it would be hard to generate the right configuration entries without
oxTrust. The projects are separate projects because in a high throughput cluster
deployment, many oxAuth servers are needed versus a few oxTrust instances.

## oxTrust.properties

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

 * __svn.configuration-store.root__ 

 * __svn.configuration-store.user__ 

 * __svn.configuration-store.password__ 

 * __person.allow-modification__ `TRUE | false'

 * __site.update-appliance-status__ 'true | FALSE`

 * __persist-in-svn__ `true | FALSE`

 * __baseDN__ `o=gluu`

 * __schema.add.attribute.attributeTypes__ `( %%s-oid NAME '%%s' EQUALITY caseIgnoreMatch ORDERING caseIgnoreOrderingMatch SUBSTR caseIgnoreSubstringsMatch SYNTAX 1.3.6.1.4.1.1466.115.121.1.15 USAGE userApplications X-SCHEMA-FILE '100-user.ldif' X-ORIGIN 'gluu' )`

 * __schema.add-without-attribute-types.objectClass.objectClasses__ `( %%s-oid NAME '%%s' SUP top STRUCTURAL MUST objectClass X-SCHEMA-FILE '100-user.ldif' X-ORIGIN 'gluu' )`

 * __schema.add-with-attribute-types.objectClass.objectClasses__ `( %%s-oid NAME '%%s' SUP top STRUCTURAL MUST objectClass MAY ( %%s ) X-SCHEMA-FILE '100-user.ldif' X-ORIGIN 'gluu' )`

 * __photo.repository.root-dir__ `/var/photos`

 * __photo.repository.thumb-width__ `300`

 * __photo.repository.thumb-height__ `300`

 * __photo.repository.count-levels__ `3`

 * __photo.repository.count-folders-per-level__ `20`

 * __velocity.log__ `/opt/tomcat/logs/velocity.log`

 * __logo.location__ `/var/photos`

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

 * __cacertsLocation__ `/usr/java/latest/jre/lib/security/cacerts` This option defines keystore to use for SSL download certificate verification. It is a good idea to have all truster root CA at this keystore Defaults to tomcat SSL keystore (one defined in server.xml)

 * __cacertsPassphrase__ If this option is present it will be used as a passphrase to keystore 
defined in the cacertsLocation. It is only needed if cacertsLocation is 
defined and is protected by password. For default jre cacerts behavior (empty
password) - leace commented.  

 * __certDir__ `/etc/certs/` location of certificates used in configuration files

 * __certDirTemp__ `/etc/certs/temp` temporary location for certificates while user performs update procedures 
 * __servicesRestartTrigger__ `/opt/gluu/trigger_restart_of_services_delete_me_to_do_so` File to 
be deleted to trigger restart of appliance services.

 * __oxtrust.auth.mode__  set this to "basic" without the quotation to use basic authentication or leave it blank to use oxAuth

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

These are the properties oxTrust uses to connect to LDAP

 * __bindDN__ 

 * __bindPassword__ 

 * __servers__ `localhost:1636`

 * __useSSL__ `TRUE | false`

 * __maxconnections__ `3`

 * __baseConfigurationDN__ 

 * __createLdapConfigurationEntryIfNotExist__ `TRUE | false`


