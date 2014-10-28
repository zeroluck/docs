#Simple Cloud Identity Management
What is SCIM?

The Simple Cloud Identity Management (SCIM) specification is a standard REST/JSON API to standardize user and group CRUD (create, read, update, delete). You can review the detailed specification at [http://www.simplecloud.info](http://www.simplecloud.info). The specification seeks to build upon experience with existing schemas and deployments, placing specific emphasis on simplicity of development and integration, while applying existing authentication, authorization, and privacy models. It's intent is to reduce the cost and complexity of user management operations by providing a common user schema and extension model, as well as binding documents to provide patterns for exchanging this schema using standard protocols. In essence, make it fast, cheap, and easy to move users in to, out of, and around the cloud.

### Specification 

SCIM is integrated as a service of oxTrust . To start operating with SCIM’s web service , you will need to send a request to one of SCIM’s endpoints , for example , if you want to add a user you need to send an HTTP request to this endpoint url:
[https://localhost:8080/oxTrust/seam/resource/restv1/Users/](https://localhost:8080/oxTrust/seam/resource/restv1/Users/)

For bulk operations (adding modifying and deleting multiple users ) you have to send a request to the bulk endpoint:
[https://localhost:8080/oxTrust/seam/resource/restv1/Bulk/](https://localhost:8080/oxTrust/seam/resource/restv1/Bulk/)

For group operations: 
[https://localhost:8080/oxTrust/seam/resource/restv1/Groups/](https://localhost:8080/oxTrust/seam/resource/restv1/Groups/)

You need to have a the right credentials and roles in order for you to access the endpoint example, which is for oxTrust means that you are a member of the Owner or Manager group specified in the organization entry. Gluu’s SCIM web service uses both Basic authentication and oAuth 2.0 authentication . For the basic type of authentication you need to specify the user and password (base64 encoded) in the HTTP request HTTP header in order to be authenticated Example:

    POST `https://localhost:8080/oxTrust/seam/resource/restv1/Users/`
    Accept: application/json 
    Authorization: Basic bWlrZTpzZWNyZXQ=

For oAuth 2.0 authentication you need to request an access token via the SCIM client API in order for you to be able to get authenticated , the example below shows how an access token is sent to SCIM webservice as a header:

    POST `https://localhost:8080/oxTrust/seam/resource/restv1/Users/`
    Accept: application/json
    Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
    
A user is represented in two formats, JSON and XML and you can specify what kind of format you want to use by indicating that in your HTTP request.

- For JSON: 
    Accept: application/json 

- For XML
    Accept: application/xml 

- Example of JSON representation: 
`{"schemas":["urn:scim:schemas:core:1.0"],"id":"@!1111!0000!D4E7","externalId":"john ","userName":"john ","name":{"givenName":"John","familyName":"Smith","middleName":"N/A","honorificPrefix":"N/A","honorificSuffix":"N/A"},"displayName":"John Smith","nickName":"Sensei","profileUrl":"http://www.gluu.org/","emails":[{"value":"john @gluu.org","type":"work","primary":"true"},{"value":"john 2@gluu.org","type":"home","primary":"false"}],"addresses":[{"type":"work","streetAddress":"621 East 6th Street Suite 200","locality":"Austin","region":"TX","postalCode":"78701","country":"US","formatted":"621 East 6th Street Suite 200  Austin , TX 78701 US","primary":"true"}],"phoneNumbers":[{"value":"646-234-5678","type":"work"}],"ims":[{"value":"nynyjohn ","type":"Skype"}],"photos":[{"value":"http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png","type":"gluu photo"}],"userType":"CEO","title":"CEO","preferredLanguage":"en-us","locale":"en_US","timezone":"America/Chicago","active":"true","password":"Hiden for Privacy Reasons","groups":[{"display":"Gluu Manager Group","value":"@!1111!0003!B2C6"},{"display":"Gluu Owner Group","value":"@!1111!0003!D9B4"}],"roles":[{"value":"Owner"}],"entitlements":[{"value":"full access"}],"x509Certificates":[{"value":"MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFa MH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo="}],"meta":{"created":"2010-01-23T04:56:22Z","lastModified":"2011-05-13T04:42:34Z","version":"W\\\"b431af54f0671a2\"","location":"http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7"}} `

- XML format example: 
`<?xml version="1.0" encoding="UTF-8" standalone="yes"?><User xmlns="urn:scim:schemas:core:1.0"><id>@!1111!0000!D4E7</id><externalId>john </externalId><userName>john </userName><name><givenName>John</givenName><familyName>Smith</familyName><middleName>N/A</middleName><honorificPrefix>N/A</honorificPrefix><honorificSuffix>N/A</honorificSuffix></name><displayName>John Smith</displayName><nickName>Sensei</nickName><profileUrl>http://www.gluu.org/</profileUrl><emails><email><value>john @gluu.org</value><type>work</type><primary>true</primary></email><email><value>john 2@gluu.org</value><type>home</type><primary>false</primary></email></emails><addresses><address><type>work</type><streetAddress>621 East 6th Street Suite 200</streetAddress><locality>Austin</locality><region>TX</region><postalCode>78701</postalCode><country>US</country><formatted>621 East 6th Street Suite 200  Austin , TX 78701 US</formatted><primary>true</primary></address></addresses><PhoneNumbers><PhoneNumber><value>646-234-5678</value><type>work</type></PhoneNumber></PhoneNumbers><ims><im><value>nynyjohn </value><type>Skype</type></im></ims><photos><photo><value>http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png</value><type>gluu photo</type></photo></photos><userType>CEO</userType><title>CEO</title><preferredLanguage>en-us</preferredLanguage><locale>en_US</locale><timezone>America/Chicago</timezone><active>true</active><password>Hiden for Privacy Reasons</password><groups><group><display>Gluu Manager Group</display><value>@!1111!0003!B2C6</value></group><group><display>Gluu Owner Group</display><value>@!1111!0003!D9B4</value></group></groups><roles><role><value>Owner</value></role></roles><entitlements><entitlement><value>full access</value></entitlement></entitlements><x509Certificates><x509Certificate><value>MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFa MH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo=</value></x509Certificate></x509Certificates><meta><created>2010-01-23T04:56:22Z</created><lastModified>2011-05-13T04:42:34Z</lastModified><version>W\&quot;b431af54f0671a2&quot;</version><location>http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7</location></meta></User>`

## Examples
In this section you will find some examples of the operations that you can accomplish using SCIM.

### Adding a user
