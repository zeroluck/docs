# OpenID Connect

## Introduction

OpenID Connect 1.0 is a simple identity layer on top of the OAuth 2.0 protocol. It allows Clients to verify the identity of the End-User based on the authentication performed by an Authorization Server, as well as to obtain basic profile information about the End-User in an interoperable and REST-like manner.

OpenID Connect allows clients of all types, including Web-based, mobile, and JavaScript clients, to request and receive information about authenticated sessions and end-users. The specification suite is extensible, allowing participants to use optional features such as encryption of identity data, discovery of OpenID Providers, and session management, when it makes sense for them.

## oxAuth

oxAuth is an open source OpenID Provider that implements the OpenID Connect 1.0 stack of REST services. The project also includes OpenID Connect Client code which can be used by websites to validate tokens. It currently implements all required aspects of the OpenID Connect stack, including an OAuth 2.0 authorization server, Simple Web Discovery, Dynamic Client Registration, JSON Web Tokens, and JSON Web Keys, and User Info Endpoint. 

 - oxAuth Server, Client and RP [Source Code](https://github.com/GluuFederation/oxAuth).
 - oxAuth [OP](https://seed.gluu.org/oxauth), [RP](https://seed.gluu.org/oxauth-rp) and [Configuration Endpoint](https://seed.gluu.org/.well-known/openid-configuration).

## References
- [OpenID Connect Specifications](http://openid.net/connect/)
- [The OAuth 2.0 Authorization Framework](http://tools.ietf.org/html/rfc6749)
- [Frequently Asked Questions about OpenID Connect](http://openid.net/connect/faq/)
