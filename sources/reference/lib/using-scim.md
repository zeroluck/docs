**Table Of Contents** 

- [Working with SCIM Client](#working-with-scim-client)
	- [SCIM 1.1](#scim-1.1)
	- [Creating SCIM client instance](#creating-scim-client-instance)
	- [Modifying an entity](#modifying-an-entity)
	- [Deleting an entity](#deleting-an-entity)
	- [Retrieving an entity](#retrieving-an-entity)
	- [Bulk operations](#bulk-operations)

# Working with SCIM Client
- - -

## SCIM 1.1

Following is the guide to work with SCIM client 1.1:

You can checkout SCIM-client from our GIT repository : https://github.com/GluuFederation/SCIM-Client 

### Creating SCIM client instance

Below is an example on how to create a ScimClient instance:

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
```

This will create an oAuth instance of ScimClient where: `userName` and `passWord` are the user credentials, `clientID` and `clientSecret` are oxAuth client credentials, `domainURL` is the domain where SCIM client resides, for example:
`http://localhost:8080/oxTrust/seam/resource/restv1`, and `oxAuthDomain` is the `tokenURL` example
`http://localhost:8080/oxauth/seam/resource/restv1/oxauth/token`.

```
ScimClient client = ScimClient.basicInstance(userName, passWord, domainURL);
```

For the basic authentication you only need the user’s credentials (userName, passWord) and domain URL.

### Adding an entity

SCIM-Client API comes with two methods to add an entity, i. e. “createPerson” and “createPersonString”, for both of the methods (createPerson, createPersonString), you pass the person you want to add as ScimPerson object and you specify the desired media type format “XML/JSON” and SCIM-client API will parse the ScimPerson object into XML or JSON and send your request.

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
ScimPerson person = new ScimPerson() ;
person.setUserName("TestUser");
person.setName.setGivenName("GName");
person.setName.setLastName("LName");
ScimResponse response = client.createPerson(person, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

Now, we'll use *createPersonString* to add the person:

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
// ScimResponse response = client.createPersonString(String person, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```


Similarly for groups, you can use createGroup with ScimGroup as a parameter or createGroupString.

- - -

### Modifying an entity

In this example we will show you how to modify a person or a group using SCIM-Client. SCIM-Client API comes with two methods to accomplish this, i. e. “updatePerson” and “updatePersonString”. For *updatePerson* method, you pass the person you want to update as ScimPerson object and its uid as a String and you specify the desired media type format “XML/JSON” and SCIM-client API will parse the ScimPerson object into XML or JSON and send your request.

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.updatePersonString(String person, person.uid, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

Also, here is an example of using updatePerson to modify the details:

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

Same applies for groups, you can use updateGroupString with ScimGroup as a parameter.

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.updateGroupString(String group, String id, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body
```
- - - 

### Deleting an entity

To delete an entity, you simply pass it’s ID as a String parameter into “deletePerson” or “deleteGroup” methods.

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.deletePerson(String uid);
response.getStatusCode() // this will give you the Status code
```

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.deleteGroup(String id);
response.getStatusCode() // this will give you the Status code
```
- - -

### Retrieving an entity

To retrieve a person or a group you can use “retrievePerson” or “retrieveGroup” method by passing the Entity’s id as a parameter and the
desired media type.

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.retrievePerson(String uid, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.retrieveGroup(String id, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```
- - -

### Bulk operations

To use Bulk operation you pass the operation as a ScimBulkOperation object into “bulkOperation” method or as a JSON/XML string into
“bulkOperationString” method and without forgetting to specify the desired media type.

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.bulkOperationString(String operation, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.bulkOperation(String operation, ScimBulkOperation operation, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

