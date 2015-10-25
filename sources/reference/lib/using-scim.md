**Table Of Contents** 

- [Working with SCIM Client](#working-with-scim-client)
	- [SCIM 1.1](#scim-1.1)
	- [Creating SCIM client instance](#creating-scim-client-instance)

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
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimPerson person = new ScimPerson() ;
person.setUserName(String username);
person.setName.setGivenName(String firstName);
person.setName.setLastName(String lastName);
ScimResponse response = client.createPerson(person, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

Similarly for groups, you can use createGroup with ScimGroup as a parameter or createGroupString.

