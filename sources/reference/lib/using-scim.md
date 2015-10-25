**Table Of Contents** 

- [Working with SCIM Client](#working-with-scim-client)
	- [SCIM 1.1](#scim-1.1)
		- [Creating SCIM client instance](#creating-scim-client-instance)
		- [Adding an entity](#adding-an-entity)
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

Similarly for groups, you can use createGroup with ScimGroup as a parameter, or using createGroupString.

``` 
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID, clientSecret, domainURL, oxAuthDomain);
ScimGroup groupToAdd = new ScimGroup();
groupToAdd.setDisplayName("ScimObjecttesting");
ScimResponse response = client.createGroup(groupToAdd, MediaType.APPLICATION_JSON);
String responseStr = response.getResponseBodyString();
```


- - -

### Modifying an entity

In this example we will show you how to modify a person or a group using SCIM-Client. SCIM-Client API comes with two methods to accomplish this, i. e. “updatePerson” and “updatePersonString”. For *updatePerson* method, you pass the person you want to update as ScimPerson object and its uid as a String and you specify the desired media type format “XML/JSON” and SCIM-client API will parse the ScimPerson object into XML or JSON and send your request.

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

Same applies for groups, you can use updateGroupString with ScimGroup as a parameter.


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

To delete an entity, you simply pass it’s ID as a String parameter into “deletePerson” or “deleteGroup” methods. For both cases, i. e. Person and Group, entity MUST be already registered in the system with an ID.

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

To retrieve a person or a group you can use “retrievePerson” or “retrieveGroup” method by passing the Entity’s id as a parameter and the
desired media type. For both cases, i. e. Person and Group, entity MUST be already registered in the system with an ID.

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

