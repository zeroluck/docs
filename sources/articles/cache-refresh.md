# Cache Refresh Introduction

The Gluu Server has two LDAP integrations: (1) authentication and (2) identity mapping. Only sometimes is it the same LDAP server. To synchronize user accounts from an external LDAP directory server, you can use the [built-in oxTrust features for ”Cache Refresh”](../admin-guide/configuration/index.md#cache-refresh), which support mapping identities from n number of source directory servers.

When configured for Cache Refresh, oxTrust acts as a metadirectory. It periodically retreives the full data set from each source LDAP server, hashes the values, and stores this hash on the disk–a snapshot file. Subsequent results are compared with the last snapshot. Using set subtraction, oxTrust can calculate which entries have changed. Note: this method of syncrhonization requires periodic data integrity checking, as there is no assured messaging. Alternately, you can just remove the user data, and refresh it from the source. However, be careful if use updates are allowed for syncrhonized entries!

The interval between data refresh is configurable in the oxTrust GUI. You can also enable an attribute transformation script if you need to derive attributes. For example, let's say you need an attribute called “payingCustomer” and that information is derived by calling an API. You also have access to the source values, and can use these to calculate new attributes, or even change the value of existing attributes.

For each source LDAP server, the Gluu Server deployer needs to know the LDAP connection details, and have credentials for a user with read access (as needed) to the LDAP tree. At a minimum: host, port, bind DN, bind password, base dn for search, objectclass of person entry. Note: LDAPS should always be used.

After configuring cache refresh, you should give it some time to run, and populate the LDAP server. Here are some tips before you get started:

- Enable 'Keep External Person' during CR setup. This will allow your default user 'admin' to log into Gluu Server after initial Cache Refresh iteration. If you do not enable 'Keep External Person', your 'admin' user including all other test users will be gone after first Cache Refresh iteration.

- Make sure you are using LDAP authentication, not VDS. You'll only need VDS setting if you're using the Radiant Logic Virtual Directory Server.

- Check the snapshots folder to see if files are being created.

- Use the oxTrust admin to browse users.

* Use ldapsearch to check to see if results are starting to come in. For example: 

        /opt/opendj/bin/ldapsearch -h localhost -p 1636 -Z -X -D "cn=directory manager" -w 'pass_of_ldap_ -b 'ou=people,o=DA....,o=gluu' dn | grep "dn\:" | wc -l

    will search total number of users inside gluu ldap. 

- Try to login with one of these users… assuming you've also setup your Gluu Server to use the correct LDAP server for authentication.

# Cache Refresh Setup Overview
Two separate parts are included in Cache Refresh setup:

1. Configuring Cache Refresh Engine

2. Configuring Authentication Manager

For both configurations, the deployer should have a clear understanding of their own backend server (Active Directory or some other LDAP server) and their Gluu Server's integrated LDAP tree.

![Cahce_refresh_diagram](https://cloud.githubusercontent.com/assets/5271048/8237617/4df7d88e-15b6-11e5-98eb-5bb0376b9750.png)

As you can see in the above diagram, 'Cache Refresh Engine' and 'Authentication Manager' are each connected separately to the backend AD/LDAP. Both Engine and Manager need to know how and where to search for a user when the user authenticates through the Gluu Server for any kind of single sign-on operation. Any failure in these two connections will halt the users ability to log into the system.

We are going to describe a bit on both parts below.

## 1. Configuring 'Cache Refresh Engine' in Gluu Server:

The deployer needs to know various values of his own backend AD to configure this part. For example, host & port, binDN user information, bindDN password, Objectclasses, attributes whose information will be pulled etc.

In addition, the deployer also needs to know generic information of his Gluu Server's LDAP. By default, deployer can use 'localhost:1636', 'cn=directory manager', 'password what he chose during installation', 'ou=people,o=site' as server information, binDN, bindDN password and baseDN respectively.

After collecting this information, deployer can move forward with Cache Refresh Engine setup.

## 2. Configuring 'Authentication Manager' in Gluu Server:

This manager knows where to search for users when a request comes in. The deployer needs to put his own backend AD's information here which will allow the Gluu Server to connect and search for specific users based on Username/UID/sAMAccountName.

To describe picture a bit:

1. backend AD and Cache Refresh Engine are always connected and talking to each other to check if any user's information are updated or not.

2. Cache Refresh Engine and Gluu LDAP are always connected. After getting information from #1 point, Gluu server updates user's information in 'Gluu LDAP'

3. Authentication Manager is also connected with backend AD and this manager has information of backend AD.

Here's a real life scenario:

a. A user is trying to log into Gluu Server. 

b. After login, Gluu server takes this user's information and checks 'Gluu LDAP' to see if this user is available in Gluu Server or not. 

c. If the user is present in Gluu Server then the workflow goes to 'Authentication Manager' as it can check the user's password against customer's backend.

After successful completion of b and c, user will be logged into the Gluu Server.

What might be the best practice to complete this identity mapping successfully?

1. Configure Cache Refresh. Enable 'Keep External Person' during CR setup. This enabling will allow your default user 'admin' to log into the Gluu Server after initial Cache Refresh iteration. If you do not enable 'Keep External Person', your 'admin' user including all other test users will be gone after the first Cache Refresh iteration.

2. Test if you were able to successfully import all your users information into the Gluu Server or not. After 10-30 mins, check user's information in the Gluu Server. If everything looks good you can move forward.

3. Configure Authentication Manager. Provide your backend information here. Test LDAP connection. If both look good and work as expected, you can 'Update' this setup.

4. Open a new browser and try to log into Gluu Server with you AD credential. If you fail, check logs for failure.
