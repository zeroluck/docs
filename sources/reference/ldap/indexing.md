# Indexing

All databases need proper indexing to function. This is particularly true for LDAP servers. 
There should never be any `sub` or `one` scoped searches to the LDAP server that are not
properly indexed. Because indexing is implemenation specific, the following guidelines 
should provide a good starting point. The LDAP server logs should be periodically analyzed to
identify un-indexed searches. The exact indexing requirements may vary based on custom attributes,
and custom authentication and authorization requirements.

## OpenDJ Indexing

[Indexing Attribute Values](http://opendj.forgerock.org/opendj-server/doc/admin-guide/index/chap-indexing.html)


## 389DS Indexing

[Indexing Architecture](http://directory.fedoraproject.org/wiki/Database_Architecture#Indexing)

## OpenLDAP Indexing configuration


[OpenLDAP Tuning](http://www.openldap.org/doc/admin24/tuning.html)


**Recommended Indexes for OX**

Indexed attributes in opends on seed.gluu.org server:

 | cn               | equality, substring | default | 
 | --               | ------------------- | ------- | 
 | entryUUID        | equality            | default | 
 | givenName        | equality, substring | default | 
 | mail             | equality, substring | default | 
 | member           | equality            | default | 
 | sn               | equality, substring | default | 
 | telephoneNumber  | equality, substring | default | 
 | uid              | equality            | default | 
 | uniqueMember     | equality            | default | 
 | uniqueIdentifier | equality            | Gluu    | 
 | inum             | equality            | Gluu    | 
 | oxid             | equality            | Gluu    | 
 | lastModifiedTime | ordering            | Gluu    | 
 | oxAuthExpiration | ordering            | Gluu    | 

## Configuring LDAP indexing to improve OX applications performance

In order to keep optimal server load it's necessary to configure indexing for OpenDJ LDAP server. OpenDJ support these index types: approximate, equality, ordering, presence, substring, virtual list view, extensible matching rule. There is more information about index types in [OpenDJ Admin Guide](http://opendj.forgerock.org/opendj-server/doc/admin-guide/#indexes-overview). It's possible to add them for any LDAP attribute. OpenDJ will use them during searching result entries.

Default OpenDJ installation has few preconfigured indexes for these attributes: aci, cn, dn2id, ds-sync-conflict, ds-sync-hist, entryUUID, givenName, id2children, id2subtree, mail, member, objectClass, sn, telephone­Number, uid, unique­Member. This table contains definition of these indexes: [default Indexes](http://opendj.forgerock.org/opendj-server/doc/admin-guide/#default-indexes).

## oxAuth filters

oxAuth has few parts which allows to specify custom LDAP filters:

	
	
	`<auth-filters-enabled>`true`</auth-filters-enabled>`
	`<auth-filters>`
	    `<auth-filter>`
	        `<!--filter>`(&amp;(associatedClient=*{0}*)(myPinCode={1}))`</filter-->`
	        `<filter>`(&amp;(mail=*{0}*)(inum={1}))`</filter>`
	        `<!-- If bind=true oxAuth should try to bind to entry which it found by filter specified above -->`
	        `<bind>`false`</bind>`
	        `<base-dn>`o=gluu`</base-dn>`
	    `</auth-filter>`
	
	    `<auth-filter>`
	        `<filter>`uid={0}`</filter>`
	        `<bind>`true`</bind>`
	        `<bind-password-attribute>`pwd`</bind-password-attribute>`
	        `<base-dn>`o=gluu`</base-dn>`
	    `</auth-filter>`
	`</auth-filters>`
	
	`<!-- Custom client filters to be able identify client by custom id. -->`
	`<client-auth-filters-enabled>`true`</client-auth-filters-enabled>`
	`<client-auth-filters>`
	    `<client-auth-filter>`
	        `<filter>`myCustomAttr1={0}`</filter>`
	        `<base-dn>`ou=clients,o=@!1111,o=gluu`</base-dn>`
	    `</client-auth-filter>`
	    `<!--client-auth-filter>`
	        `<filter>`(&amp;(myCustomAttr1={0})(myCustomAttr2={0}))`</filter>`
	        `<base-dn>`ou=clients,o=@!1111,o=gluu`</base-dn>`
	    `</client-auth-filter-->`
	`</client-auth-filters>`
	



oxAuth uses them to find clients. Hence it's necessary to configure indexing for these filters. Without them OpenDJ might use unindexed search if there are no indexes for these filter's attributes.

## Determining what needs indexing

OpenDJ has built in functionality which allows to find unindexed searches. More information about this part is available in OpenDJ Admin Guide [Determining What Needs Indexing](http://opendj.forgerock.org/opendj-server/doc/admin-guide/#debug-search-indexes).

## Sample commands to add indexes

Add index for inum attribute.

	
	./dsconfig create-local-db-index --backend-name userRoot --type generic --index-name inum --set index-type:equality --set index-entry-limit:4000 --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt
	./dsconfig set-backend-prop --backend-name userRoot --set enabled:false --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt
	./rebuild-index --baseDN o=gluu --index inum
	./dsconfig set-backend-prop --backend-name userRoot --set enabled:true --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt
	
	./dsconfig create-local-db-index --backend-name inumDB --type generic --index-name inum --set index-type:equality --set index-entry-limit:4000 --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt
	./dsconfig set-backend-prop --backend-name inumDB --set enabled:false --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt
	./rebuild-index --baseDN o=site --index inum
	./dsconfig set-backend-prop --backend-name inumDB --set enabled:true --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt


Add index for uniqueIdentifier attribute.

	
	./dsconfig create-local-db-index --backend-name userRoot --type generic --index-name uniqueIdentifier --set index-type:equality --set index-entry-limit:4000 --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt
	./dsconfig set-backend-prop --backend-name userRoot --set enabled:false --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt
	./rebuild-index --baseDN o=gluu --index uniqueIdentifier
	./rebuild-index --baseDN o=site --index uniqueIdentifier
	./dsconfig set-backend-prop --backend-name userRoot --set enabled:true --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt


Add index for oxId attribute.

	
	./dsconfig create-local-db-index --backend-name userRoot --type generic --index-name oxId --set index-type:equality --set index-entry-limit:4000 --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt
	./dsconfig set-backend-prop --backend-name userRoot --set enabled:false --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt
	./rebuild-index --baseDN o=gluu --index oxId
	./rebuild-index --baseDN o=site --index oxId
	./dsconfig set-backend-prop --backend-name userRoot --set enabled:true --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt


Add index for lastModifiedTime attribute.

	
	./dsconfig create-local-db-index --backend-name userRoot --type generic --index-name lastModifiedTime --set index-type:ordering --set index-entry-limit:4000 --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt
	./dsconfig set-backend-prop --backend-name userRoot --set enabled:false --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt
	./rebuild-index --baseDN o=gluu --index lastModifiedTime
	./rebuild-index --baseDN o=site --index lastModifiedTime
	./dsconfig set-backend-prop --backend-name userRoot --set enabled:true --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt


Add index for oxAuthExpiration attribute.

	
	./dsconfig create-local-db-index --backend-name userRoot --type generic --index-name oxAuthExpiration --set index-type:ordering --set index-entry-limit:4000 --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt
	./dsconfig set-backend-prop --backend-name userRoot --set enabled:false --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt
	./rebuild-index --baseDN o=gluu --index oxAuthExpiration
	./rebuild-index --baseDN o=site --index oxAuthExpiration
	./dsconfig set-backend-prop --backend-name userRoot --set enabled:true --hostName host --port 4444 --bindDN cn=Directory\ Manager -j /tmp/.pw --trustAll --noPropertiesFile --no-prompt


Determine current status of indexes.

	
	./dbtest list-index-status --backendID userRoot -b o=gluu



