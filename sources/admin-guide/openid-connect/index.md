# OpenID Connect 

## Overview 

Since [Interop 4](http://www.gluu.co/.fm8t) the Gluu Server has one of the most comprehensive
implementations of OpenID Connect. The current results from [IntereOp 5](http://www.gluu.co/.iwjk),
while not final, also put the Gluu Server at the top of the list.

[OpenID Connect](http://openid.net/connect) ("Connect") is a profile of OAuth2 which 
defines a protocol to enable a website or mobile application to authenticate a person 
at a domain. Connect also provides some of the plumbing around authentication to automate 
how this happens. If a person is visiting a website for the 
first time, the process that OpenID Connect defines is 100% bootstrapable by the website. 
This is really critical for Interet scalability. To visit someone's website, or to send
someone email, you don't need to get the system administrators involved. Connect provides
the same type of scalable infrastructure, and promises to define a base level domain 
identification.

One could say that authentication was missing from the slew of important protocols that
were defined in the 1990s. DNS gave us scalable host management (imagine if you needed
a hosts file in your server with every server on the Internet!) Beyond host resolution, 
we could identify someone at a domain with their email address. But there was no way 
to verify that you really had that person on the other end of the Internet.

There are many reasons why Connect took so long. In the 90's, it wasn't clear if 
authentication would run on a new port, like RADIUS. But by 2000, it became clear
that HTTPS was the transport layer for authentication. At that time, many developers
and firms defined their own way to use HTTPS to authenticate a person. In this time,
there were too many standards. Developers started to expect a new authentication 
protocol to be introduced every year.

Luckily, by 2009, Connect facilitated a consolidation in the industry. As a profile
of OAuth2, it was the technology stack that developers wanted. It addressed some 
of the usability concerns of previous versions of OpenID. And while SAML was getting
some adoption, some of the vendors would not agree to breaking changes to the standard,
which made it hard to innovate sAML to address mobile use cases. With Microsoft editing
the specification, Google contributing a lot of its know-how and experience about 
security, and important usability feedback from Facebook, Connect provided a standard
for which many could agree.

## New Jargon (taxonomy)

If you are familiar with SAML, there are many parallels in OpenID Connect, but the 
jargon (or "taxonomy") is different. For example, instead of attributes, we have "user claims".
Instead of Service Provider (SP), we have "client". Instead of Identity Provider (IDP), its 
OpenID Provider (OP).  

## Discovery 

The first thing you want to know about any OAuth2 API is where are the endpoints (i.e. 
what are the URLs where you call the APIs). OpenID Connect provides a very simple
mechanism to accomlish this: make a GET request to `https://<domain>/.well-known/openid-configuration`
[OpenID Connect Discovery](http://openid.net/specs/openid-connect-discovery-1_0.html) is based on 
a previous standard called [WebFinger](http://en.wikipedia.org/wiki/WebFinger). 

If you want to try a sample discovery request, you can see the [Gluu IDP OpenID Connect Discovery Page](https://idp.gluu.org/.well-known/openid-configuration)

## OpenID Connect Scopes

In SAML, the IDP releases attributes to the SP. OpenID Connect provides similar functionality, 
with more flexibility in case the person needs to approve the release of information from the IDP 
to the website (or mobile application). In OAuth2, scopes can be used for various purposes. 
Connect uses OAuth2 scopes to "group" attributes. For example, we could have a scope called "address"
that includes the street, city, state, and country user claims.

The easiest way to manage OpenID Connect scopes in the Gluu Server is to use oxTrust. You can create
any scopes you want that contain any user claims that you have already defined. Its a pretty 
self-explanatory interface:

Screenshot of oxTrust OAuth2 Scope View
![](http://www.gluu.org/docs/img/openid_connect/oxtrust_scope_screenshot.png "Screenshot of oxTrust OAuth2 Scope View")

Default Scope needs some explanation. When a client uses dynamic client registration, the OpenID Connect
specification says that the `openid` scope should always be released, which contains an identifier
for that person, normally the username. If you want to release another scope automatically, set
the Default Scope to `true` for that scope. You can always explicitly release a scope to a certain
client later on, but this will require some manual intervention by the domain administrator.

## Client Registration

A client in OAuth2 could be either a website or mobile application. OpenID Connect has an API 
for [Dynamic Client Registration](http://openid.net/specs/openid-connect-registration-1_0.html)
which efficiently pushes the task to the application developer. If you don't want to write an
application to register your client, there are a few web pages around that can do the job for 
you. Gluu publishes the [oxAuth-RP](seed.gluu.org/oxauth-rp) and there is also another in
[PHP RP](http://www.gluu.co/php-sample-rp)

If you can't get the developer to help themselves, or if your domain doesn't want to allow
dynamic client registration, you can use the oxTrust admin GUI to manually
![add a client:](http://www.gluu.org/docs/img/openid_connect/oxtrust_add_client.png "Screenshot of oxTrust to add a client manually")  

* _**Display Name:**_ Recognizable and unique name of new client.

* _**Client Secret:**_ "Client Secret" is a Data Encryption Standard scheme which is being used by Confidential Clients to authenticate the token endpoints. The value for "Client Secret" can be manually inserted but it's highly recommended to use the Dynamic Client Registration Endpoint. oxAuth will provide a random generated "Client Secret" using the Dynamic Client Registration procedure.

* _**Application Type:**_ 
There are two types of Applications. (i) Web (ii) Native  
(i) Web:  
For Dynamic Registration the default type is web. In this type the redirect_uri for implicit grant type must have to be real hostname with HTTPS. No localhost or HTTP is approved here in this type. The Web application type uses the Authorization code flow for Clients which can maintain a Client Secret between these URIs and Authorization server.  
(ii) Native:   
Custom URI for Native type application must have to follow HTTP with localhost. This is suitable for mobile app, which cannot maintain the Client Secret between themselves and Authorization server. 

* _**Algorithm:**_ oxAuth supports various types of Signature and Encryption Algorithms for authorizing request parameter passing, ID Token signature and encryption, Signing return responses, Encrypt User Info Endpoints, etc. It’s a good practice to implement ID Token Signatures with the RSA SHA-256 Algorithm ( algorithm value RS256) but oxAuth also supports:
 * Signature Algorithms:  HS256, HS384, HS512, RS256, RS384, RS512, ES256, ES384, ES512  
 * For Encryption, Key Encryption Algorithms: RSA1_5, RSA-OAEP, A128KW, A256KW. 
 * Block Encryption Algorithms: A128CBC+HS256, A256CBC+HS512, A128GCM, A256GCM 

* _**Pre-Authorization:**_ Out of the box this field is marked as “Disabled”. But, according to Gluu Server Administrator and Organization policy, a client can be pre-authorized to access a certain url. 

* _**Redirect URIs:**_ Login and logout redirect URIs for Native or Web applications can be added in these fields.

* _**Scopes:**_ Scopes are groups of attributes that are released to the client. More details about scopes can be found [above](##OpenID-Connect-Scopes).

* _**Response Type:**_ There are three options for Response Type that can be used depending on your requirements:
 * code
 * token
 * id_token  
  
Read the [OpenID Connect Spec]( http://openid.net/specs/openid-connect-core-1_0.html) to learn more about when each Response Type should be used. 

* _**Authorized Groups:**_ This setting allows you to restrict client use to members of a certain group ([as created in the Gluu Server.](http://www.gluu.org/docs/admin-guide/user-management/local-user-mgt/))



####In oxTrust, you can also browse or search clients
![](http://www.gluu.org/docs/img/openid_connect/oxtrust_search_clients.png "Screenshot of oxTrust browse / search clients")

####And view a client

![](http://www.gluu.org/docs/img/openid_connect/oxtrust_view_client.png "Screenshot of oxTrust view client")

## Session management

Logout is a catch-22. There is no perfect answer to logout that satisfies all the requirements
of all the domains on the Internet. For example, large OpenID Providers, like Google, need
a totally stateless implementation--Google cannot track sessions on the server side for every
browser on the Internet. But in smaller domains, server side logout functionality can be 
a convenient solution to cleaning up resources.

The OpenID Connect [Session Management](http://openid.net/specs/openid-connect-session-1_0.html) is
still market as draft, and new mechanisms for logout are in the works. The current specification 
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



