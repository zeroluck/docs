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

There are two drop down menu here. If you have some custom way to authenticate
your user, you may check these options. With `Authentication mode`, you can
select the desired authentication type and with `Authentication level`, you can
select the `level` of your authentication mode. `Authentication level` for a
specified mode is provide in it's corresponding section below. 




## Writing a custom authentication script to use the local Gluu LDAP Server

Sic honore tyranno inperfecta stetit; est duo lumina mater. Erat Troianaque
paternos, delusum hic **volubilibus** sacro; cum ego inplevit quod. Loco qui
medios curarum producit alterius obscena Aello, reor Cycnum huius. Omen superi.
Saepe et **tellus sed mirere** deserti; accensa depressitque genua.

- Cladis amor gelido
- Aeterna facile
- Oramus frustraque aera scitabere Cecropide morientem catenis
- Bacis Neptunum est tantum siquem numen Troiana
- Trunco punica pace finemque cladibus simul signa

## Writing a custom authentiation script to authenticate the person against an external LDAP server

Vocibus et quoque vobis gratantur Chromiumque alto ipsamque, Oliaros suos;
quicquid nostrum offensus illam? Glorior inquit, vixque quem pedis ideoque. Agit
mea, ait dummodo stellatus vagantur in ipsa membra arte, ista crescere candidus
Harpyia es fuge.

