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

## OpenID Connect Scopes

In SAML, the IDP releases attributes to the SP. OpenID Connect provides similar functionality, 
with more flexibility in case the person needs to approve the release of information from the IDP 
to the website (or mobile application). In OAuth2, scopes can be used for various purposes. 
Connect uses OAuth2 scopes to "group" attributes. For example, we could have a scope called "address"
that includes the street, city, state, and country user claims.

## Client Registration

A client in OAuth2 could be either a website or mobile application. OpenID Connect has an API 
for [Dynamic Client Registration](http://openid.net/specs/openid-connect-registration-1_0.html)
which efficiently pushes the task to the application developer. If you don't want to write an
application to register your client, there are a few web pages around that can do the job for 
you. Gluu publishes the [oxAuth-RP](seed.gluu.org/oxauth-rp) and there is also another in
[PHP RP](http://www.gluu.co/php-sample-rp)

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



