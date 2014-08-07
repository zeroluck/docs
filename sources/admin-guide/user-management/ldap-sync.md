# User Administration with LDAP Synchronization in Gluu Server

We call it "Cache Refresh". “Cache Refresh” was built by Gluu to pull user
information from a backend customer Active Directory / LDAP server. Cache
Refresh dynamically syncs user information from the customers backend data
source to the Gluu Server in order to maximize performance. Due to the sensitive
nature of this feature (any incorrect action can destroy the data inside the
Gluu Server), it is highly recommended that administrator should sync and try
Cache Refresh in staging environment before production. 

In order to access this feature go to: Configuration → Cache Refresh. 

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/CR/Cache_Refresh_1.png?raw=true)

* _Last run_ : Last run shows the date and time of latest Cache Refresh cycle completion.
* _Updates at the last run_ : Total number of users who have been updated in last Cache Refresh cycle. For example, the organization updated a user’s email address or modified an attribute (i.e userPrincipalName ) in their backend Active Directory / LDAP. 
* _Problem at the last run_ : How many user changes have been “rejected” by Gluu Server during the update. There are various reasons why the Gluu Server may reject changes.

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/CR/Cache_Refresh_2.png?raw=true)

## Customer backend key/attributes

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/CR/Cache_Refresh_3.png?raw=true)

* _Key attribute_ : The unique key attribute of backend Active Directory / LDAP server. i.e: sAMAccountname for any Active Directory.
* _Object class_ :  OCs of backend Active Directory/LDAP which has permission to talk to Gluu Server Cache Refresh. i.e: person, organizationalPerson, user etc.
* _Source attribute_ : List of attributes which will be pulled and read by Gluu Server.
* _Custom LDAP filter_ : If there is any custom searching required, this filtering can be used. i.e: “sn=*” value of this field ensures that “every user must have an attribute named SN”

## Source Backend LDAP servers

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/CR/Cache_Refresh_4.png?raw=true)

This section allows the Gluu Server to connect to the Organization’s backend
Active directory / LDAP server. 

* _Name_ : Keep the value “source”
* _Use Anonymous Bind_ : Some may not allow user/password connections to their backend. Enable this if that applies to your organization. Bind DN: Username to connect backend.
* _Use SSL_: If backend server allows SSL connectivity, use this feature
* _Max connections_ : Total number of simultaneous connections which are allowed to read backend Active Directory / LDAP. It’s better to keep this value from 2 to 3.
* _Server_ : Backend Active Directory / LDAP server hostname with port. i.e: backend.organization.com:636 or backend.organization.com:389.  If Organization has a failover server, click “Add server” (below the previously provided server hostname ) and add more hostnames with port.
* _Base DN_ : Location of the Active Directory / LDAP tree, where the Gluu Server will connect to read user information.
* _Enabled_ : After the server administrator has entered all values, checking ‘Enabled’ will save and push all changes.
* _Change Bind Password_ : New password / Changed password can be provided with this feature.

If any organization has more than one Active Directory / LDAP server, click on
“Add source LDAP server” and add the additional server’s informations like
before. Please note that a “Failover server” is NOT “A new server". 

## Inum LDAP server

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/CR/Cache_Refresh_5.png?raw=true)

This section of the application allows the server administrator to connect the
Gluu Server’s internal LDAP.

* _Name_ : Name of Gluu LDAP server
* _Bind DN_ : Username to connect.
* _Use SSL_ :  Yes
* _Max connections_ : Gluu recommends 2
* _Server_ : Server’s hostname with port
* _Base DN_ : Gluu Server LDAP tree which is allowed for user’s information.
* _Enabled_ : Enabling this feature will save values inside the Gluu Server.
* _Change Bind Password_ : Password to connect the Gluu Server’s LDAP can be applied / changed with this option.

## Refresh method

The Gluu Server allows administrators to apply two types of Cache Refresh
mechanism: 1. VDS method, 2. Copy method. 

### VDS method

An organization with a database like mysql can use the VDS method. It can be enabled via the “Refresh
Method” drop down menu.

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/CR/Cache_Refresh_6.png?raw=true)

### COPY method

If the Organization has any kind of Active Directory or LDAP server, they should
use “Copy” method for Cache Refresh operation. Select “Copy” from the “Refresh
Method” drop down menu.

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/CR/Cache_Refresh_7.png?raw=true)

Attribute mapping is an important aspect of the Copy method. In this section,
the Gluu Server administrator can map any attribute from the backend Active
Directory / LDAP to the Gluu Server’s LDAP cache. 

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/CR/Cache_Refresh_8.png?raw=true)

Click the “Add source attribute to destination attribute mapping” link and a new
row with two boxes will appear. The left box is for the backend Active Directory
/ LDAP attribute and the right box is for the Gluu Server’s LDAP attribute. In
the above image we are mapping “sAMAccountname” from the backend server to “uid”
in the Gluu Server LDAP.

Every new row is for a new attribute mapping. The Gluu Server Administrator can
delete any mapping by clicking the ‘x’ button on the right side of every row.

Gluu Server Administrator can select any type of Cache Refresh method according
to his/her organization’s choice but there are some values which are unique for
all types of Cache Refresh methods. Those values are: 

* _Pooling Interval (minutes)_ :
Interval value for running the Cache Refresh mechanism in the Gluu Server. It is
highly recommend not to keep this value BELOW 15 mins.

* _Script File Name_ :
Gluu Server Cache Refresh can accept any kind of Jython script which might help
to calculate any custom / complex attribute. i.e: eduPersonScopedAffiliation
calculation is a highly targeted field where such type of scripts can be use.

* _Snapshot Folder_ : 
Every cycle of Gluu Server Cache Refresh cycle save a overall snapshot and
problem-list record on a specified location. This is the place where that
location can be added. From these snapshots a Gluu Server Administrator can
easily decide whether Cache Refresh synced all users or not. Generally user’s
record which are rejected enclosed in problem-list file. An overall report is
being displayed at the top of this Cache Refresh page “Updated at the last run”
and “Problems at the last run” section which we described previously.

* _Snapshot count_ : 
Total number of allowed snapshots to be saved in VM’s hard drive. Gluu
recommends 20. 

* _Update_ :
After completion of every entry, hit this button to apply the changes in Gluu
Server.

* _Update and Validate script_ :
If Cache Refresh has any custom script ( i.e Jython script ), this button can be
used to “test” the script’s operation.



