The Gluu Server has two LDAP integrations: (1) authentication and (2) identity mapping. Only sometimes is the same LDAP server. To synchronize user accounts from an external LDAP directory server, you can use the built-in oxTrust features for ”Cache Refresh”, which support mapping identities from n number of source directory servers.

When configured for Cache Refresh, oxTrust acts as a metadirectory. It periodically retreives the full data set from each source LDAP servers, hashes the values, and stores this hash on the disk–a snapshot file. Subsequent results are compared with the last snapshot. Using set subtraction, oxTrust can calculate which entries have changed. Note: this method of syncrhonization requires periodic data integrity checking, as there is no assured messaging. Alternately, you can just remove the user data, and refresh it from the source. However, be careful if use updates are allowed for syncrhonized entries!

The interval between data refresh is configurable in the oxTrust GUI. You can also enable an attribute transformation script if you need to derive attributes. For example, let's say you need an attribute called “payingCustomer” and that information is derived from calling an API. You also have access to the source values, and can use these to calculate new attributes, or even change the value of existing attributes.

For each source LDAP server, the Gluu Server deployer needs to know the LDAP connection details, and have credentials for a user with read access (as needed) to the LDAP tree: at a minimum: host, port, bind DN, bind password, base dn for search, objectclass of person entry. Note: LDAPS should always be used.

After configuring cache refresh, you should give it some time to run, and populate the LDAP server. Here are some tips before you get started:

- Enable 'Keep External Person' during CR setup. This enabling will allow your default user 'admin' to log into Gluu Server after initial Cache Refresh iteration. If you do not enable 'Keep External Person', your 'admin' user including all other test users will be gone after first Cache Refresh iteration.

- Make sure you are using LDAP authentication, not VDS. You'll only need VDS setting if you're using the Radiant Logic Virtual Directory Server.

- Check the snapshots folder to see if files are starting to be created.

- Use the oxTrust admin to browse the users

– Use ldapsearch to check to see if results are starting to come in. Give example of ldapsearch

- Try to login with one of these users… assuming you've also setup your Gluu Server to use the correct LDAP server for authentication.
