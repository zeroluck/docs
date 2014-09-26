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

