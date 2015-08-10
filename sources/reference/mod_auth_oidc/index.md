# mod_auth_oidc

This is an authentication and/or authorization module for the Apache 2.x HTTP server implementing OpenID Connect.

## What is OpenID Connect

OpenID Connect is defined as "a simple identity layer on top of the OAuth 2.0 Protocol" according to [OpenID Connect Wrbsite](http://openid.net/connect/). It allows clients, including web-based, mobile and javascript, to authorize access by authenticating the user. The profile allows the clients to request and receive user infomation with encryption of identity data, discovery of OpenID Providers and session management.

The OpenID Connect 1.0 specification consists of six documents:  [Core](http://openid.net/specs/openid-connect-core-1_0.html), [Discovery](http://openid.net/specs/openid-connect-discovery-1_0.html), [Dynamic Registration](http://openid.net/specs/openid-connect-registration-1_0.html), [OAuth2.0 Multiple Response Types](http://openid.net/specs/oauth-v2-multiple-response-types-1_0.html), [OAuth2.0 Form Post Response Mode](http://openid.net/specs/oauth-v2-form-post-response-mode-1_0.html), [Session Management](http://openid.net/specs/openid-connect-session-1_0.html) and [HTTP-Based Logout](http://openid.net/specs/openid-connect-logout-1_0.html).

## Installation Instructions

The authoriztion module is available for install in Ubuntu and Centos. 
The instruction outline how to install the the module with Gluu Server. 
Please follow the instructions to install mod_auth_oidc in [Ubuntu](ubuntu-installation.md) or [CentOS](centos-installation.md)

