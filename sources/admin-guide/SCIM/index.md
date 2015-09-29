**Table of Contents**

- [SCIM Overview](#scim-overview)
- [Specification](#specification)
	- [Available Endpoints](#available-endpoints)
	- [Authentications](#authentications)
	- [Data representation formats](#data-representation-formats)
- [SCIM Operations](#scim-operations)
	- [Adding a new User](#adding-a-new-user)
	- [Getting a user](#getting-a-user)
	- [Modifying a user](#modifying-a-user)
	- [Delete a user](#delete-a-user)
	- [Bulk Request](#bulk-request)
	- [Getting list of users](#getting-list-of-users)
- [SCIM-Client API](scim-client-api)
	- [Adding an entity](#adding-an-entity)
	- [Modifying an entity](#modifying-an-entity)
	- [Deleting an entity](#deleting-an-entity)
	- [Retrieving an entity](#retrieving-an-entity)
	- [Bulk operations](#bulk-operations)
	- [oxAuth Client Creation](#oxauth-client-creation)
	- [Bulk requests from Excel files](#bulk-requests-from-excel-files)
- [SCIM Resource Management](#scim-resource-management) 
	- [SCIM UMA User Authentication](#scim-uma-user-authentication)
		- [Base Configuration: Create oxAuth Clients, Policies](#base-configuration-create-oxauth-clients-policies)
		- [oxTrust configuration (Resource Server)](#oxtrust-configuration-resource-server) 
		- [SCIM Client (Requesting Party) sample code](#scim-client-requesting-party-sample-code)
	- [SCIM oxAuth Authentication](#scim-oxauth-authentication)
		- [Base configuration: create oxAuth client](#base-configuration-create-oxauth-client)
		- [configuration (Resource Server)](#configuration-resource-server)
		- [SCIM Client (Requesting Party) sample code](#scim-client-requesting-party-sample-code)
	

## SCIM Overview

The Simple Cloud Identity Management (SCIM) specification is a standard REST/JSON API to standardize user and group CRUD (create, read, update, delete). You can review the detailed specification at [http://www.simplecloud.info](http://www.simplecloud.info). 
The specification seeks to build upon experience with existing schemas and deployments, placing specific emphasis on simplicity of development and integration, while applying existing authentication, authorization, and privacy models. It's intent is to reduce the cost and complexity of user management operations by providing a common user schema and extension model, as well as binding documents to provide patterns for exchanging this schema using standard protocols. In essence, make it fast, cheap, and easy to move users in to, out of, and around the cloud.

You can download a PDF copy of this guide from [HERE](https://github.com/GluuFederation/SCIM-Client/tree/master/doc/pdf).


## Specification

SCIM is integrated as a service of oxTrust. To start operating with SCIM’s web service, you need to send a request to one of SCIM’s endpoints. 

### Available Endpoints

For example, if you want to **add a user** you need to send an HTTP request to this endpoint url :

`https://localhost:8080/oxTrust/seam/resource/restv1/Users/`

for **bulk operations** (adding modifying and deleting multiple users ) you have to send a request to the bulk endpoint:

`https://localhost:8080/oxTrust/seam/resource/restv1/Bulk/`

for **group operations**:

`https://localhost:8080/oxTrust/seam/resource/restv1/Groups/`

### Authentications

You need to have a the right credentials and roles in order for you to access the endpoint example, which is for oxTrust means that you are a member of the Owner or Manager group specified in the organization entry. 
Gluu’s SCIM web service uses both **Basic authentication** and **oAuth 2.0 authentication**. For the basic type of authentication you need to specify the user and password (base64 encoded) in the HTTP request HTTP header in order to be authenticated 
Example :

```
POST https://localhost:8080/oxTrust/seam/resource/restv1/Users/ 
Accept: application/json 
Authorization: Basic bWlrZTpzZWNyZXQ=
```
Here we have sent user (Basic) and password (bWlrZTpzZWNyZXQ=) for basic authentication.

For oAuth **2.0 authentication** you need to request an access token via the SCIM client API in order for you to be able to get authenticated, the example below shows how an access token is sent to SCIM webservice as a header:

```
POST https://localhost:8080/oxTrust/seam/resource/restv1/Users/ 
Accept: application/json 
Authorization: Bearer 91732a27-fd00-487a-9dde-a6ed2fac6949
```

### Data representation formats

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
## SCIM Operations

Now, we'll discuss possible SCIM operations in detail. 

### Adding a new User

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

### Getting a user

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

### Modifying a user


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

### Delete a user

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

### Bulk request


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

### Getting list of users

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

## SCIM-Client API

SCIM-Client API is a tool Gluu developed to make the communication with a SCIM server an easy task. It can be used to build an application that sends request and receives responses from a SCIM server seamlessly.

You can checkout SCIM-client from our GIT repository : https://github.com/GluuFederation/SCIM-Client 

Below is an example on how to create a ScimClient instance

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
```

This will create an oAuth instance of ScimClient where: `userName` and `passWord` are the user credentials , `clientID` and `clientSecret` are oxAuth client credentials , `domailURL` is the domain where SCIM client resides, for example : `http://localhost:8080/oxTrust/seam/resource/restv1` and `oxAuthDomain` is the `tokenURL` example `http://localhost:8080/oxauth/seam/resource/restv1/oxauth/token`

```
ScimClient client = ScimClient.basicInstance(userName, passWord, domainURL);
```

As mentioned in the authentication part, for the basic authentication you only need the user’s credentials userName and passWord and the domain URL.

### Adding an entity

In this example we will show you how to add a person or a group using SCIM-Client, SCIM-Client API comes with two methods to accomplish this task, i. e. “createPerson” and “createPersonString”, with createPerson method you pass the person you want to add as ScimPerson object and you specify the desired media type format “XML/JSON” and SCIM-client API will parse the ScimPerson object into XML or JSON and send your request. Similarly for groups, you can use createGroup with ScimGroup as a parameter or createGroupString.

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

Similarly for groups, you can use createGroup with ScimGroup as a parameter or createGroupString. In this 2nd example we will use createPersonString:

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.createPersonString(String person, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

### Modifying an entity

In this example we will show you how to modify a person or a group using SCIM-Client, SCIM-Client API comes with two methods to accomplish that, i. e. “updatePerson” and “updatePersonString”, for updatePerson method, you pass the person you want to update as ScimPerson object and its uid as a String and you specify the desired media type format “XML/JSON” and SCIM-client API will parse the ScimPerson object into XML or JSON and send your request. 

```
ScimClient client = ScimClient.oAuthInstance(userName, passWord, clientID,clientSecret, domainURL, oxAuthDomain);
ScimResponse response = client.updatePersonString(String person, String uid, MediaType.APPLICATION_JSON);
response.getStatusCode() // this will give you the Status code
String result = response.getResponseBodyString(); // this will give you Response body 
```

Same applies for groups, you can use updateGroupString with ScimGroup as a parameter or createGroupString.

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

It’s possible to create an oxAuth client dynamically using SCIM-Client, this option is available using the static *create* method of the class `OxAuthClientCreator`, where `applicationName` is the name of the desired client, `registerUrl` is the client registration url example : 
`http://localhost:8080/oxauth/seam/resource/restv1/oxauth/register`
and `redirectUris` is a space separated String containing the desired redirect urls.

```
CreationResult response = OxAuthClientCreator.create( applicationName, registerUrl, redirectUris);
response.getStatus(); // the status of the request 200 if successful
response.getClientId(); // the generated clientID
response.getClientSecret(); // the generated clientSecret
response.getExpiresAt(); // the expiration date of the client
```

## Bulk requests from Excel files

Excel spreadsheets are widely used by individuals and companies of different backgrounds. Gluu have embedded SCIM-client with methods that can help you turn an Excel file into a ScimBulkOperation object .
For that reason we made two methods available, one for generation bulk users request *mapUsers* method and the other for generating bulk group requests *mapGroups* method, both methods take the path to the “XLS” file as a parameter, methods are available at “ExcelMapper” class:

```
ScimBulkOperation usersOperation = ExcelMapper.mapUsers(excelFileLocationUsers);
ScimBulkOperation groupsOperation = ExcelMapper.mapGroups(excelFileLocationGroups);
```

You can download the Excel file models from here : https://github.com/GluuFederation/SCIM-Client/tree/master/doc/SampleXLS

Excel files must follow the exact structure, the “Operation” cell defines the type of the operation ”Add,Update,delete” .
For groups you can always add more groups to the spreadsheet following the same structure.


## SCIM Resource Management

Gluu supports SCIM 1.1 and 2.0 for user management. By using SCIM services, you can create and manage Users as well as Groups for your organization automatically. 


At the moment, SCIM endpoints allow two types of Authentication modes:

1. SCIM UMA Authentication
2. SCIM oxAuth Authentication

To use any of the given authentication mode, we need to create user instance with specified authentication mode. We'll discuss each of the methods here:

### SCIM UMA User Authentication

This is step by step guide to configure UMA for oxTrust and SCIM client. 

#### Base Configuration: Create oxAuth Clients, Policies

1. Register oxAuth client with scope “uma_protection”. Property “oxAuthTokenEndpointAuthMethod” of this client should has value “client_secret_basic”. It's possible to do that using few methods: [Client Registration](http://ox.gluu.org/doku.php?id=oxauth:clientregistration), using [oxTrust](http://ox.gluu.org/doku.php?id=oxtrust:home) GUI, manually add entry to LDAP. oxTrust will use this oxAuth client to obtain PAT. Sample result entry:

        dn: inum=@!1111!0008!F781.80AF,ou=clients,o=@!1111,o=gluu
        objectClass: oxAuthClient
        objectClass: top
        displayName: Resource Server Client
        inum: @!1111!0008!F781.80AF
        oxAuthAppType: web
        oxAuthClientSecret: eUXIbkBHgIM=
        oxAuthIdTokenSignedResponseAlg: HS256
        oxAuthScope: inum=@!1111!0009!6D96,ou=scopes,o=@!1111,o=gluu
        oxAuthTokenEndpointAuthMethod: client_secret_basic

2. Register oxAuth client with scope “uma_authorization”. Property “oxAuthTokenEndpointAuthMethod” of this client should has value “client_secret_basic”. It's possible to do that using few methods: [Client Registration](http://ox.gluu.org/doku.php?id=oxauth:clientregistration), using [oxTrust](http://ox.gluu.org/doku.php?id=oxtrust:home) GUI, manually add entry to LDAP. SCIM Client will use this oxAuth client to obtain AAT. Sample result entry:

        dn: inum=@!1111!0008!FDC0.0FF5,ou=clients,o=@!1111,o=gluu
        objectClass: oxAuthClient
        objectClass: top
        displayName: Requesting Party Client
        inum: @!1111!0008!FDC0.0FF5
        oxAuthAppType: web
        oxAuthClientSecret: eUXIbkBHgIM=
        oxAuthIdTokenSignedResponseAlg: HS256
        oxAuthScope: inum=@!1111!0009!6D97,ou=scopes,o=@!1111,o=gluu
        oxAuthTokenEndpointAuthMethod: client_secret_basic

3. Create UMA policy. These are list of steps which allows to add new policy: 

 	1. Log with administrative privileges into oxTrust.
 	2. Open menu “Configuration→Manage Custom Scripts”.
 	4. Select “UMA Authorization Policies” tab and click “Add custom script configuration”.
 	5. Select language “Python”.
 	6. Paste this base policy script:


            from org.xdi.model.custom.script.type.uma import AuthorizationPolicyType
            from org.xdi.util import StringHelper, ArrayHelper
            from java.util import Arrays, ArrayList
            from org.xdi.oxauth.service.uma.authorization import AuthorizationContext

            import java

            class AuthorizationPolicy(AuthorizationPolicyType):
                def __init__(self, currentTimeMillis):
                    self.currentTimeMillis = currentTimeMillis

            def init(self, configurationAttributes):
                print "UMA authorization policy. Initialization"
                print "UMA authorization policy. Initialized successfully"

                return True   

            def destroy(self, configurationAttributes):
                print "UMA authorization policy. Destroy"
                print "UMA authorization policy. Destroyed successfully"
                return True   

            def getApiVersion(self):
                return 1

            # Authorizae access to resource
            #   authorizationContext is org.xdi.oxauth.service.uma.authorization.AuthorizationContext
            #   configurationAttributes is java.util.Map<String, SimpleCustomProperty>
            def authorize(self, authorizationContext, configurationAttributes):
                print "UMA Authorization policy. Attempting to authorize client"
                client_id = authorizationContext.getGrant().getClientId()
                user_id = authorizationContext.getGrant().getUserId()

                print "UMA Authorization policy. Client: ", client_id
                print "UMA Authorization policy. User: ", user_id
                if (StringHelper.equalsIgnoreCase("@!1111!0008!FDC0.0FF5", client_id)):
                    print "UMA Authorization policy. Authorizing client"
                    return True
                else:
                    print "UMA Authorization policy. Client isn't authorized"
                    return False

                print "UMA Authorization policy. Authorizing client"
                return True
 - Replace in script above client inum "@!1111!0008!FDC0.0FF5" with client inum which were added in step 2.
 - Click "Enabled" check box.
 - Click "Update" button.


4. Add UMA scope. These are list of steps which allows to add new scope.

	 - Log with administrative privileges into oxTrust.
	 - Open menu “OAuth2→UMA”.
	 - Select “Scopes” tab and click “Add Scope Description”.
	 - Select “Internal” type.
	 - Fill the form.
	 - Select policy which we aded in previous step.
	 - Click “Add” button. Sample result entry:

            dn: inum=@!1111!D386.9FB1,ou=scopes,ou=uma,o=@!1111,o=gluu
            objectClass: oxAuthUmaScopeDescription
            objectClass: top
            displayName: Access SCIM
            inum: @!1111!D386.9FB1
            owner: inum=@!1111!0000!D9D9,ou=people,o=@!1111,o=gluu
            oxPolicyScriptDn: inum=@!1111!CA0D.1918!2DAF.F995,ou=scripts,o=@!1111,o=gluu
            oxId: access_scim
            oxRevision: 1
            oxType: internal

5. Register UMA resource set. It's possible to do that via Rest API or via oxTrust GUI. Sample code: [https://github.com/GluuFederation/oxAuth/blob/master/Client/src/test/java/org/xdi/oxauth/ws/rs/uma/RegisterResourceSetFlowHttpTest.java) These are list of steps which allows to add new resource set:

	 - Log with administrative privileges into oxTrust.
	 - Open menu “OAuth2→UMA”.
	 - Select “Resources” tab and click “Add Resource Set”.
	 - Fill the form.
	 - Add UMA Scope which we created in previous steps.
	 - Add Client which we created in second step.
	 - Click “Add” button. Sample result entry:

                dn: inum=@!1111!C264.D316,ou=resource_sets,ou=uma,o=@!1111,o=gluu
                objectClass: oxAuthUmaResourceSet
                objectClass: top
                displayName: SCIM Resource Set
                inum: @!1111!C264.D316
                owner: inum=@!1111!0000!D9D9,ou=people,o=@!1111,o=gluu
                oxAuthUmaScope: inum=@!1111!D386.9FB1,ou=scopes,ou=uma,o=@!1111,o=gluu
                oxFaviconImage: http://example.org/scim_resource_set.jpg
                oxId: 1403179695657
                oxRevision: 1

#### oxTrust configuration (Resource Server)

Add next oxTrust UMA related configuration properties to oxTrust.properties:

    # UMA SCIM protection
    uma.issuer=https://ce.gluu.info
    uma.client_id=@!1111!0008!F781.80AF
    uma.client_password=<encrypted_password>
    uma.resource_id=1403179695657
    uma.scope=https://ce.gluu.info/oxauth/seam/resource/restv1/uma/scopes/access_scim

Values of these properties correspond to entries from first section.


#### SCIM Client (Requesting Party) sample code

This is sample SCIM Client code which request user information from server.

    package gluu.scim.client.dev.local;
    
    import gluu.scim.client.auth.UmaScimClientImpl;
    import gluu.scim.client.ScimResponse;

    import javax.ws.rs.core.MediaType;
    
    public class TestUMAScimClient {
	    public static void main(String[] args) {
     
		// public UmaScimClientImpl(String domain, String umaMetaDataUrl, String umaAatClientId, String umaAatClientSecret) 
		
		    final UmaScimClientImpl scimClient = new UmaScimClientImpl ("https://ce.gluu.info/identity/seam/resource/restv1", "https://ce.gluu.info/.well-known/uma-configuration",
				    "@!1111!0008!FDC0.0FF5", "secret");

		    try {
			// public ScimResponse retrievePerson(String uid, String mediaType) throws IOException 

			    ScimResponse response1 = scimClient.retrievePerson("@!1111!0008!FDC0.0FF5", MediaType.APPLICATION_JSON);
			    System.out.println(response1.getResponseBodyString());
			

		    } catch (Exception ex) {
			    ex.printStackTrace();
		    }
	    }
    
    }

Values from these example correspond to entries from first section. 

### SCIM oxAuth Authentication

This is a step by step guide to configure oxTrust and SCIM client for oxAuth authentication. 

#### Base Configuration: Create oxAuth Client
In order to access SCIM endpoints, an oxAuth client should be registered with scopes "openid" and "user_name".
Authentication method (or LDAP Property “oxAuthTokenEndpointAuthMethod”) of this client should have value “client_secret_basic”.
 
A new client can be created through various methods: [Client Registration](http://ox.gluu.org/doku.php?id=oxauth:clientregistration), using [oxTrust](http://ox.gluu.org/doku.php?id=oxtrust:home) GUI, or manually adding an entry to LDAP. 

Sample result entry:

        dn: inum=@!1111!0008!F781.80AF,ou=clients,o=@!1111,o=gluu
        objectClass: oxAuthClient
        objectClass: top
        displayName: SCIM
        inum: @!1111!0008!F781.80AF
        oxAuthAppType: web
        oxAuthClientSecret: eUXIbkBHgIM=
        oxAuthIdTokenSignedResponseAlg: HS256
        oxAuthScope: inum=@!1111!0009!E4B4,ou=scopes,o=@!1111,o=gluu
        oxAuthScope: inum=@!1111!0009!E4B5,ou=scopes,o=@!1111,o=gluu
        oxAuthTokenEndpointAuthMethod: client_secret_basic

####  Configuration (Resource Server)

It's possible to enable/disable SCIM endpoints in oxTrust under "Organization Configuration" page.

#### SCIM Client (Requesting Party) Sample Code

This is a sample SCIM Client code which requests user information from server.

    package gluu.scim.client.dev.local;
    
    import gluu.scim.client.ScimClient;
    import gluu.scim.client.ScimResponse;

    import javax.ws.rs.core.MediaType;
    
    public class TestScimClient {
	    public static void main(String[] args) {
		    final ScimClient scimClient = ScimClient.oAuthInstance("admin", "secret", "@!9BCF.396B.14EB.1974!0001!CA0D.1918!0008!2F06.F0DF", "secret",
				    "https://centos65.gluu.info/identity/seam/resource/restv1", "https://centos65.gluu.info/oxauth/seam/resource/restv1/oxauth/token");
		    try {
			    ScimResponse response1 = scimClient.retrievePerson("@!9BCF.396B.14EB.1974!0001!CA0D.1918!0000!A8F2.DE1E.D7FB", MediaType.APPLICATION_JSON);
			    System.out.println(response1.getResponseBodyString());
		    } catch (Exception ex) {
			    ex.printStackTrace();
		    }
	    }
    
    }

Values in this example are correspond to client entry fields from  first section.


