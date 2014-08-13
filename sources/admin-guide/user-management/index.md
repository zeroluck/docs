# User Administration 

- [LDAP Synchronization](./ldap-sync.md)
- [SCIM Interface](./scim.md)
- [Registration](./registration.md)
- [Local User Management](./local-user-mgt.md)

To keep the Gluu Server up-to-date with the latest user claims, your organization can either "push" or "pull" identity data. In the "pull" mode, The Gluu Server can use an existing LDAP identity source, like Microsoft Active Directory. If you "push" identies to the Gluu Server, you can use the JSON/REST [SCIM API](http://www.simplecloud.info)

And there is one more option... the Gluu Server has some basic registration capabilitlies: Public Registration and Invitation Code Registration. The Gluu Server can serve as a Web interface to let people update their user claims, and reset their credentials. It can even serve as an intra-domain white pages.

For more information, refer to the sections listed above.

