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

In comparison to SAML, scopes are equivalent to attributes. Scopes can be called the details which are permitted to be shared by the person who owns them. Scopes can also be related to the access token and defined as the input parameters for the access tokens. One example can be the *Address* scope which as *PO Box*, *City* claims in it. Gluu Server defines six scopes by default.
![Scopes Screenshot](img/admin_oauth2_scope.png)

The Gluu Server Administrator can easily add more scopes with the GUI. Click on *Add Scope* --> Provide Display Name, Description --> Click on *Add Claim* --> A new window with available claims will appear --> Select desired values --> Click *Ok* --> Click *Add*.
![Add Scopes](img/admin_auth2_scopeadd.png)

