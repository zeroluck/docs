# Tricks and Troubleshooting tips on authentication

## FAQ

### _I have applied the new authentication script but I am unable to login now. Is there any way I can fix this or revert to previous stable condition?_

* Yes. First point to be noted that, always use two active browsers if you test new authentication script. In first browser you will be "always logged-in user" and in second browser you will do all kind of testing. If you want to make any changes you can do that in first browser.

* Authentication scripts are always included in _oxIDPAuthentication_ section. If you want to revert the changes to previous stable condition. Just remove your desired _oxIDPAuthentication_.

#### Here is one sample operation on how to unlock yourself from IDP: 

* SSH into IDP, become user _ldap_ [The same operation can be performed with any LDAP browser ]

* Backup existing _oxIDPAuthentication_ section, just in case if you require information later on. 

```
/opt/opendj/bin/ldapsearch -h localhost -p 1636 -Z -X -D "cn=directory manager" -j <password_temp_file_location> -b 'o=gluu' -T 'oxIDPAuthentication=*' oxIDPAuthentication > backup_oxIDPAuthentication.ldif
```

* Delete current _oxIDPAuthentication_ . Sample ldif:

        dn: inum=.......,ou=appliances,o=gluu
        changetype: modify
        delete: oxIDPAuthentication

* Add `basic` method. Sample ldif: 

```
dn: inum=.......,ou=appliances,o=gluu
changetype: modify
add: oxIDPAuthentication
oxIDPAuthentication: {"type":"auth","name":"auth_ldap_server","level":0,"priority":0,"enabled":true,"version":10,"fields":[],"config":"{\"configId\":\"auth_ldap_server\",\"bindDN\":\"bindDN_for_your_ldap_server[1]\",\"bindPassword\":\"encrypted_pass_of_your_ldap_server_admin[2]\",\"servers\":[{\"value\":\"localhost:1636\"}],\"maxConnections\":3,\"useSSL\":true,\"baseDNs\":[{\"value\":\"baseDN_location_of_your_ldap_server[3]\"}],\"primaryKey\":\"primaryKey_of_your_ldap_server[4]\",\"localPrimaryKey\":\"uid\",\"useAnonymousBind\":false,\"enabled\":true}"}
```

##### Note:

* [1] encrypted_pass_of_your_ldap_server: The full bindDN path of LDAP / AD user. By default, Gluu's LDAP bindDN user is: `cn=Directory Manager`.

* [2] encrypted_pass_of_your_ldap_server_admin: Encrypted password for
bindDN user. Gluu's bindDN user (CN=Direcotry Manager) password can be collected
from `oxTrust.properties` configuration file. Location of this file is
`/opt/tomcat/conf/` and section which includes this password is
`idp.bindPassword`. 

* [3] baseDN_location_of_your_ldap_server: The full baseDN path of LDAP /
AD. Gluu's baseDN path is:
`ou=people,o=........,o=gluu`.

* [4] primaryKey_of_your_ldap_server: Gluu IDP's primaryKey is 'uid'. It
might 'sAMAccountName' or 'cn' for any AD. 
