**Table Of Contents** 

- [Working with SCIM Client](#working-with-scim-client)
	- [SCIM 1.1](#scim-1.1)
		- [Creating SCIM client instance](#creating-scim-client-instance)
		- [Adding an entity](#adding-an-entity)
		- [Modifying an entity](#modifying-an-entity)
		- [Deleting an entity](#deleting-an-entity)
		- [Retrieving an entity](#retrieving-an-entity)
		- [Bulk operations](#bulk-operations)
	- [SCIM 2.0](#scim-20)
		- [Creating SCIM client instance](#creating-scim-2-client-instance)
		- [Adding an entity](#adding-an-entity-using-scim-20)
		- [Modifying an entity](#modifying-an-entity-using-scim-20)
		- [Deleting an entity](#deleting-an-entity-scim-20)
		- [Retrieving an entity](#retrieving-an-entity-scim-20)
		- [Bulk operations](#bulk-operations-scim-20)

# Working with SCIM Client
- - -

## SCIM 1.1

Following is the guide to work with SCIM client 1.1. You can checkout
the SCIM client from our [repository at
GitHub](https://github.com/GluuFederation/SCIM-Client).

### Creating SCIM client instance

Below is an example on how to create a ScimClient instance:

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
```

This will create an OAuth instance of ScimClient whereas `userName` and
`passWord` are the user credentials, `clientID` and `clientSecret` are
oxAuth client credentials, and `domainURL` is the domain where SCIM
client resides. For example the `domainURL` can be
`http://localhost:8080/oxTrust/seam/resource/restv1`. The `oxAuthDomain`
is the `tokenURL`, for example
`http://localhost:8080/oxauth/seam/resource/restv1/oxauth/token`.

```
ScimClient client = ScimClient.basicInstance(userName, passWord, domainURL);
```

For the basic authentication you only need the user’s credentials
(userName, passWord) and domain uri.

### Adding an entity

The SCIM Client API comes with two methods to add an entity, i. e.
“createPerson” and “createPersonString”. For *createPerson* you pass the
person you want to add as ScimPerson object. Furthermore, you specify
the desired media type format “XML/JSON” and the SCIM client API will
parse the ScimPerson object into XML or JSON, and send your request.

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
ScimPerson person = new ScimPerson() ;
person.setUserName("sunny");
person.setName.setGivenName("GName");
person.setName.setLastName("LName");
ScimResponse response = client.createPerson(person, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```
<!--
Now, we'll use *createPersonString* to add the person:

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
// ScimResponse response = client.createPersonString(String person, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```
-->

Similarly for groups, you can use createGroup with ScimGroup as a
parameter, or using createGroupString.

``` 
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
ScimGroup groupToAdd = new ScimGroup();
groupToAdd.setDisplayName("ScimObjecttesting");
ScimResponse response = client.createGroup(groupToAdd, MediaType.APPLICATION_JSON);
String responseStr = response.getResponseBodyString();
```

- - -

### Modifying an entity

In this example you will learn how to modify a person or a group using
SCIM Client. The SCIM Client API comes with two methods to accomplish
this, i. e. “updatePerson” and “updatePersonString”. For *updatePerson*
method, you pass both the person you want to update as ScimPerson object
and its uid as a string, and you specify the desired media type format
“XML/JSON”. The SCIM Client API will parse the ScimPerson object into
XML or JSON, and send your request.

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
ScimPerson person = new ScimPerson();
person.setUserName("test");
person.setName.setGivenName("Given");
person.setName.setLastName("Last");
String uid = person.getId();
ScimResponse response = client.updatePerson(person, uid, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```
<!--
```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.updatePersonString(String person, person.uid, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```
-->

The same steps apply for groups. You can use *updateGroupString* with
ScimGroup as a parameter.

<!--

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.updateGroupString(String group, String id, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body
```
-->

- - - 

### Deleting an entity

To delete an entity, you simply pass its ID as a string parameter to
either the “deletePerson” or “deleteGroup” method. In both cases, the
entity has to be registered in the system with an ID, already.

``` 
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
ScimPerson person = new ScimPerson();
ScimResponse response = client.deletePerson(person.getId()); // Here we have person object of type ScimPerson
response.getStatusCode() // this will give you the Status code
```

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimGroup testGroup = new ScimGroup();
ScimResponse response = client.deleteGroup(testGroup.getId());
response.getStatusCode() // this will give you the Status code
```
- - -

### Retrieving an entity

To retrieve a person or a group you can use “retrievePerson” or
“retrieveGroup” method by passing the entitys ID as a parameter and the
desired media type. In both cases the entity has to be registered in the
system with an ID, already.

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimPerson person = new ScimPerson();
ScimResponse response = client.retrievePerson(person.getId(), MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimGroup testGroup = new ScimGroup();
ScimResponse response = client.retrieveGroup(testGroup.getId(), MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```
- - -

### Bulk operations

To use Bulk operation you pass the operation as a ScimBulkOperation object into “bulkOperation” method or as a JSON/XML string into
“bulkOperationString” method and without forgetting to specify the desired media type.

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
final String REQUESTJSON = "{\"schemas\":[\"urn:scim:schemas:core:1.0\"],\"Operations\":[{\"method\":\"POST\",\"path\":\"/Users\",\"data\":{\"schemas\":[\"urn:scim:schemas:core:1.0\"],\"externalId\":\"clientbulk\",\"userName\":\"clientbulk\",\"name\":{\"givenName\":\"clientbulk\",\"familyName\":\"clientbulk\",\"middleName\":\"N/A\",\"honorificPrefix\":\"N/A\",\"honorificSuffix\":\"N/A\"},\"displayName\":\"bulk bulk\",\"nickName\":\"bulk\",\"profileUrl\":\"http://www.gluu.org/\",\"emails\":[{\"value\":\"bulk@gluu.org\",\"type\":\"work\",\"primary\":\"true\"},{\"value\":\"bulk2@gluu.org\",\"type\":\"home\",\"primary\":\"false\"}],\"addresses\":[{\"type\":\"work\",\"streetAddress\":\"621 East 6th Street Suite 200\",\"locality\":\"Austin\",\"region\":\"TX\",\"postalCode\":\"78701\",\"country\":\"US\",\"formatted\":\"621 East 6th Street Suite 200 Austin , TX 78701 US\",\"primary\":\"true\"}],\"phoneNumbers\":[{\"value\":\"646-345-2346\",\"type\":\"work\"}],\"ims\":[{\"value\":\"nynytest_user\",\"type\":\"Skype\"}],\"photos\":[{\"value\":\"http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png\",\"type\":\"gluu photo\"}],\"userType\":\"CEO\",\"title\":\"CEO\",\"preferredLanguage\":\"en-us\",\"locale\":\"en_US\",\"timezone\":\"America/Chicago\",\"active\":\"true\",\"password\":\"secret\",\"groups\":[{\"display\":\"Gluu Manager Group\",\"value\":\"@!1111!0003!B2C6\"},{\"display\":\"Gluu Owner Group\",\"value\":\"@!1111!0003!D9B4\"}],\"roles\":[{\"value\":\"Owner\"}],\"entitlements\":[{\"value\":\"full access\"}],\"x509Certificates\":[{\"value\":\"MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFa MH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo=\"}],\"meta\":{\"created\":\"2010-01-23T04:56:22Z\",\"lastModified\":\"2011-05-13T04:42:34Z\",\"version\":\"aversion\",\"location\":\"http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7\"}},\"bulkId\":\"onebunk\"},{\"method\":\"PUT\",\"path\":\"/Users/@!1111!0000!C4C4\", \"version\":\"oneversion\",\"data\":{\"schemas\":[\"urn:scim:schemas:core:1.0\"],\"displayName\":\"bulk person\",\"externalId\":\"bulk\"}}]}";
ScimResponse response = client.bulkOperation(REQUESTJSON, MediaType.APPLICATION_JSON);
response.getStatusCode() 
String result = response.getResponseBodyString(); 
```
<!--
```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.bulkOperationString(String operation, ScimBulkOperation operation, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```
-->
- - -

## SCIM 2.0

Following is the guide to work with SCIM client 2.0. You can checkout
the according SCIM Client from our [GIT
repository](https://github.com/GluuFederation/SCIM-Client).

### Creating SCIM 2 client instance

Following is example code to create a SCIM 2.0 client instance:

```
Scim2Client client = Scim2Client.oAuthInstance("admin", "pwd", "@!0035.934F.1A51.77B0!0001!402D.66D0!0008!5BAD.32E4", "9e9fef43-0d97-4383-863f-0e828ff0a408", "http://localhost:8085/oxtrust-server/seam/resource/restv1", "http://localhost:8085/oxauth/seam/resource/restv1/oxauth/token");
```

In the mentioned example, we have used the following constructor to
create the client instance (Signature):

```
public static Scim2Client oAuthInstance(String userName, String passWord, String clientID, String clientSecret, String domain,
String oAuthTokenEndpoint)
```

### Adding an entity using SCIM 2.0

The SCIM 2.0 client API comes with two methods to add an entity using
the *createPerson* method. This method expects the person you want to
add as a *ScimPerson* object, and the desired media type format such as
“XML/JSON”. Then, the SCIM client API will parse the ScimPerson object
into XML or JSON, and send your request.

```
Scim2Client client = Scim2Client.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
ScimPerson person = new ScimPerson() ;
person.setUserName("sunny");
person.setName.setGivenName("GName");
person.setName.setLastName("LName");
ScimResponse response = client.createPerson(person, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

Another method of using createPerson is to pass a *'User'* to this method, like:

```
User newUser = new User();
Name name = new Name();
name.setGivenName("Usman");
name.setFamilyName("Khalid");
newUser.setName(name);
newUser.setUserName("usman");
newUser.setDisplayName("Muhammad Usman");
newUser.setTitle("Mr");
newUser.setPassword("password");
newUser.setActive(true);

List<Role> roles = new ArrayList<Role>();
Role role = new Role();
role.setDisplay("ADMIN");
role.setOperation("Operation");
role.setValue("ADMIN");
roles.add(role);
newUser.setRoles(roles);
ScimResponse response1 = scimClient.createPerson(newUser, MediaType.APPLICATION_JSON);		// scimClient is of type Scim2Client
System.out.println("response status:" + response1.getStatus());
System.out.println(response1.getResponseBodyString());

```

Similarly for groups, you can use **createGroup** with object of either
*ScimGroup* or *Group* as a parameter:

```
Scim2Client client = Scim2Client.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
ScimGroup groupToAdd = new ScimGroup();
groupToAdd.setDisplayName("ScimObjecttesting");
ScimResponse response = client.createGroup(groupToAdd, MediaType.APPLICATION_JSON);
String responseStr = response.getResponseBodyString();
```

```
Group newGroup = new Group();
newGroup.setDisplayName("NewTestGroup");
ScimResponse response1 = scimClient.createGroup(newGroup, MediaType.APPLICATION_JSON);	// scimClient is of type Scim2Client
System.out.println("Response status:" + response1.getStatus());
System.out.println(response1.getResponseBodyString());
```

- - -

### Modifying an entity using SCIM 2.0

In this example we will show you how to modify a person or a group using
SCIM 2.0 client. The SCIM client API comes with two methods to
accomplish this using *updatePerson*. This method expects the person you
want to update as a ScimPerson object, and its uid as a string.
Furthermore, specify the desired media type format such as “XML/JSON”.
The SCIM client API will parse the ScimPerson object into XML or JSON,
and send your request.

```
Scim2Client client = Scim2Client.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
ScimPerson person = new ScimPerson();
person.setUserName("test");
person.setName.setGivenName("Given");
person.setName.setLastName("Last");
String uid = person.getId();
ScimResponse response = client.updatePerson(person, uid, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```
Another method of using *updatePerson* is to pass an *User* object to
this method:

```
User newUser = new User();
Name name = new Name();
name.setGivenName("Updated");
name.setFamilyName("User");
newUser.setName(name);
newUser.setUserName("test");
newUser.setDisplayName("Updated User");
newUser.setTitle("Mr");
newUser.setPassword("password");
newUser.setActive(true);

List<Role> roles = new ArrayList<Role>();
Role role = new Role();
role.setDisplay("ADMIN");
role.setOperation("Operation");
role.setValue("ADMIN");
roles.add(role);
newUser.setRoles(roles);
ScimResponse response1 = scimClient.updatePerson(newUser, "@!0035.934F.1A51.77B0!0001!402D.66D0!0000!B865.F744",, MediaType.APPLICATION_JSON);			// scimClient is of type Scim2Client
System.out.println("response status:" + response1.getStatus());
System.out.println(response1.getResponseBodyString());
```
The signatures of the methods we have used to update a person are as follows:

```
public ScimResponse updatePerson(User person, String uid, String mediaType) throws JsonGenerationException, JsonMappingException,
UnsupportedEncodingException, IOException, JAXBException
```

```
public ScimResponse updatePerson(ScimPerson person, String uid, String mediaType) throws JsonGenerationException, JsonMappingException,
UnsupportedEncodingException, IOException, JAXBException
```

Similarly, if you want to update a group, then you can use
**updateGroup** in two of the following manners: the first one is to
pass a ScimGroup object to this method:

``` 
Scim2Client client = Scim2Client.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
ScimGroup groupToUpdate = new ScimGroup();
groupToUpdate.setDisplayName("ScimObjecttesting");
ScimResponse response = client.updateGroup(groupToUpdate, "@!0035.934F.1A51.77B0!0001!402D.66D0!0003!4E80.079E", MediaType.APPLICATION_JSON);
String responseStr = response.getResponseBodyString();
```
The other option is to pass a *Group* object to this method:

```
Group newGroup = new Group();
newGroup.setDisplayName("UpdatedGroup");
ScimResponse response1 = scimClient.updateGroup(newGroup, "@!0035.934F.1A51.77B0!0001!412D.66D0!0003!4E80.079E",
MediaType.APPLICATION_JSON);
System.out.println("response status:" + response1.getStatus());
System.out.println(response1.getResponseBodyString());
```

- - - 

### Deleting an entity SCIM 2.0

To delete an entity, you simply pass its ID as a string parameter into
“deletePerson” or “deleteGroup” methods. For both cases, i. e. Person
and Group, the entity has to be registered in the system with an ID,
already.

``` 
Scim2Client client = Scim2Client.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
ScimPerson person = new ScimPerson();
ScimResponse response = client.deletePerson(person.getId()); // Here we have person object of type ScimPerson
response.getStatusCode() // this will give you the Status code
```

```
Scim2Client client = Scim2Client.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimGroup testGroup = new ScimGroup();
ScimResponse response = client.deleteGroup(testGroup.getId());
response.getStatusCode() // this will give you the Status code
```
- - -

### Retrieving an entity SCIM 2.0

To retrieve a person or a group you can use either “retrievePerson” or
“retrieveGroup” method by passing the entity’s ID as a parameter.
Furthermore, add the desired media type. In both cases, i. e. Person and
Group, the entity has to be registered in the system with an ID,
already.

```
Scim2Client client = Scim2Client.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimPerson person = new ScimPerson();
ScimResponse response = client.retrievePerson(person.getId(), MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

```
Scim2Client client = Scim2Client.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimGroup testGroup = new ScimGroup();
ScimResponse response = client.retrieveGroup(testGroup.getId(), MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```
- - -

### Bulk operations SCIM 2.0

To perform multiple operations (in a bulk), you pass the operation as a
*ScimBulkOperation* or *BulkRequest* object into “bulkOperation” method.

```
BulkRequest bulkRequest = new BulkRequest();

User user=new User();
user.setDisplayName("Test User");
Name name = new Name();
name.setGivenName("GivenName");
name.setFamilyName("FamilyName");
user.setName(name);
user.setUserName("Test");
user.setTitle("Mr.");
user.setPassword("pwd");
user.setActive(true);

List<Email> emails = new ArrayList<Email>();
email = new Email();
email.setDisplay("Usman");
email.setValue("osman.khalid333@gmail.com");
emails.add(email);
user.setEmails(emails);

List<Role> roles = new ArrayList<Role>();
Role role = new Role();
role.setDisplay("ADMIN");
role.setOperation("Operation");
role.setValue("ADMIN");
roles.add(role);
user.setRoles(roles);

BulkOperation createUser = new BulkOperation();
createUser.setBulkId("abcd");
createUser.setMethod("POST");
createUser.setPath("/Users");
createUser.setData(user);
bulkRequest.getOperations().add(createUser);

BulkOperation cerateGroup = new BulkOperation();
cerateGroup.setBulkId("abcdefg");
cerateGroup.setMethod("POST");
cerateGroup.setPath("/Groups");

Group group = new Group();
group.setDisplayName("Bulk Group");
group.setExternalId("externalid");
cerateGroup.setData(group);
bulkRequest.getOperations().add(cerateGroup);

ScimResponse response = scimClient.bulkOperation(bulkRequest, MediaType.APPLICATION_JSON);
System.out.println(response.getResponseBodyString());

```

