# Simple Cloud Identity Management

What is SCIM?

The Simple Cloud Identity Management (SCIM) specification is a standard REST/JSON API to standardize user and group CRUD (create, read, update, delete). You can review the detailed specification at [http://www.simplecloud.info](http://www.simplecloud.info). 
The specification seeks to build upon experience with existing schemas and deployments, placing specific emphasis on simplicity of development and integration, while applying existing authentication, authorization, and privacy models. It's intent is to reduce the cost and complexity of user management operations by providing a common user schema and extension model, as well as binding documents to provide patterns for exchanging this schema using standard protocols. In essence, make it fast, cheap, and easy to move users in to, out of, and around the cloud.

You can download a PDF copy of this guide from [HERE](https///svn.gluu.info/repository/openxdi/SCIM-Client/doc/pdf/SCIM_Documenation.pdf).


## Specification

SCIM is integrated as a service of oxTrust . To start operating with SCIM’s web service , you will need to send a request to one of SCIM’s endpoints , for example , if you want to add a user you need to send an HTTP request to this endpoint url :

[https://localhost:8080/oxTrust/seam/resource/restv1/Users/](https///localhost/8080/oxTrust/seam/resource/restv1/Users/)

for bulk operations (adding modifying and deleting multiple users ) you have to send a request to the bulk endpoint:

[https://localhost:8080/oxTrust/seam/resource/restv1/Bulk/](https///localhost/8080/oxTrust/seam/resource/restv1/Bulk/)

for group operations:

[https://localhost:8080/oxTrust/seam/resource/restv1/Groups/](https///localhost/8080/oxTrust/seam/resource/restv1/Groups/)

You need to have a the right credentials and roles in order for you to access the endpoint example, which is for oxTrust means that you are a member of the Owner or Manager group specified in the organization entry. 
Gluu’s SCIM web service uses both Basic authentication and oAuth 2.0 authentication . For the basic type of authentication you need to specify the user and password (base64 encoded) in the HTTP request HTTP header in order to be authenticated 
Example :

```
POST https://localhost:8080/oxTrust/seam/resource/restv1/Users/ 
Accept: application/json 
Authorization: Basic bWlrZTpzZWNyZXQ=
```
For oAuth 2.0 authentication you need to request an access token via the SCIM client API in order for you to be able to get authenticated , the example below shows how an access token is sent to SCIM webservice as a header:

```
POST https://localhost:8080/oxTrust/seam/resource/restv1/Users/ 
Accept: application/json 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

A user is represented in two formats, JSON and XML and you can specify what kind of format you want to use by indicating that in your HTTP request .


* For JSON:

```
Accept: application/json 
```

* For XML

```
Accept: application/xml 
```

* Example of JSON representation

```
{"schemas":["urn:scim:schemas:core:1.0"],"id":"@!1111!0000!D4E7","externalId":"john ","userName":"john ","name":{"givenName":"John","familyName":"Smith","middleName":"N/A","honorificPrefix":"N/A","honorificSuffix":"N/A"},"displayName":"John Smith","nickName":"Sensei","profileUrl":"http://www.gluu.org/","emails":[{"value":"john @gluu.org","type":"work","primary":"true"},{"value":"john 2@gluu.org","type":"home","primary":"false"}],"addresses":[{"type":"work","streetAddress":"621 East 6th Street Suite 200","locality":"Austin","region":"TX","postalCode":"78701","country":"US","formatted":"621 East 6th Street Suite 200 Austin , TX 78701 US","primary":"true"}],"phoneNumbers":[{"value":"646-234-5678","type":"work"}],"ims":[{"value":"nynyjohn ","type":"Skype"}],"photos":[{"value":"http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png","type":"gluu photo"}],"userType":"CEO","title":"CEO","preferredLanguage":"en-us","locale":"en_US","timezone":"America/Chicago","active":"true","password":"Hiden for Privacy Reasons","groups":[{"display":"Gluu Manager Group","value":"@!1111!0003!B2C6"},{"display":"Gluu Owner Group","value":"@!1111!0003!D9B4"}],"roles":[{"value":"Owner"}],"entitlements":[{"value":"full access"}],"x509Certificates":[{"value":"MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFaMH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo="}],"meta":{"created":"2010-01-23T04:56:22Z","lastModified":"2011-05-13T04:42:34Z","version":"W\\\"b431af54f0671a2\"","location":"http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7"}} 
```

* XML format Example

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><User xmlns="urn:scim:schemas:core:1.0"><id>@!1111!0000!D4E7</id><externalId>john </externalId><userName>john </userName><name><givenName>John</givenName><familyName>Smith</familyName><middleName>N/A</middleName><honorificPrefix>N/A</honorificPrefix><honorificSuffix>N/A</honorificSuffix></name><displayName>John Smith</displayName><nickName>Sensei</nickName><profileUrl>http://www.gluu.org/</profileUrl><emails><email><value>john @gluu.org</value><type>work</type><primary>true</primary></email><email><value>john 2@gluu.org</value><type>home</type><primary>false</primary></email></emails><addresses><address><type>work</type><streetAddress>621 East 6th Street Suite 200</streetAddress><locality>Austin</locality><region>TX</region><postalCode>78701</postalCode><country>US</country><formatted>621 East 6th Street Suite 200 Austin , TX 78701 US</formatted><primary>true</primary></address></addresses><PhoneNumbers><PhoneNumber><value>646-234-5678</value><type>work</type></PhoneNumber></PhoneNumbers><ims><im><value>nynyjohn </value><type>Skype</type></im></ims><photos><photo><value>http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png</value><type>gluu photo</type></photo></photos><userType>CEO</userType><title>CEO</title><preferredLanguage>en-us</preferredLanguage><locale>en_US</locale><timezone>America/Chicago</timezone><active>true</active><password>Hiden for Privacy Reasons</password><groups><group><display>Gluu Manager Group</display><value>@!1111!0003!B2C6</value></group><group><display>Gluu Owner Group</display><value>@!1111!0003!D9B4</value></group></groups><roles><role><value>Owner</value></role></roles><entitlements><entitlement><value>full access</value></entitlement></entitlements><x509Certificates><x509Certificate><value>MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFaMH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo=</value></x509Certificate></x509Certificates><meta><created>2010-01-23T04:56:22Z</created><lastModified>2011-05-13T04:42:34Z</lastModified><version>W\&quot;b431af54f0671a2&quot;</version><location>http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7</location></meta></User>
```

## Examples

In this section you will find some examples of the operations that you can accomplish using SCIM.

## Adding a user

In this example we will try to add a user in JSON and XML format: 


* JSON request
* Header

```
POST https://localhost:8080/oxTrust/seam/resource/restv1/Users/ 
Accept: application/json 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

* Request content

```
{"schemas":["urn:scim:schemas:core:1.0"],"externalId":"john ","userName":"john ","name":{"givenName":"John","familyName":"Smith","middleName":"N/A","honorificPrefix":"N/A","honorificSuffix":"N/A"},"displayName":"John Smith","nickName":"Sensei","profileUrl":"http://www.gluu.org/","emails":[{"value":"john @gluu.org","type":"work","primary":"true"},{"value":"john 2@gluu.org","type":"home","primary":"false"}],"addresses":[{"type":"work","streetAddress":"621 East 6th Street Suite 200","locality":"Austin","region":"TX","postalCode":"78701","country":"US","formatted":"621 East 6th Street Suite 200 Austin , TX 78701 US","primary":"true"}],"phoneNumbers":[{"value":"646-234-5678","type":"work"}],"ims":[{"value":"nynyjohn ","type":"Skype"}],"photos":[{"value":"http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png","type":"gluu photo"}],"userType":"CEO","title":"CEO","preferredLanguage":"en-us","locale":"en_US","timezone":"America/Chicago","active":"true","password":"secret","groups":[{"display":"Gluu Manager Group","value":"@!1111!0003!B2C6"},{"display":"Gluu Owner Group","value":"@!1111!0003!D9B4"}],"roles":[{"value":"Owner"}],"entitlements":[{"value":"full access"}],"x509Certificates":[{"value":"MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFaMH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo="}],"meta":{"created":"2010-01-23T04:56:22Z","lastModified":"2011-05-13T04:42:34Z","version":"W\\\"b431af54f0671a2\"","location":"http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7"}}
```

* JSON response
* Header

```
201 CREATED
Server: Apache-Coyote/1.1
Location: https://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7
Content-Type: application/json
```

* response Content

```
{"schemas":["urn:scim:schemas:core:1.0"],"id":"@!1111!0000!D4E7","externalId":"john ","userName":"john ","name":{"givenName":"John","familyName":"Smith","middleName":"N/A","honorificPrefix":"N/A","honorificSuffix":"N/A"},"displayName":"John Smith","nickName":"Sensei","profileUrl":"http://www.gluu.org/","emails":[{"value":"john@gluu.org","type":"work","primary":"true"},{"value":"john 2@gluu.org","type":"home","primary":"false"}],"addresses":[{"type":"work","streetAddress":"621 East 6th Street Suite 200","locality":"Austin","region":"TX","postalCode":"78701","country":"US","formatted":"621 East 6th Street Suite 200 Austin , TX 78701 US","primary":"true"}],"phoneNumbers":[{"value":"646-234-5678","type":"work"}],"ims":[{"value":"nynyjohn ","type":"Skype"}],"photos":[{"value":"http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png","type":"gluu photo"}],"userType":"CEO","title":"CEO","preferredLanguage":"en-us","locale":"en_US","timezone":"America/Chicago","active":"true","password":"Hiden for Privacy Reasons","groups":[{"display":"Gluu Manager Group","value":"@!1111!0003!B2C6"},{"display":"Gluu Owner Group","value":"@!1111!0003!D9B4"}],"roles":[{"value":"Owner"}],"entitlements":[{"value":"full access"}],"x509Certificates":[{"value":"MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFaMH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo="}],"meta":{"created":"2010-01-23T04:56:22Z","lastModified":"2011-05-13T04:42:34Z","version":"W\\\"b431af54f0671a2\"","location":"http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7"}}
```

* XML request
* Header

```
POST https://localhost:8080/oxTrust/seam/resource/restv1/Users/ 
Accept: application/xml 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

* Request Content

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><User xmlns="urn:scim:schemas:core:1.0"><externalId>mike</externalId><userName>mike</userName><name><givenName>John</givenName><familyName>Smith</familyName><middleName>N/A</middleName><honorificPrefix>N/A</honorificPrefix><honorificSuffix>N/A</honorificSuffix></name><displayName>John Smith</displayName><nickName>Sensei</nickName><profileUrl>http://www.gluu.org/</profileUrl><emails><email><value>mike@gluu.org</value><type>work</type><primary>true</primary></email><email><value>mike2@gluu.org</value><type>home</type><primary>false</primary></email></emails><addresses><address><type>work</type><streetAddress>621 East 6th Street Suite 200</streetAddress><locality>Austin</locality><region>TX</region><postalCode>78701</postalCode><country>US</country><formatted>621 East 6th Street Suite 200  Austin , TX 78701 US</formatted><primary>true</primary></address></addresses><PhoneNumbers><PhoneNumber><value>646-234-5678</value><type>work</type></PhoneNumber></PhoneNumbers><ims><im><value>nynymike</value><type>Skype</type></im></ims><photos><photo><value>http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png</value><type>gluu photo</type></photo></photos><userType>CEO</userType><title>CEO</title><preferredLanguage>en-us</preferredLanguage><locale>en_US</locale><timezone>America/Chicago</timezone><active>true</active><password>secret</password><groups><group><display>Gluu Manager Group</display><value>@!1111!0003!B2C6</value></group><group><display>Gluu Owner Group</display><value>@!1111!0003!D9B4</value></group></groups><roles><role><value>Owner</value></role></roles><entitlements><entitlement><value>full access</value></entitlement></entitlements><x509Certificates><x509Certificate><value>MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFaMH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo=</value></x509Certificate></x509Certificates><meta><created>2010-01-23T04:56:22Z</created><lastModified>2011-05-13T04:42:34Z</lastModified><version>W\&quot;b431af54f0671a2&quot;</version><location>http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7</location></meta></User>
```

* XML response
* header

```
201 CREATED
Server: Apache-Coyote/1.1
Location: https://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7
Content-Type: application/xml
```

* Response Content

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><User xmlns="urn:scim:schemas:core:1.0"><id>@!1111!0000!D4E7</id><externalId>mike</externalId><userName>mike</userName><name><givenName>John</givenName><familyName>Smith</familyName><middleName>N/A</middleName><honorificPrefix>N/A</honorificPrefix><honorificSuffix>N/A</honorificSuffix></name><displayName>John Smith</displayName><nickName>Sensei</nickName><profileUrl>http://www.gluu.org/</profileUrl><emails><email><value>mike@gluu.org</value><type>work</type><primary>true</primary></email><email><value>mike2@gluu.org</value><type>home</type><primary>false</primary></email></emails><addresses><address><type>work</type><streetAddress>621 East 6th Street Suite 200</streetAddress><locality>Austin</locality><region>TX</region><postalCode>78701</postalCode><country>US</country><formatted>621 East 6th Street Suite 200  Austin , TX 78701 US</formatted><primary>true</primary></address></addresses><PhoneNumbers><PhoneNumber><value>646-234-5678</value><type>work</type></PhoneNumber></PhoneNumbers><ims><im><value>nynymike</value><type>Skype</type></im></ims><photos><photo><value>http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png</value><type>gluu photo</type></photo></photos><userType>CEO</userType><title>CEO</title><preferredLanguage>en-us</preferredLanguage><locale>en_US</locale><timezone>America/Chicago</timezone><active>true</active><password>Hiden for Privacy Reasons</password><groups><group><display>Gluu Manager Group</display><value>@!1111!0003!B2C6</value></group><group><display>Gluu Owner Group</display><value>@!1111!0003!D9B4</value></group></groups><roles><role><value>Owner</value></role></roles><entitlements><entitlement><value>full access</value></entitlement></entitlements><x509Certificates><x509Certificate><value>MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFaMH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo=</value></x509Certificate></x509Certificates><meta><created>2010-01-23T04:56:22Z</created><lastModified>2011-05-13T04:42:34Z</lastModified><version>W\&quot;b431af54f0671a2&quot;</version><location>http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7</location></meta></User>
```

## Getting a user

* JSON request
* Header

```
GET https://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7
Accept: application/json 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

* JSON response
* Header

```
200 OK
Server: Apache-Coyote/1.1
Location: https://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7
Content-Type: application/json
```

* Response Content

```
{"schemas":["urn:scim:schemas:core:1.0"],"id":"@!1111!0000!D4E7","externalId":"mike","userName":"mike","name":{"givenName":"John","familyName":"Smith","middleName":"N/A","honorificPrefix":"N/A","honorificSuffix":"N/A"},"displayName":"John Smith","nickName":"Sensei","profileUrl":"http://www.gluu.org/","emails":[{"value":"mike@gluu.org","type":"work","primary":"true"},{"value":"mike2@gluu.org","type":"home","primary":"false"}],"addresses":[{"type":"work","streetAddress":"621 East 6th Street Suite 200","locality":"Austin","region":"TX","postalCode":"78701","country":"US","formatted":"621 East 6th Street Suite 200 Austin , TX 78701 US","primary":"true"}],"phoneNumbers":[{"value":"646-234-5678","type":"work"}],"ims":[{"value":"nynymike","type":"Skype"}],"photos":[{"value":"http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png","type":"gluu photo"}],"userType":"CEO","title":"CEO","preferredLanguage":"en-us","locale":"en_US","timezone":"America/Chicago","active":"true","password":"Hiden for Privacy Reasons","groups":[{"display":"Gluu Manager Group","value":"@!1111!0003!B2C6"},{"display":"Gluu Owner Group","value":"@!1111!0003!D9B4"}],"roles":[{"value":"Owner"}],"entitlements":[{"value":"full access"}],"x509Certificates":[{"value":"MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFaMH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo="}],"meta":{"created":"2010-01-23T04:56:22Z","lastModified":"2011-05-13T04:42:34Z","version":"W\\\"b431af54f0671a2\"","location":"http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7"}}
```

* XML request
* Header

```
GET https://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7
Accept: application/json 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

* XML response
* Header

```
200 OK
Server: Apache-Coyote/1.1
Location: https://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7
Content-Type: application/xml
```

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><User xmlns="urn:scim:schemas:core:1.0"><id>@!1111!0000!D4E7</id><externalId>mike</externalId><userName>mike</userName><name><givenName>John</givenName><familyName>Smith</familyName><middleName>N/A</middleName><honorificPrefix>N/A</honorificPrefix><honorificSuffix>N/A</honorificSuffix></name><displayName>John Smith</displayName><nickName>Sensei</nickName><profileUrl>http://www.gluu.org/</profileUrl><emails><email><value>mike@gluu.org</value><type>work</type><primary>true</primary></email><email><value>mike2@gluu.org</value><type>home</type><primary>false</primary></email></emails><addresses><address><type>work</type><streetAddress>621 East 6th Street Suite 200</streetAddress><locality>Austin</locality><region>TX</region><postalCode>78701</postalCode><country>US</country><formatted>621 East 6th Street Suite 200  Austin , TX 78701 US</formatted><primary>true</primary></address></addresses><PhoneNumbers><PhoneNumber><value>646-234-5678</value><type>work</type></PhoneNumber></PhoneNumbers><ims><im><value>nynymike</value><type>Skype</type></im></ims><photos><photo><value>http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png</value><type>gluu photo</type></photo></photos><userType>CEO</userType><title>CEO</title><preferredLanguage>en-us</preferredLanguage><locale>en_US</locale><timezone>America/Chicago</timezone><active>true</active><password>Hiden for Privacy Reasons</password><groups><group><display>Gluu Manager Group</display><value>@!1111!0003!B2C6</value></group><group><display>Gluu Owner Group</display><value>@!1111!0003!D9B4</value></group></groups><roles><role><value>Owner</value></role></roles><entitlements><entitlement><value>full access</value></entitlement></entitlements><x509Certificates><x509Certificate><value>MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFaMH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo=</value></x509Certificate></x509Certificates><meta><created>2010-01-23T04:56:22Z</created><lastModified>2011-05-13T04:42:34Z</lastModified><version>W\&quot;b431af54f0671a2&quot;</version><location>http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7</location></meta></User>
```

## Modifying a user


* JSON request
* Header

```
PUT https://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7
Accept: application/json 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

* Request content

```
{"schemas":["urn:scim:schemas:core:1.0"],"externalId":"mike24","password":"Qb587QBJ"}
```

* JSON response
* Header

```
200 OK
Server: Apache-Coyote/1.1
Location: https://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7
Content-Type: application/json
```

* Response Content

```
{"schemas":["urn:scim:schemas:core:1.0"],"id":"@!1111!0000!D4E7","externalId":"mike24","userName":"mike","name":{"givenName":"John","familyName":"Smith","middleName":"N/A","honorificPrefix":"N/A","honorificSuffix":"N/A"},"displayName":"John Smith","nickName":"Sensei","profileUrl":"http://www.gluu.org/","emails":[{"value":"mike@gluu.org","type":"work","primary":"true"},{"value":"mike2@gluu.org","type":"home","primary":"false"}],"addresses":[{"type":"work","streetAddress":"621 East 6th Street Suite 200","locality":"Austin","region":"TX","postalCode":"78701","country":"US","formatted":"621 East 6th Street Suite 200 Austin , TX 78701 US","primary":"true"}],"phoneNumbers":[{"value":"646-234-5678","type":"work"}],"ims":[{"value":"nynymike","type":"Skype"}],"photos":[{"value":"http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png","type":"gluu photo"}],"userType":"CEO","title":"CEO","preferredLanguage":"en-us","locale":"en_US","timezone":"America/Chicago","active":"true","password":"Hiden for Privacy Reasons","groups":[{"display":"Gluu Manager Group","value":"@!1111!0003!B2C6"},{"display":"Gluu Owner Group","value":"@!1111!0003!D9B4"}],"roles":[{"value":"Owner"}],"entitlements":[{"value":"full access"}],"x509Certificates":[{"value":"MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFaMH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo="}],"meta":{"created":"2010-01-23T04:56:22Z","lastModified":"2011-05-13T04:42:34Z","version":"W\\\"b431af54f0671a2\"","location":"http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7"}}
```

* XML request
* header

```
PUT https://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7
Accept: application/xml 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

* Request Content

```
`<?xml version="1.0" encoding="UTF-8" standalone="yes"?>``<User xmlns="urn:scim:schemas:core:1.0">``<externalId>`mike26`</externalId>``<password>`Qb587QBJ`</password>``</user>`
```

* XML response
* Header

```
200 OK
Server: Apache-Coyote/1.1
Location: https://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7
Content-Type: application/xml
```

* Response Content

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><User xmlns="urn:scim:schemas:core:1.0"><id>@!1111!0000!D4E7</id><externalId>mike26</externalId><userName>mike</userName><name><givenName>John</givenName><familyName>Smith</familyName><middleName>N/A</middleName><honorificPrefix>N/A</honorificPrefix><honorificSuffix>N/A</honorificSuffix></name><displayName>John Smith</displayName><nickName>Sensei</nickName><profileUrl>http://www.gluu.org/</profileUrl><emails><email><value>mike@gluu.org</value><type>work</type><primary>true</primary></email><email><value>mike2@gluu.org</value><type>home</type><primary>false</primary></email></emails><addresses><address><type>work</type><streetAddress>621 East 6th Street Suite 200</streetAddress><locality>Austin</locality><region>TX</region><postalCode>78701</postalCode><country>US</country><formatted>621 East 6th Street Suite 200  Austin , TX 78701 US</formatted><primary>true</primary></address></addresses><PhoneNumbers><PhoneNumber><value>646-234-5678</value><type>work</type></PhoneNumber></PhoneNumbers><ims><im><value>nynymike</value><type>Skype</type></im></ims><photos><photo><value>http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png</value><type>gluu photo</type></photo></photos><userType>CEO</userType><title>CEO</title><preferredLanguage>en-us</preferredLanguage><locale>en_US</locale><timezone>America/Chicago</timezone><active>true</active><password>Hiden for Privacy Reasons</password><groups><group><display>Gluu Manager Group</display><value>@!1111!0003!B2C6</value></group><group><display>Gluu Owner Group</display><value>@!1111!0003!D9B4</value></group></groups><roles><role><value>Owner</value></role></roles><entitlements><entitlement><value>full access</value></entitlement></entitlements><x509Certificates><x509Certificate><value>MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFaMH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo=</value></x509Certificate></x509Certificates><meta><created>2010-01-23T04:56:22Z</created><lastModified>2011-05-13T04:42:34Z</lastModified><version>W\&quot;b431af54f0671a2&quot;</version><location>http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7</location></meta></User>
```

## Delete a user

* JSON header request

```
DELETE https://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7
Accept: application/json 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

* JSON header response

```
HTTP/1.1 200 OK
```

* XML header request

```
DELETE https://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7
Accept: application/xml 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

* XML header response

```
HTTP/1.1 200 OK
```

## Bulk request


* JSON Request
* Header

```
POST https://localhost:8080/oxTrust/seam/resource/restv1/Bulk/ 
Accept: application/json 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

* Request Content

```
{"schemas":["urn:scim:schemas:core:1.0"],"Operations":[{"method":"POST","path":"/Users","data":{"schemas":["urn:scim:schemas:core:1.0"],"externalId":"bulk","userName":"bulk","name":{"givenName":"bulk","familyName":"bulk","middleName":"N/A","honorificPrefix":"N/A","honorificSuffix":"N/A"},"displayName":"bulk bulk","nickName":"bulk","profileUrl":"http://www.gluu.org/","emails":[{"value":"bulk@gluu.org","type":"work","primary":"true"},{"value":"bulk2@gluu.org","type":"home","primary":"false"}],"addresses":[{"type":"work","streetAddress":"621 East 6th Street Suite 200","locality":"Austin","region":"TX","postalCode":"78701","country":"US","formatted":"621 East 6th Street Suite 200 Austin , TX 78701 US","primary":"true"}],"phoneNumbers":[{"value":"646-234-5678","type":"work"}],"ims":[{"value":"nynymike","type":"Skype"}],"photos":[{"value":"http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png","type":"gluu photo"}],"userType":"CEO","title":"CEO","preferredLanguage":"en-us","locale":"en_US","timezone":"America/Chicago","active":"true","password":"secret","groups":[{"display":"Gluu Manager Group","value":"@!1111!0003!B2C6"},{"display":"Gluu Owner Group","value":"@!1111!0003!D9B4"}],"roles":[{"value":"Owner"}],"entitlements":[{"value":"full access"}],"x509Certificates":[{"value":"MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFaMH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo="}],"meta":{"created":"2010-01-23T04:56:22Z","lastModified":"2011-05-13T04:42:34Z","version":"W\\\"b431af54f0671a2\"","location":"http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7"}},"bulkId":"onebunk"},{"method":"PUT","path":"/Users/@!1111!0000!C4C4", "version":"oneversion","data":{"schemas":["urn:scim:schemas:core:1.0"],"displayName":"bulk person","externalId":"bulk"}},{"method":"DELETE","path":"/Users/@!1111!0000!C3C3","version":"oneversion"}]}
```

* JSON response
* Header

```
200 OK
Server: Apache-Coyote/1.1
Location: https://localhost:8080/oxTrust/seam/resource/restv1/Bulk/
Content-Type: application/json
```

* Response Content

```
{"schemas":["urn:scim:schemas:core:1.0"],"Operations":[{"method":"POST","location":"http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!F8A1","version":"","status":{"description":"","code":"201"},"bulkId":"onebunk"},{"method":"PUT","location":"http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!C4C4","version":"oneversion","status":{"description":"","code":"200"},"bulkId":""},{"method":"DELETE","location":"http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!C3C3","version":"","status":{"description":"","code":"200"},"bulkId":""}]}
```

* XML request
* Header

```
POST https://localhost:8080/oxTrust/seam/resource/restv1/Bulk/ 
Accept: application/xml 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

* Request Content

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Bulk xmlns="urn:scim:schemas:core:1.0"><Operations><operation><bulkId>onebunk</bulkId><data><externalId>bulk</externalId><userName>bulk</userName><name><givenName>bulk</givenName><familyName>bulk</familyName><middleName>N/A</middleName><honorificPrefix>N/A</honorificPrefix><honorificSuffix>N/A</honorificSuffix></name><displayName>bulk bulk</displayName><nickName>bulk</nickName><profileUrl>http://www.gluu.org/</profileUrl><emails><email><value>bulk@gluu.org</value><type>work</type><primary>true</primary></email><email><value>bulk2@gluu.org</value><type>home</type><primary>false</primary></email></emails><addresses><address><type>work</type><streetAddress>621 East 6th Street Suite 200</streetAddress><locality>Austin</locality><region>TX</region><postalCode>78701</postalCode><country>US</country><formatted>621 East 6th Street Suite 200  Austin , TX 78701 US</formatted><primary>true</primary></address></addresses><PhoneNumbers><PhoneNumber><value>646-234-5678</value><type>work</type></PhoneNumber></PhoneNumbers><ims><im><value>nynymike</value><type>Skype</type></im></ims><photos><photo><value>http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png</value><type>gluu photo</type></photo></photos><userType>CEO</userType><title>CEO</title><preferredLanguage>en-us</preferredLanguage><locale>en_US</locale><timezone>America/Chicago</timezone><active>true</active><password>secret</password><groups><group><display>Gluu Manager Group</display><value>@!1111!0003!B2C6</value></group><group><display>Gluu Owner Group</display><value>@!1111!0003!D9B4</value></group></groups><roles><role><value>Owner</value></role></roles><entitlements><entitlement><value>full access</value></entitlement></entitlements><x509Certificates><x509Certificate><value>MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFaMH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo=</value></x509Certificate></x509Certificates><meta><created>2010-01-23T04:56:22Z</created><lastModified>2011-05-13T04:42:34Z</lastModified><version>aversion</version><location>http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7</location></meta></data><location></location><method>POST</method><path>/Users</path><version></version></operation><operation><bulkId></bulkId><data><externalId>bulk</externalId><userName></userName><name><givenName></givenName><familyName></familyName><middleName></middleName><honorificPrefix></honorificPrefix><honorificSuffix></honorificSuffix></name><displayName>bulk person</displayName><nickName></nickName><profileUrl></profileUrl><emails/><addresses/><PhoneNumbers/><ims/><photos/><userType></userType><title></title><locale></locale><password></password><groups/><roles/><entitlements/><x509Certificates/><meta><created></created><lastModified></lastModified><version></version><location></location></meta></data><location></location><method>PUT</method><path>/Users/@!1111!0000!C4C4</path><version>oneversion</version></operation><operation><bulkId></bulkId><data><externalId></externalId><userName></userName><name><givenName></givenName><familyName></familyName><middleName></middleName><honorificPrefix></honorificPrefix><honorificSuffix></honorificSuffix></name><nickName></nickName><profileUrl></profileUrl><emails/><addresses/><PhoneNumbers/><ims/><photos/><userType></userType><title></title><locale></locale><password></password><groups/><roles/><entitlements/><x509Certificates/><meta><created></created><lastModified></lastModified><version></version><location></location></meta></data><location></location><method>DELETE</method><path>/Users/@!1111!0000!C3C3</path><version>oneversion</version></operation></Operations></Bulk>
```

* XML Response
* Header

```
200 OK
Server: Apache-Coyote/1.1
Location: https://localhost:8080/oxTrust/seam/resource/restv1/Bulk/
Content-Type: application/xml
```

* Response Content

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Bulk xmlns="urn:scim:schemas:core:1.0"><Operations><operation><bulkId>onebunk</bulkId><location>http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E0</location><method>POST</method><status><Code>201</Code><description></description></status><version></version></operation><operation><bulkId></bulkId><location>http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!C4C4</location><method>PUT</method><status><Code>200</Code><description></description></status><version>oneversion</version></operation><operation><bulkId></bulkId><location>http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!C3C3</location><method>DELETE</method><status><Code>200</Code><description></description></status><version></version></operation></Operations></Bulk>
```

## Getting a list of users

* JSON Request
* Header

```
GET https://localhost:8080/oxTrust/seam/resource/restv1/Users/
Accept: application/json 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

* JSON response
* Header

```
200 OK
Server: Apache-Coyote/1.1
Location: https://localhost:8080/oxTrust/seam/resource/restv1/Users/
Content-Type: application/json
```

* Response Content

```
{"totalResults":4,"schemas":["urn:scim:schemas:core:1.0"],"resources":[{"schemas":["urn:scim:schemas:core:1.0"],"id":"@!1111!0000!9711","externalId":"random","userName":"erik","name":{"givenName":"Erik","familyName":"Hartog","middleName":"N/A","honorificPrefix":"N/A","honorificSuffix":"N/A"},"displayName":"Erik Hartog","nickName":"Erik","profileUrl":"http://www.gluu.org/","emails":[{"value":"random@gluu.org","type":"work","primary":"true"},{"value":"random2@gluu.org","type":"home","primary":"false"}],"addresses":[{"type":"work","streetAddress":"621 East 6th Street Suite 200","locality":"Austin","region":"TX","postalCode":"78701","country":"US","formatted":"621 East 6th Street Suite 200  Austin , TX 78701 US","primary":"true"}],"phoneNumbers":[{"value":"646-234-5678","type":"work"}],"ims":[{"value":"erikk","type":"Skype"}],"photos":[{"value":"http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png","type":"gluu photo"}],"userType":"user","title":"user","preferredLanguage":"en-us","locale":"en_US","timezone":"America/Chicago","active":"true","password":"Hidden for Privacy Reasons","groups":[{"display":"Gluu Manager Group","value":"@!1111!0003!B2C6"},{"display":"Gluu Owner Group","value":"@!1111!0003!D9B4"}],"roles":[{"value":"user"}],"entitlements":[{"value":"limited access"}],"x509Certificates":[{"value":"MIIDQzCCAqygAwIBAgICEAAwDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFDASBgNVBAoMC2V4YW1wbGUuY29tMRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0xMTEwMjIwNjI0MzFaFw0xMjEwMDQwNjI0MzFaMH8xCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApDYWxpZm9ybmlhMRQwEgYDVQQKDAtleGFtcGxlLmNvbTEhMB8GA1UEAwwYTXMuIEJhcmJhcmEgSiBKZW5zZW4gSUlJMSIwIAYJKoZIhvcNAQkBFhNiamVuc2VuQGV4YW1wbGUuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7Kr+Dcds/JQ5GwejJFcBIP682X3xpjis56AK02bc1FLgzdLI8auoR+cC9/Vrh5t66HkQIOdA4unHh0AaZ4xL5PhVbXIPMB5vAPKpzz5iPSi8xO8SL7I7SDhcBVJhqVqr3HgllEG6UClDdHO7nkLuwXq8HcISKkbT5WFTVfFZzidPl8HZ7DhXkZIRtJwBweq4bvm3hM1Os7UQH05ZS6cVDgweKNwdLLrT51ikSQG3DYrl+ft781UQRIqxgwqCfXEuDiinPh0kkvIi5jivVu1Z9QiwlYEdRbLJ4zJQBmDrSGTMYn4lRc2HgHO4DqB/bnMVorHB0CC6AV1QoFK4GPe1LwIDAQABo3sweTAJBgNVHRMEAjAAMCwGCWCGSAGG+EIBDQQfFh1PcGVuU1NMIEdlbmVyYXRlZCBDZXJ0aWZpY2F0ZTAdBgNVHQ4EFgQU8pD0U0vsZIsaA16lL8En8bx0F/gwHwYDVR0jBBgwFoAUdGeKitcaF7gnzsNwDx708kqaVt0wDQYJKoZIhvcNAQEFBQADgYEAA81SsFnOdYJtNg5Tcq+/ByEDrBgnusx0jloUhByPMEVkoMZ3J7j1ZgI8rAbOkNngX8+pKfTiDz1RC4+dx8oU6Za+4NJXUjlL5CvV6BEYb1+QAEJwitTVvxB/A67g42/vzgAtoRUeDov1+GFiBZ+GNF/cAYKcMtGcrs2i97ZkJMo="}],"meta":{"created":"2010-01-23T04:56:22Z","lastModified":"2011-05-13T04:42:34Z","version":"W\\\"b431af54f0671a2\"","location":"http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7"}},{"schemas":["urn:scim:schemas:core:1.0"],"id":"@!1111!0000!D4E7","externalId":"mike","userName":"mike","name":{"givenName":"John","familyName":"Smith","middleName":"N/A","honorificPrefix":"N/A","honorificSuffix":"N/A"},"displayName":"John Smith","nickName":"Sensei","profileUrl":"http://www.gluu.org/","emails":[{"value":"mike@gluu.org","type":"work","primary":"true"},{"value":"mike2@gluu.org","type":"home","primary":"false"}],"addresses":[{"type":"work","streetAddress":"621 East 6th Street Suite 200","locality":"Austin","region":"TX","postalCode":"78701","country":"US","formatted":"621 East 6th Street Suite 200  Austin , TX 78701 US","primary":"true"}],"phoneNumbers":[{"value":"646-234-5678","type":"work"}],"ims":[{"value":"nynymike","type":"Skype"}],"photos":[{"value":"http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png","type":"gluu photo"}],"userType":"CEO","title":"CEO","preferredLanguage":"en-us","locale":"en_US","timezone":"America/Chicago","active":"true","password":"Hidden for Privacy Reasons","groups":[{"display":"Gluu Manager Group","value":"@!1111!0003!B2C6"},{"display":"Gluu Owner Group","value":"@!1111!0003!D9B4"}],"roles":[{"value":"Owner"}],................................................the response is too long intentionally skipped some content for demo sake................................................,"version":"W\\\"b431af54f0671a2\"","location":"http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7"}}]}
```

* XML request
* Header

```
GET https://localhost:8080/oxTrust/seam/resource/restv1/Users/
Accept: application/xml 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

* XML response
* Header

```
200 OK
Server: Apache-Coyote/1.1
Location: https://localhost:8080/oxTrust/seam/resource/restv1/Users/
Content-Type: application/xml
```

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Resources xmlns="urn:scim:schemas:core:1.0"><totalResults>4</totalResults><Resources><Resource><id>@!1111!0000!9711</id><externalId>random</externalId><userName>erik</userName><name><givenName>Erik</givenName><familyName>Hartog</familyName><middleName>N/A</middleName><honorificPrefix>N/A</honorificPrefix><honorificSuffix>N/A</honorificSuffix></name><displayName>Erik Hartog</displayName><nickName>Erik</nickName><profileUrl>http://www.gluu.org/</profileUrl><emails><email><value>random@gluu.org</value><type>work</type><primary>true</primary></email><email><value>random2@gluu.org</value><type>home</type><primary>false</primary></email></emails><addresses><address><type>work</type><streetAddress>621 East 6th Street Suite 200</streetAddress><locality>Austin</locality><region>TX</region><postalCode>78701</postalCode><country>US</country><formatted>621 East 6th Street Suite 200  Austin , TX 78701 US</formatted><primary>true</primary></address></addresses><PhoneNumbers><PhoneNumber><value>646-234-5678</value><type>work</type></PhoneNumber></PhoneNumbers><ims><im><value>erikk</value><type>Skype</type></im></ims><photos><photo><value>http://www.gluu.org/wp-content/themes/SaaS-II/images/logo.png</value><type>gluu photo</type></photo></photos><userType>user</userType><title>user</title><preferredLanguage>en-us</preferredLanguage><locale>en_US</locale><timezone>................................................the response is too long intentionally skipped some content for demo sake................................................</version><location>http://localhost:8080/oxTrust/seam/resource/restv1/Users/@!1111!0000!D4E7</location></meta></Resource></Resources></Resources>
```

# SCIM-Client API

SCIM-Client API , is a tool Gluu developed to make the communication with a SCIM server an easy task, SCIM-Client API can be used to build an application that sends request and receives responses from a SCIM server seamlessly.

You can checkout SCIM-client from our SVN repository : 
[https://svn.gluu.info/repository/openxdi/SCIM-Client/](https///svn.gluu.info/repository/openxdi/SCIM-Client/)

SCIM-client support both Basic and oAuth 2.0 authentication , below is an example on how to create a ScimClient instance

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
```

This will create an oAuth instance of ScimClient where: userName and passWord are the user credentials , clientID and clientSecret are oxAuth client credentials , domailURL is the domain where SCIM client resides example : [http://localhost:8080/oxTrust/seam/resource/restv1](http://localhost:8080/oxTrust/seam/resource/restv1)
oxAuthDomain is the tokenURL example [http://localhost:8080/oxauth/seam/resource/restv1/oxauth/token](http://localhost:8080/oxauth/seam/resource/restv1/oxauth/token)

```
ScimClient client = ScimClient.basicInstance(userName, passWord, domainURL);
```

For the basic authentication you only need the user’s credentials userName and passWord and the domain URL.

## Adding an entity

In this example we will show you how to add a person or a group using SCIM-Client, SCIM-Client API comes with two methods to accomplish that , “createPerson” and “createPersonString” ,with createPerson method you pass the person you want to add as ScimPerson object and you specify the desired media type format “XML/JSON” and SCIM-client API will parse the ScimPerson object into XML or JSON and send your request, Same applies to groups , you can use createGroup with ScimGroup as a parameter or createGroupString.
You can also use createPesronString method and pass the person as an XML or JSON String.

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimPerson person = new ScimPerson() ;
person.setUserName (String username );
person.setName.setGivenName(String firstName );
person.setName.setLastName(String lastName);
ScimResponse response = client.createPerson(person, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

In this 2nd example we will use createPersonString 

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.createPersonString(String person, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

## Modifying an entity

In this example we will show you how to modify a person or a group using SCIM-Client, SCIM-Client API comes with two methods to accomplish that , “updatePerson” and “updatePersonString” ,with updatePerson method you pass the person you want to update as ScimPerson object and his uid as a String and you specify the desired media type format “XML/JSON” and SCIM-client API will parse the ScimPerson object into XML or JSON and send your request, Same applies to groups , you can use createGroup with ScimGroup as a parameter or createGroupString.
You can also use createPesronString method and pass the person as an XML or JSON String.

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.updatePersonString(String person, String uid, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.updateGroupString(String group, String id, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

## Deleting an entity

To delete an entity you simply pass it’s ID as a String parameter into “deletePerson” or “deleteGroup” methods.

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

## Retrieving an entity

To retrieve a person or a group you can use “retrievePerson” or “retrieveGroup” method by passing the Entity’s id as a parameter and the desired media type.

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

## Bulk operations

To use Bulk operation you pass the operation as a ScimBulkOperation object into “bulkOperation” method or as a JSON/XML string into “bulkOperationString” method and without forgetting to specify the desired media type.

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

## oxAuth Client Creation

It’s possible to create an oxAuth client dynamically using SCIM-Client , this option is available using the static method “create” method of the class ”OxAuthClientCreator”, where “applicationName” is the name of the desired client, “registerUrl” is the client registration url example : 
[http://localhost:8080/oxauth/seam/resource/restv1/oxauth/register](http://localhost:8080/oxauth/seam/resource/restv1/oxauth/register)
and “redirectUris” is a space separated String containing the desired redirect urls.

```
CreationResult response = OxAuthClientCreator.create( applicationName, registerUrl, redirectUris);
response.getStatus(); // the status of the request 200 if successful
response.getClientId(); // the generated clientID
response.getClientSecret(); // the generated clientSecret
response.getExpiresAt(); // the expiration date of the client
```

## Bulk requests from Excel files

Excel spreadsheets are widely used by individuals and companies of different backgrounds , we at Gluu ,we thought about that , so we’ve embedded SCIM-client with methods that can help you turn an Excel file into a ScimBulkOperation object .
For that reason we made two methods available , one for generation bulk users request “ mapUsers” method and the other for generating bulk group requests “mapGroups” method , both methods takes the path to the “XLS” file as a parameter, methods are available at “ExcelMapper” class;

```
ScimBulkOperation usersOperation = ExcelMapper.mapUsers(excelFileLocationUsers);
ScimBulkOperation groupsOperation = ExcelMapper.mapGroups(excelFileLocationGroups);
```

You can download the Excel file models from here :
 [https://svn.gluu.info/repository/openxdi/SCIM-Client/doc/SampleXLS/](https///svn.gluu.info/repository/openxdi/SCIM-Client/doc/SampleXLS/)
Excel files must follow the exact structure, the “Operation” cell defines the type of the operation ”Add,Update,delete” .
For groups you can always add more groups to the spreadsheet following the same structure.

# SCIM Dynamic Custom Attributes

SCIM supports only a specific set of attributes and if we want to add any custom ones we would have to refactor the code every time we have a requirement for a new attribute, at Gluu, we thought of that and we came up the a dynamic way to add custom attributes to the person’s representation.
All you have to do is to add this portion to your person’s representation :
XML Example:

```
<code XML><customAttributes>
<name>oxTrustCustAttrA</name>
<values>
<value>some random value1</value>
<value>some random value2</value>
</values>
</customAttributes>
</code>
```

JSON Example:

```
"customAttributes":[{"name":"oxTrustCustAttrA","values":["some random value1","some random value2"]}]
```

Where “name” is the name of the LDAP attribute and “values” is its values , both single and multivalued attributes are supported , and custom attribute must be under “oxCustomAttributes” objectClass or they may be under the gluuPerson one , also in the “Attributes” LDAP node you will need to add an entry representation for the attribute , when“oxSCIMCustomAttribute” is set to true SCIM will look for that attribute in the person entry and if it has a value it will appear in the final result, when the attribute “oxMultivaluedAttribute” is set to true SCIM will know that this attribute is Multivalued , example:

```
dn: inum=@!1111!0005!8E7F,ou=attributes,o=@!1111,o=gluu
description: Sample custom attribute.
displayName: oxTrust Custom Attribute A
gluuAttributeEditType: admin
gluuAttributeName: oxTrustCustAttrA
gluuAttributeOrigin: oxCustomAttributes
gluuAttributePrivacyLevel: level3
gluuAttributeType: string
gluuAttributeViewType: admin
gluuStatus: active
inum: @!1111!0005!8E7F
objectClass: gluuAttribute
objectClass: top
oxMultivaluedAttribute: true
oxSCIMCustomAttribute: true
```

# User search service

This service is used to lockup a person/user by a specific attribute search pattern , for example if you want to look for a person with the email ID reda@gluu.org all you will have to do is to provide the service with the exact LDAP attribute name and the value you wish to look for as a content, and the service will return the person in question.

JSON Example:

```
POST https://localhost:8080/oxTrust/seam/resource/restv1/Users/Search 
Accept: application/json 
Authorization: Basic bWlrZTpzZWNyZXQ=
```

Content :

```
{"attribute":"oxTrustCustAttrA","value":"some random value1"}
```

XML example

```
POST https://localhost:8080/oxTrust/seam/resource/restv1/Users/Search 
Accept: application/xml 
Authorization: Basic bWlrZTpzZWNyZXQ=
```

Content:

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><SearchService xmlns="urn:scim:schemas:core:1.0"><attribute>oxTrustCustAttrA</attribute><value>some random value1</value></SearchService>
```

The result will be returned as a JSON or XML person as it would for a regular GET person operation. 

You can use the SCIM-Client library as follows:

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.personSearch(attribute,value MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

Where attribute is the attribute name, and value is the value you’re looking for.
