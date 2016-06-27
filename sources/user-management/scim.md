[TOC]

# SCIM 2.0 User Add/Delete
This section outlines how to add/remove user from Gluu Server CE using SCIM Client.
## Add User
There are two methods to add users:

1. [JSON Sting](#json-string)
2. [User Object](#user-object)

### Required Parameters
|Parameter|Description|
|---------|-----------|
|userName | The intended username for the end-user|
|givenName| The first name of the end-user|
|familyName| The last name of the end-user|
|displayName| The formatted first name followed by last name|
|password| The intended password for the user that is added|
|_groups_| Optional parameter if the user is added to any specific group|

### JSON String
The user is added using a JSON object string using the required parameters. However it is possible to add more parameters 
while adding the user. The following is an example of a JSON string used to add user in Gluu Server.

```
Scim2Client client = Scim2Client.umaInstance(domain, umaMetaDataUrl, umaAatClientId, umaAatClientJwksPath, umaAatClientJwksPassword, umaAatClientKeyId);
ScimResponse response = client.createPersonString(createJson, MediaType.APPLICATION_JSON);
scim2.person.create_json = {"schemas":["urn:ietf:params:scim:schemas:core:2.0:User"],"externalId":"scimclient","userName":"${userjson.add.username}","name":{"givenName":"json","familyName":"json","middleName":"N/A","honorificPrefix":"N/A","honorificSuffix":"N/A"},"displayName":"json json","nickName":"json","profileUrl":"http://www.gluu.org/","emails":[{"value":"json@gluu.org","type":"work","primary":"true"},{"value":"json2@gluu.org","type":"home","primary":"false"}],"addresses":[{"type":"work","streetAddress":"621 East 6th Street Suite 200","locality":"Austin","region":"TX","postalCode":"78701","country":"US","formatted":"621 East 6th Street Suite 200  Austin , TX 78701 US","primary":"true"}],"phoneNumbers":[{"value":"646-345-2346","type":"work"}],"ims":[{"value":"nynytest_user","type":"Skype"}],"userType":"CEO","title":"CEO","preferredLanguage":"en-us","locale":"en_US","active":"true","password":"secret","groups":[{"display":"Gluu Test Group","value":"${group1Inum}"}],"roles":[{"value":"Owner"}],"entitlements":[{"value":"full access"}],"x509Certificates":[{"value":"MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFa MH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo="}],"meta":{"created":"2010-01-23T04:56:22Z","lastModified":"2011-05-13T04:42:34Z","version":"aversion","location":"http://localhost:8080/identity/seam/resource/restv1/Users/8c4b6c26-efaf-4840-bddf-c0146a8eb2a9"}}
```
### User Object
The user is added using a JSON user object using the same required parameters. However it is possible to add more parameters 
while preparing the JSON Object. The following snippet of code shows an example of user parameters added to SCIM Test Client.

```
	ScimResponse response = client.createPerson(personToAdd, MediaType.APPLICATION_JSON);
        personToAdd.setUserName(username);
        personToAdd.setPassword("test");
        personToAdd.setDisplayName("Scim2DisplayName2");

        Email email = new Email();
        email.setValue("scim@gluu.org");
        email.setType(org.gluu.oxtrust.model.scim2.Email.Type.WORK);
        email.setPrimary(true);
        personToAdd.getEmails().add(email);

        PhoneNumber phone = new PhoneNumber();
        phone.setType(org.gluu.oxtrust.model.scim2.PhoneNumber.Type.WORK);
        phone.setValue("654-6509-263");
        personToAdd.getPhoneNumbers().add(phone);

        org.gluu.oxtrust.model.scim2.Address address = new org.gluu.oxtrust.model.scim2.Address();
        address.setCountry("US");
        address.setStreetAddress("random street");
        address.setLocality("Austin");
        address.setPostalCode("65672");
        address.setRegion("TX");
        address.setPrimary(true);
        address.setType(org.gluu.oxtrust.model.scim2.Address.Type.WORK);
        address.setFormatted(address.getStreetAddress() + " " + address.getLocality() + " " + address.getPostalCode() + " " + address.getRegion() + " "
                + address.getCountry());
        personToAdd.getAddresses().add(address);

        personToAdd.setPreferredLanguage("US_en");

        org.gluu.oxtrust.model.scim2.Name name = new  org.gluu.oxtrust.model.scim2.Name();
        name.setFamilyName("SCIM");
        name.setGivenName("SCIM");
        personToAdd.setName(name);
```

## Delete User
The user is deleted using a JSON object string passing the required parameter.
The following snippet is from SCIM test client showing the code to delete the user with UID.

```
ScimResponse response = client.deletePerson(this.uid);
		System.out.println("deletePersonTest response json: " + response.getResponseBodyString());
```

### Required Parameter

|Parameter|Description|
|---------|-----------|
|uid	  |The `userName` attribute is passed as UID while deleting the user|
