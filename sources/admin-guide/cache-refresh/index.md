[TOC]
# Introduction
Cache Refresh (CR) was built by Gluu to pull user information from a
backend customer Active Directory/[LDAP][ldap] Server. Cache refresh
dynamically synchronizes user information from the backend data source
of the customer to the Gluu Server in order to maximize performance.
This feature is sensitive in nature and any incorrect action may result
in loss of data within the Gluu Server.

## Overview
When configured for Cache Refresh, oxTrust acts as a metadirectory. It
periodically retrieves the full data set from each source LDAP server,
hashes the values, and stores this hash on the disk--a snapshot file.
Subsequent results are compared with the last snapshot. Using set
subtraction, oxTrust can calculate which entries have changed. Please
note that this method of synchronization requires periodic data
integrity checking, as there is no assured messaging. Alternately, you
can just remove the user data, and refresh it from the source. However,
be careful if updates are allowed for synchronized entries!

The interval between data refresh is configurable in the oxTrust GUI.
You can also enable an attribute transformation script if you need to
derive attributes. For example, let's say you need an attribute called
“payingCustomer” and that information is derived by calling an API. You
also have access to the source values, and can use these to calculate
new attributes, or even change the value of existing attributes.

For each source LDAP server, the Gluu Server deployer needs to know the
LDAP connection details, and have credentials for a user with read
access (as needed) to the LDAP tree. At a minimum: host, port, bind DN,
bind password, base DN for search, and object class of person entry.
Please note that the usage of [LDAPS (LDAP over SSL)][ldap] is strongly
recommended.

![Cahce_refresh_diagram](https://cloud.githubusercontent.com/assets/5271048/8237617/4df7d88e-15b6-11e5-98eb-5bb0376b9750.png)

As you can see in the above diagram, 'Cache Refresh Engine' and
'Authentication Manager' are each connected separately to the backend
AD/LDAP. Both Engine and Manager need to know how and where to search
for a user when the user authenticates through the Gluu Server for any
kind of single sign-on operation. Any failure in these two connections
will halt the users ability to log into the system.

# Using Cache Refresh
Cache Refresh must be enabled from the [System Configuration](http://www.gluu.org/docs/admin-guide/configuration/#system-configuration) of the [Organization Configuration](http://www.gluu.org/docs/admin-guide/configuration/#organization-configuration) under Configuration menu.

The Gluu Server has two LDAP integrations: (1) authentication and (2)
identity mapping. Only sometimes it is the same LDAP server. To
synchronize user accounts from an external LDAP directory server, you
can use the built-in oxTrust features for ”Cache Refresh”, which support
mapping identities from n number of source directory servers.

After configuring Cache Refresh, you should give it some time to run,
and populate the LDAP server. Here are some tips before you get started:

* Enable 'Keep External Person' during CR setup. This will allow your
default user 'admin' to log into Gluu Server after initial Cache Refresh
iteration. If you do not enable 'Keep External Person', your 'admin'
user including all other test users will be gone after first Cache
Refresh iteration.

* Make sure you are using LDAP authentication, not VDS. You'll only need
VDS setting if you're using the Radiant Logic Virtual Directory Server.

* Check the snapshots folder to see if files are being created.

* Use the oxTrust admin to browse users.

* Use `ldapsearch` to check to see if results are starting to come in.
The following command will search total number of users in the Gluu
LDAP:

```
# /opt/opendj/bin/ldapsearch -h localhost -p 1636 -Z -X -D "cn=directory manager" -w 'pass_of_ldap_ -b 'ou=people,o=DA....,o=gluu' dn | grep "dn\:" | wc -l
```

* Try to login with one of these users… assuming you've also setup your
Gluu Server to use the correct LDAP server for authentication.

## Configuring 'Cache Refresh Engine' in Gluu Server
The deployer needs to know various values of his own backend AD to
configure this part. For example, host & port, bindDN user information,
bindDN password, Objectclasses, attributes whose information will be
pulled etc.

In addition, the deployer also needs to know generic information of his
Gluu Server's LDAP. By default, deployer can use 'localhost:1636',
'cn=directory manager', 'password what he chose during installation',
'ou=people,o=site' as server information, bindDN, bindDN password and
baseDN respectively.

After collecting this information, deployer can move forward with the
setup of the Cache Refresh engine.

## Configuring 'Authentication Manager' in Gluu Server
This manager knows where to search for users when a request comes in.
The deployer needs to put his own backend AD's information here which
will allow the Gluu Server to connect and search for specific users
based on Username/UID/sAMAccountName.

To describe the picture a bit:

1. backend AD and Cache Refresh Engine are always connected and talking
to each other to check if any user's information are updated or not.

2. Cache Refresh Engine and Gluu LDAP are always connected. After
getting information from #1 point, Gluu server updates user's
information in 'Gluu LDAP'.

3. Authentication Manager is also connected with backend AD and this
manager has information of backend AD.

Here's a real life scenario:

a. A user is trying to log into Gluu Server.

b. After login, Gluu server takes this user's information and checks
'Gluu LDAP' to see if this user is available in Gluu Server or not.

c. If the user is present in Gluu Server then the workflow goes to
'Authentication Manager' as it can check the user's password against
customer's backend.

After successful completion of b and c, user will be logged into the
Gluu Server.

What might be the best practice to complete this identity mapping
successfully?

1. Configure Cache Refresh. Enable 'Keep External Person' during CR
setup. This enabling will allow your default user 'admin' to log into
the Gluu Server after initial Cache Refresh iteration. If you do not
enable 'Keep External Person', your 'admin' user including all other
test users will be gone after the first Cache Refresh iteration.

2. Test if you were able to successfully import all your users
information into the Gluu Server or not. After 10-30 minutes, check
user's information in the Gluu Server. If everything looks good you can
move forward.

3. Configure Authentication Manager. Provide your backend information
here. Test LDAP connection. If both look good and work as expected, you
can 'Update' this setup.

4. Open a new browser and try to log into Gluu Server with your AD
credentials. If you fail, check the log files for failure information.

## Configuring Cache Refresh From oxTrust
For a successful Cache Refresh setup, you have to insert data in ALL FIELDS below.

![Cache Refresh Menu](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_menu.png)

* _Last Run:_ The date and time of the latest cache refresh cycle completion is shown in the last run.

* _Updates at the Last Run:_ This shows the total number of users who have been updated in the last Cache Refresh cycle. For example an user who has any of his attribute updated will show up here.

* _Problem at the Last Run:_ This shows the number of users who have been rejected by the Gluu Server during the update. If there are any rejections, please contact Gluu Support for clarification and help.

![Last Run](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_lastrun.png)

### Customer Backend Key and Attributes
![Customer Backend Key](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_backend.png)

* _Key Attribute:_ This is the unique key attribute of backend Active Directory/LDAP Server such as SAMAccountname for any Active Directory.

* _Object Class:_ This contains the object classes of the backend Active
  Directory/LDAP which have permission to talk to the Gluu Server Cache
  Refresh such as person, organizationalPerson, user etc.

* _Source Attribute:_ This contains the list of attributes which will be
  pulled and read by the Gluu Server.

* _Custom LDAP Filter:_ If there is any custom search required, this
filtering mechanism can be used such as `sn=*` where the value of this
field ensures that every user must contain an attribute named SN.

### Source Backend LDAP Servers

![Source Backend](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_sourcebackend.png)

This section allows the Gluu Server to connect to the backend Active
Directory/LDAP server of the organization.

* _Name:_ Please input **source** as the value.

* _Use Anonymous Bind:_ Some customers do now allow username/password connections to their backend server. Enable this option if this applies to your organization.

* _Bind DN:_ This contains the username to connect to the backend
  server. You need to use full DN here. As for example,
  `cn=gluu,dc=company,dc=org`.

* _Use SSL:_ Use this feature if the backend server allows SSL connectivity.

* _Max Connections:_ This value defines the maximum number of
  connections that are allowed to read the backend Active Directory/LDAP
  server. It is recommended to keep the value 2 or 3.

* _Server:_ This contains the backend Active Directory/LDAP server
  hostname with port, i.e. `backend.organization.com:389`. If your
  organization has a failover server, click **Add Server** and more
  hostnames with the according port.

* _Base DN:_ This contains the location of the Active Directory/LDAP
  tree from where the Gluu Server shall read the user information.

* _Enabled:_ This checkbox is to save and push the changes and only to
  be used when the server administrator has entered all the required
  values.

* _Change Bind Password:_ This can be used for a new password or to
  change any existing password.

If any organization has multiple Active Directory/LDAP server, click on
**Add source LDAP server** and add the additional server information.
Please remember that a *failover server* is not a new server.

### Inum LDAP Server

![Inum LDAP Server](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_inum.png)

This section of the application allows the server administrator to
connect to the internal LDAP of the Gluu Server.

* _Name:_ This contains the name of the Gluu LDAP server, i.e. `inumdb`.

* _Bind DN:_ This field contains the username to connect to the internal
server. The default BindDN for Gluu Server is `cn=directory manager`.

* _Use SSL:_ Please tick the checkbox because the SSL has to be
  activated.

* _Max Connections:_ The recommended number of connections is 2.

* _Server:_ The hostname of the server with IP should be put here. The
  default server address for the Gluu Server is `localhost:1636`.

* _Base DN:_ This contains the Gluu Server LDAP tree which is allowed to
  access the user information. The default Base DN is `ou=people,o=site`.

* _Enabled:_ Enabling this feature saves the values inside the Gluu
  Server.

* _Change Bind Password:_ This option can be used to bind/change the
  password to connect to the internal LDAP of the Gluu Server. Bind
  Password is the same password which you inserted during installation of
  Gluu Server.

* _Refresh Method:_ The Gluu Server allows the Server Administrator to
  apply two types of Cache Refresh mechanism--(1) VDS Method, and (2) Copy
  Method.

  1. _VDS Method:_ Any organization with a database like *mysql* can use
  the VDS method. This option can be enabled via the dropdown menu in
  Refresh Method option.

![Refresh VDS](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_refresh_vds.png)

  2. _Copy Method:_ If the organization has any kind of Active
  Directory/LDAP server, they are strongly recommended to use the *Copy
  Method* from the dropdown menu.

![Refresh Copy](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_refresh_copy.png)

### Attributes Mapping

When the Copy method is selected, a section for Attribute mapping will
be exposed. In this section, the Gluu Server Administrator can map any
attribute from the backend Active Directory/LDAP to the LDAP cache of
the Gluu Server.

![Attribute Mapping](https://cloud.githubusercontent.com/assets/5271048/7093434/b8a04996-df7e-11e4-977d-b8fcdf5381d7.png)

In the source attribute to destination attribute mapping field, you can
enter the source attribute value on the left, and the destination
attribute on the right. In other words, you can specify what the
attribute is on the backend in the left field, and what it should be
rendered as when it comes through the Gluu Server in the right field.

The Administrator can select any Cache Refresh Method according to the
backend Active Directory/LDAP server, but there are some essential
values for both types of cache refresh method. The values are given
below:

  * _Pooling Interval (Minutes):_ This is the interval value for running
  the Cache Refresh mechanism in the Gluu Server. It is recommended to be
  kept higher than 15 minutes.

  * _Script File Name:_ Gluu Server Cache Refresh can accept any kind of
  Jython Script which might help to calculate any custom/complex
  attribute, i.e. eduPersonScopedAffiliation calculation is highly
  targeted field where such scripts can be used. For more information
  please contact Gluu Support.

  * _Snapshot Folder:_ Every cycle of of Gluu Server Cache Refresh cycle
  saves an overall snapshot and problem-list record on a specified
  location. This is where the Gluu Server Administrator can specify the
  location. A Gluu Server administrator can easily decide whether Cache
  Refresh has synchronized all users or not. In general, the rejected
  users are enclosed in the problem-list file. An overall report is
  displayed at the top of the Cache Refresh page with headings **Updated
  at the last run** and **Problems at the last run**.

  * _Snapshot Count:_ This defines the total number of snapshots that
  are allowed to be saved in the hard drive of the VM. It is recommended
  to be kept to 20 shapshots.

Latest Gluu Servers--including the Community Edition--introduced two
upgraded sections here:

  * _Server IP Address:_ Include the IP of your Gluu Server here. This
  feature basically added to run Cache Refresh mechanism perfectly in
  clustered environment.

  * _Removed Script File Name location:_ This allows the Gluu Server
  Administrator to manage your custom scripts with more interactive
  section under configuration named Manage Custom Scripts.

  * _Update:_ This button is used to push the changes in the Gluu
  Server. Only, press the button if the values have been entered.

  * _Update and Validate Script:_ This button is used to test the
  operation and integrity of any custom script such as a Jython Script.

* _Name:_ Please input **source** as the value.

* _Use Anonymous Bind:_ Some customers do now allow username/password connections to their backend server. Enable this option if this applies to your organization.

* _Bind DN:_ This contains the username to connect to the backend
  server. You need to use full DN here. As for example,
  `cn=gluu,dc=company,dc=org`.

* _Use SSL:_ Use this feature if the backend server allows SSL connectivity.

* _Max Connections:_ This value defines the maximum number of
  connections that are allowed to read the backend Active Directory/LDAP
  server. It is recommended to keep the value 2 or 3.

* _Server:_ This contains the backend Active Directory/LDAP server
  hostname with port, i.e. `backend.organization.com:389`. If your
  organization has a failover server, click **Add Server** and more
  hostnames with the according port.

* _Base DN:_ This contains the location of the Active Directory/LDAP
  tree from where the Gluu Server shall read the user information.

* _Enabled:_ This checkbox is to save and push the changes and only to
  be used when the server administrator has entered all the required
  values.

* _Change Bind Password:_ This can be used for a new password or to
  change any existing password.

If any organization has multiple Active Directory/LDAP server, click on
**Add source LDAP server** and add the additional server information.
Please remember that a *failover server* is not a new server.

### Inum LDAP Server

![Inum LDAP Server](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_inum.png)

This section of the application allows the server administrator to
connect to the internal LDAP of the Gluu Server.

* _Name:_ This contains the name of the Gluu LDAP server, i.e. `inumdb`.

* _Bind DN:_ This field contains the username to connect to the internal
server. The default BindDN for Gluu Server is `cn=directory manager`.

* _Use SSL:_ Please tick the checkbox because the SSL has to be
  activated.

* _Max Connections:_ The recommended number of connections is 2.

* _Server:_ The hostname of the server with IP should be put here. The
  default server address for the Gluu Server is `localhost:1636`.

* _Base DN:_ This contains the Gluu Server LDAP tree which is allowed to
  access the user information. The default Base DN is `ou=people,o=site`.

* _Enabled:_ Enabling this feature saves the values inside the Gluu
  Server.

* _Change Bind Password:_ This option can be used to bind/change the
  password to connect to the internal LDAP of the Gluu Server. Bind
  Password is the same password which you inserted during installation of
  Gluu Server.

* _Refresh Method:_ The Gluu Server allows the Server Administrator to
  apply two types of Cache Refresh mechanism--(1) VDS Method, and (2) Copy
  Method.

  1. _VDS Method:_ Any organization with a database like *mysql* can use
  the VDS method. This option can be enabled via the dropdown menu in
  Refresh Method option.

![Refresh VDS](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_refresh_vds.png)

  2. _Copy Method:_ If the organization has any kind of Active
  Directory/LDAP server, they are strongly recommended to use the *Copy
  Method* from the dropdown menu.

![Refresh Copy](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_refresh_copy.png)

#### Attributes Mapping

When the Copy method is selected, a section for Attribute mapping will
be exposed. In this section, the Gluu Server Administrator can map any
attribute from the backend Active Directory/LDAP to the LDAP cache of
the Gluu Server.

![Attribute Mapping](https://cloud.githubusercontent.com/assets/5271048/7093434/b8a04996-df7e-11e4-977d-b8fcdf5381d7.png)

In the source attribute to destination attribute mapping field, you can
enter the source attribute value on the left, and the destination
attribute on the right. In other words, you can specify what the
attribute is on the backend in the left field, and what it should be
rendered as when it comes through the Gluu Server in the right field.

The Administrator can select any Cache Refresh Method according to the
backend Active Directory/LDAP server, but there are some essential
values for both types of cache refresh method. The values are given
below:

  * _Pooling Interval (Minutes):_ This is the interval value for running
  the Cache Refresh mechanism in the Gluu Server. It is recommended to be
  kept higher than 15 minutes.

  * _Script File Name:_ Gluu Server Cache Refresh can accept any kind of
  Jython Script which might help to calculate any custom/complex
  attribute, i.e. eduPersonScopedAffiliation calculation is highly
  targeted field where such scripts can be used. For more information
  please contact Gluu Support.

  * _Snapshot Folder:_ Every cycle of of Gluu Server Cache Refresh cycle
  saves an overall snapshot and problem-list record on a specified
  location. This is where the Gluu Server Administrator can specify the
  location. A Gluu Server administrator can easily decide whether Cache
  Refresh has synchronized all users or not. In general, the rejected
  users are enclosed in the problem-list file. An overall report is
  displayed at the top of the Cache Refresh page with headings **Updated
  at the last run** and **Problems at the last run**.

  * _Snapshot Count:_ This defines the total number of snapshots that
  are allowed to be saved in the hard drive of the VM. It is recommended
  to be kept to 20 shapshots.

Latest Gluu Servers--including the Community Edition--introduced two
upgraded sections here:

  * _Server IP Address:_ Include the IP of your Gluu Server here. This
  feature basically added to run Cache Refresh mechanism perfectly in
  clustered environment.

  * _Removed Script File Name location:_ This allows the Gluu Server
  Administrator to manage your custom scripts with more interactive
  section under configuration named Manage Custom Scripts.

  * _Update:_ This button is used to push the changes in the Gluu
  Server. Only, press the button if the values have been entered.

  * _Update and Validate Script:_ This button is used to test the
  operation and integrity of any custom script such as a Jython Script.

[ldap]: https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol "Lightweight Directory Access Protocol (LDAP), Wikpedia"
