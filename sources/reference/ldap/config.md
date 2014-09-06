# LDAP Server Configuration

## OpenDJ

There are a few default configuration changes you need for the Gluu Server needs. Read the man
page To learn [dsconfig](http://opendj.forgerock.org/opendj-server/doc/admin-guide/index/dsconfig-1.html) 
what options you need for your environment. The changes are:
                   
 * `set-global-configuration-prop --set single-structural-objectclass-behavior:accept`

 * `set-attribute-syntax-prop --syntax-name Directory String --set allow-zero-length-values:true`

 * `set-password-policy-prop --policy-name Default Password Policy --set allow-pre-encoded-passwords:true`

