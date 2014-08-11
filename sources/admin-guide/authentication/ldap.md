# LDAP Authentication


## Manage LDAP Authentication panel

This feature allows the Gluu Server Administrator to define how and where the
server should connect to authenticate users. If it is a remote LDAP / Active
Directory server, values are required. These values can also be used if the
Organization uses the Gluu Server’s local LDAP for authentication. 

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/Configuration/Authentication/Manage_Authentication_LDAP.jpg?raw=true)

* _Deactivate_ : This button Activates/Deactivates the Gluu Server accessibility for authentication.
* _Name_ : Name of the authentication server.
* _Bind DN_ : Username to connect authentication server ( local LDAP / Remote AD / Remote LDAP )
* _Use SSL_ : If the authentication server needs to use a secured port ( i.e: 636 or 1636 ), this feature should be activated.
* _Max Connections_ : This box can be used to define the total number of simultaneous connections allowed for reading LDAP/Remote AD/LDAP server.
* _Server_ : Authentication server’s unique name with port number. ( i.e: auth.company.com:636 )
* _Base DN_ : Add Base DNs which allow the Gluu Server to connect and search the LDAP. Every directory tree should be added separately by using “Add base DN” option.
* _Primary key_ : Primary key to connect authentication server. (i.e: sAMAccountName / uid / mail etc)
* _Local Primary Key_ : Name of Gluu Server’s internal LDAP primary key. Generally, this is usually either “uid” or “mail”
* _Enabled_ : Activate this key after successful insertion of data.
* _Change Bind Password_ : Use this button to provide a passphrase which can be used to authenticate the authentication server.
* _Test LDAP Connection_ : Let’s check if our provided information can really connect to the authentication server. This scan is real time and should be used by all Gluu Server Administrators.

## Default Authentication Method: 

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/Configuration/Authentication/Default_Auth_method.png?raw=true)

There are two drop down menus here. If you have some custom way to authenticate
your user, you may check these options. With `Authentication mode`, you can
select the desired authentication type and with `Authentication level`, you can
select the `level` of your authentication mode. `Authentication level` for a
specified mode is provide in it's corresponding section below. 

Otherwise keep them `Default`. 

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/Configuration/Authentication/Default_Auth_method.png?raw=true)

## Manage Custom Authentication Methods

Out of the box, the Gluu Server supports username/password authentication
against the local LDAP or a remote Active Directory/LDAP. In addition, oxTrust
provides the interface for inserting Jython code to enable dynamic
authentication logic, including the use of any strong, multi-step authentication
process. Gluu can write these scripts for premium customers and typically makes
the script open source for other organization’s use. Currently supported
two-factor authentication mechanisms can be found at: http://gluu.org/two-factor

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/Configuration/Authentication/Custom_Auth.png?raw=true)

* _Name_ : A unique name should be defined for every authentication method. For example, in the screenshot above, sections which represent Duo two-factor authentication are appropriately named “Duo.”
* _Level_ : Here you can specify a domain-relevant security level for each authentication method supported by your organization. 
* _Usage type_ : `interactive`
* _Custom property ( key/value)_ : Every 2FA method has it’s own key values. Typically these are provided by the two-factor authentication company. We have our own open source 2FA authentication script, named [oxPush](http://www.gluu.org/press-releases/2013/gluu-developing-oxpush-to-enable-push-notifications-for-two-factor-authentication/). 

There are more information on Authentication [here](http://www.gluu.org/docs/admin-guide/authentication/).


