**Table of Contents** 

- [Overview](#overview)
- [New Jargon (taxonomy)](#new-jargon-taxonomy)
- [Discovery](#discovery)
- [Scopes](#scopes)
- [Client Registration](#client-registration)
	- [Custom Client Registration](#custom-client-registration)
	- [Search clients](#search-clients)
	- [View client](#view-clients)
- [Session management](#session-management)

# Overview 

Since [Interop 4](http://www.gluu.co/.fm8t) the Gluu Server has one of the most comprehensive
implementations of OpenID Connect. The current results from [IntereOp 5](http://www.gluu.co/.iwjk),
while not final, also put the Gluu Server at the top of the list.

[OpenID Connect](http://openid.net/connect) ("Connect") is a standard profile of OAuth2 which defines a protocol to enable a website or mobile application to send a person to a domain for authentication and required attributes (e.g. email address, first name, last name, etc.). Connect also provides some of the plumbing around authentication to automate how this happens. If a person is visiting a website for the  first time, the process that OpenID Connect defines is 100% bootstrapable by the website.  This is really critical for Interet scalability. To visit someone's website, or to send someone email, you don't need to get the system administrators involved. Connect provides the same type of scalable infrastructure, and promises to define a base level domain identification.

# New Jargon (taxonomy)

If you are familiar with SAML, there are many parallels in OpenID Connect, but the jargon (or "taxonomy") is different. For example, instead of attributes, we have "user claims". Instead of Service Provider (SP), we have "client". Instead of Identity Provider (IDP), its OpenID Provider (OP).  

# Discovery 

The first thing you want to know about any OAuth2 API is where are the endpoints (i.e. 
what are the URLs where you call the APIs). OpenID Connect provides a very simple
mechanism to accomlish this: make a GET request to `https://<domain>/.well-known/openid-configuration`

[OpenID Connect Discovery](http://openid.net/specs/openid-connect-discovery-1_0.html) is based on 
a previous standard called [WebFinger](http://en.wikipedia.org/wiki/WebFinger). 

If you want to try a sample discovery request, you can make a GET request to [Gluu's OpenID Connect Discovery Page](https://idp.gluu.org/.well-known/openid-configuration)

# Scopes

In SAML, the IDP releases attributes to the SP. OpenID Connect provides similar functionality, 
with more flexibility in case the person needs to self-approve the release of information from the IDP 
to the website (or mobile application). In OAuth2, scopes can be used for various purposes. 
OpenID Connect uses OAuth2 scopes to "group" attributes. For example, we could have a scope called "address"
that includes the street, city, state, and country user claims. The Gluu Server defines six scopes by default.

![Scopes Screenshot](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_oauth2_scope.png)

The Gluu Server Administrator can easily add more scopes in the GUI. Click *Add Scope* and you'll be presented with the following screen: 

![Add Scopes](http://www.gluu.org/docs/img/openid_connect/oxtrust_scope_screenshot.png "Screenshot of oxTrust add OpenID Connect Scope")

You'll have the ability to provide a Display Name, Description, whether or not the scope is provided by default, and the claims that are included in the scope. 

Default Scope needs some further explanation. When a client uses dynamic client registration, the OpenID Connect specification says that the `openid` scope should always be released, which contains an identifier for that person, normally the username. If you want to release another scope automatically, set the Default Scope to `true` for that scope. You can always explicitly release a scope to a certain client later on, but this will require some manual intervention by the domain administrator. 

To add more claims, simply click "Add Claim" and you'll be presented with the following screen:

![Add Claims](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_oauth2_scopeadd.png)

# Client Registration

A client in OAuth2 could be either a website or mobile application. OpenID Connect has an API 
for [Dynamic Client Registration](http://openid.net/specs/openid-connect-registration-1_0.html)
which efficiently pushes the task to the application developer. If you do not want to write an
application to register your client, there are a few web pages around that can do the job for 
you. Gluu publishes the [oxAuth-RP](seed.gluu.org/oxauth-rp) and there is also another in
[PHP RP](http://www.gluu.co/php-sample-rp)

If you can't get the developer to help themselves, or if your domain doesn't want to allow
dynamic client registration, you can use the oxTrust admin GUI to manually add trusted clients.

Available **Clients** can be seen by hitting the **Search** button leaving the search box empty.

![Client List](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_oauth2_clientlist.png)

A new client can be added by clicking the **Add Client** link.

![Add Client](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_oauth2_addclient.png)

Clicking on the _Add Client_ link allows the Gluu Server Administrator to add new client. The search box can be used to look up previously added clients as well. The screenshot below shows the interface to add a new client.

![Add new client](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_oauth2_newclient.png)

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
![RedirectURI](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_oauth2_adduri.png)

Clicking on *Add URI* will open a new box to put the hostname in and it is done.

* _Add Group:_ This feature can be used to affiliate specific groups.
![Add Group](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_oauth2_addgroup.png)

The existing groups can be listed by hitting the *Search* button keeping the search phrease blank.

* _Add Scopes:_ This option can be used to add the required scopes in the Gluu Server.
![Add Scopes](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_oauth2_addscope.png)

The available scopes can be listed by hitting the *Search* button keeping the search phrase black and from this the Gluu Server Administrator can select the required scopes.

* _Add Response Type:_ There are three types of responses in the Gluu Server and they are Code, Token and ID Token. The Gluu Server Administrator can select all of them for testing purposes.
![Response Type](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_oauth2_response.png)

## Custom Client Registration

Using interception scripts you can customize client registration behavior. For example, by default oxAuth allows new clients access to default scopes only. With a custom client registration interception script it iss possible to allow access to more scopes. For instance, we can use redirect_uri to determine if we need to allow access to additional scopes or not. 

To access the interface for custom scripts in oxTrust, navigate to Configuration > Custom Scripts > Custom Client Registration. 

Take a look at our [example client registration script](../../reference/interception-scripts/sample-client-registration-script.py) for a reference. 

## Search clients
![](http://www.gluu.org/docs/img/openid_connect/oxtrust_search_clients.png "Screenshot of oxTrust browse / search clients")

## View client

![](http://www.gluu.org/docs/img/openid_connect/oxtrust_view_client.png "Screenshot of oxTrust view client")


# Session management

Logout is a catch-22. There is no perfect answer to logout that satisfies all the requirements
of all the domains on the Internet. For example, large OpenID Providers, like Google, need
a totally stateless implementation--Google cannot track sessions on the server side for every
browser on the Internet. But in smaller domains, server side logout functionality can be 
a convenient solution to cleaning up resources.

The OpenID Connect [Session Management](http://openid.net/specs/openid-connect-session-1_0.html) is
still marked as draft, and new mechanisms for logout are in the works. The current specification 
requires Javascript to detect that the session has been ended in the browswer. It works... unless
the tab with the Javascript happens to be closed when the logout event happens on another tab. Also,
inserting Javascript into every page is not feasible for some applications. A new proposal is under
discussion where the OpenID Connect logout API would return `IMG` HTML tags to the browser
with the logout callbacks of the clients. This way, the browser could call the logout URIs (not
the server). 

The Gluu Server is very flexible, and supports both server side session management, and stateless
session management. For server side business logout, the domain admin can use Custom Logout scripts. 
This can be useful to clean up sessions in a legacy SSO system (i.e. SiteMinder), or perhaps
in a portal.

The key for logout is to understand the limitations of logout, and to test the use cases that
are important to you, so you will not be surprised by the behavior when you put your application
into production.

