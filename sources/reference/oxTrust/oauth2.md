# OAuth2

Please use these shorcuts to navigate the reference guide.
 * [Home](./index.md)
 * [SAML](./saml.md)
 * [Personal](./personal.md)
 * [Users](./users.md)
 * [Configuration](./configuration.md)

## Introduction

Gluu Server has implemented OpenID Connect based on the OAuth 2.0. OAuth 2.0 is an open standard for authorization providing a method for clients to access resources on behalf of a resource owner. OAuth introduces an authorization layer and separates the client from the resource owner. The protocol or framework allows access to the resource without using the credentials of the resource owner but a different set of credentials.

## Scopes
![Scope menu](img/admin_oauth2_scopemenu.png)

The data of a resource owner requested by an application to access the resouece is called Scopes. The resouece owner permits the scopes the application can access and this allows the data owner to decide what details he wishes to share with the application. Claims are more fine grain in nature and they are generally accepted from trusted entity. One example can be the *Address* scope which as *PO Box*, *City* claims in it. Gluu Server defines six scopes by default.
![Scopes Screenshot](img/admin_oauth2_scope.png)

The Gluu Server Administrator can easily add more scopes with the GUI. Click on *Add Scope* --> Provide Display Name, Description --> Click on *Add Claim* --> A new window with available claims will appear --> Select desired values --> Click *Ok* --> Click *Add*.
![Add Scopes](img/admin_auth2_scopeadd.png)

## Clients

Client in OAuth is defined as an application making protected resource request on behalf of the owner with the authorization of the same application. This definition does not apply to any particular implementation or profile. In general, we can say that a client is any entity which requests access to protected resources on behalf of the requesting party with the authorization of the resource owner.

_Select Clients:_
![Client Menu](img/admin_oauth2_clientmenu.png)

Available **Clients** can be seen by hitting the **Search** button leaving the search box empty.
![Client List](img/admin_oauth2_clientlist.png)

New client can be added easily with the **Add Client** feature.
![Add Client](admin_oauth2_addclient.png)

Clicking on the _Add Client_ link allows the Gluu Server Administrator to add new client. The search box can be used to look up previously added clients as well. The screenshot below shows the interface to add a new client.
![Add new client](admin_oauth2_newclient.png)

* _Display Name:_ This contains the recognizable and unique display name of the client.

* _Client Secret:_ This is the Data Encryption Standard scheme used by Confidential Clients to authenticate the token endpoints. The value for the secret can be inserted manually, but it is highly recommened to use the Dynamic Client Registration Endpoint. The Gluu oxAuth provides a random, generated Client Secret in the Dynamic Client Registration procedure.

* _Application Type:_ There are two types of applications, Web and Native. The different configuration for the different application types are given below.

  * _Web:_ The Dynamic Client Registration is the default for web. In this type the redirect_uri for implicit grant type must be a real hostname with HTTPS. This type is not approved any localhost or HTTP. The Web Application uses the Authorization code flow for Clients which can maintain a Client Secret between the URIs and Authorization server.

  * _Native:_ Custom URI for Native type application must follow HTTP with localhost. This is suitable for mobile app which cannot maintain the Client Secret between itself and the Authorization Server.

* _Algorithm:_ oxAuth supports various types of Signature and Encryption Algorithms for authorizing request parameter passing, ID token signature and encryption, Signing return responses, Encrypt User Info Endpoints etc.

It is a good practice to implement ID Token Signatures with the RSA SHA-256 Algorithm (algorithm value RS256). Additionally oxAuth also supports other algorithms that are listed below.

_Signature Algorithms:_ HS256, HS384, HS512, RS256, RS384, RS512, ES256, ES384, ES512.

_Encryption, Key Encryption Algorithms:_ RSA1_5, RSA-OAEP, A128KW, A256KW.

_Block Encryption Algorithms:_ A128CBC+HS256, A256CBC+HS612, A128GCM, A256GCM,

* _Pre Authorization:_ Gluu server disables this option by default, but it is possible to allow the users to access any URL according to the Organization Policy by the Gluu Server Administrator.

* _Redirect URI:_ The URI for native or web app can be added using this feature.
![RedirectURI](img/admin_oauth2_adduri.png)

Clicking on *Add URI* will open a new box to put the hostname in and it is done.

* _Add Group:_ This feature can be used to affiliate specific groups.
![Add Group](img/admin_oauth2_addgroup.png)

The existing groups can be listed by hitting the *Search* button keeping the search phrease blank.

* _Add Scopes:_ This option can be used to add the required scopes in the Gluu Server.
![Add Scopes](img/admin_oauth2_addscope.png)

The available scopes can be listed by hitting the *Search* button keeping the search phrase black and from this the Gluu Server Administrator can select the required scopes.

* _Add Response Type:_ There are three types of responses in the Gluu Server and they are Code, Token and ID Token. The Gluu Server Administrator can select all of them for testing purposes.
![Response Type](img/admin_oauth2_response.png)

## User-Managed Access

The User-Managed Access (UMA) is an OAuth based protocol designed to give a web user a unified control point for authorizing who and what can get access to their personal data.
![UMA Menu](img/admin_oauth2_umamenu.png)

The UMA page screenshot is given below.
![UMA Page](img/admin_oauth2_umascreen.png)
The UMA can be searched clicking the *Search* button. There are three tabs in this page; Resources, Policies and Scopes.

* _Add Resource Set in Resources tab:_ The following page will open up on clicking the *Add Resource Set* button.
![Resource Set](img/admin_oauth2_resourceset.png)
The fields marked with astericks, Name and Icon URL, are mandatory. The Gluu Server Administrator can add previously created Resource, Scope and Client using the add buttons.
