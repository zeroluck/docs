# Interception Scripts 

- [Authenticatoin](./authentication.md)
- [Logout](./logout.md)
- [Attribute Transformation](./attribute-transformation.md)
- [Authorization](./authorization.md)
- [SAML Discovery](./saml-discovery.md)
- [ID Generation](./id-generation.md)
- [Post Registration](./post-registration.md)
- [Pre-Registration](./pre-registration.md)


[Gluu](http://gluu.org) has designed OX to be very flexible. OX admins can use Jython scripts to customize behavior. 

Jython was chosen because an interpreted language facilitates dynamic creation of business logic, and makes it easier to distribute this logic to a cluster of OX servers. 

Another advantage of Jython was that developers can use either Java or Python classes. Combined with the option of calling web services from Python or Java, this enables OX to support any crazy requirement.

Domains can use OX "interception" scripts to code their own business logic in eight areas:

1.  **Authentication**: Implement adaptive authentication to identify people in one or more steps.

2.  **Authorization**: Express your policies in Python or Java, or call and external entitlements management system, like XACML or SiteMinder.

3.  **Attribute Transformation**: Create new attributes, change attribute names, or change the value of existing attributes.

4.  **Logout**: Make sure you logout of any backend services, such as an external IDP or porotal, or SSO environment.

5.  **ID Generation**: People don't see their internal id, but domains may want to use one convention or another to provide a "primary key" value to identify an entity (person, client, etc.) UUID's are the most common, but also used is IPv6 addresses, DNS style names, or custom schemes. 

6.  **Pre-Registration**: You may want to check that this person is not a duplicate before you create an account. Duplicates may be re-directed to a credential reset workflow.

7.  **Post-Registration**: After a person is added, there is a hook to call web services or other business logic.

8.  **SAML Discovery**: The goal of a "Where Are You From" (WAYF) service is to guide a user to his or her Identity Provider. Some documentation also calls this the "Identity Provider Discovery" service. Basically, all the WAYF has to accomplish, is to present the user a list of Identity Providers and redirect the user's web browser to the selected Identity Provider (IdP) or back to the Service Provider (the web application that the user is trying to access). Some WAYFs have additional features which enhance the user's ease-of use. This includes several methods of remembering or guessing the user's Identity Provider selection. Usually by storing a persistent cookie which indicates the user's previous choice of Identity Provider.

