## Gluu Server FAQ

## What can I do with a Gluu Server?

People--employees, customers, and partners-–need to be identified to interact electronically
with an organization. Authentication (_authn_) and authorization (_authz_) is a challenge faced
by almost every organization large enough to register an Internet domain. And it’s not just
people that need to be authenticated and authorized. “Clients” are online agents that can
interact with services on your behalf. With the emergence of the IoT and the API economy,
developers and system administrators are urgently searching for standards based solutions and
best practices to improve the security of web and mobile applications.

The Gluu Server is like a router for authentication and authorization. It speaks multiple dialects
of SSO, and can help an organization manage both inbound and outbound authentication and authorization
requirements.  The Gluu Server is very flexible. Through the use of "interception scripts",
system administrators can mold the Gluu Server to solve the exact access management task at hand.

## How do I install the Gluu Server?

Instructions for installation can be found [here](../deployment/index.md)

## Where can I find license information for the components of the Gluu Server?

Licenses for the various components of the Gluu Server can be found [here](../introduction/index.md#licenses)

## Can I contribute to the Gluu Server?

Yes, please! Only with community involvement can the Gluu Server become the best free open source access management tool. You can fork the code on [GitHub](http://github.com/GluuFederation) and push us changes. Your input is greatly appreciated!

## Where can I report issues or feedback?

Please feel free to either open issues on [GitHub](https://github.com/GluuFederation/docs/issues) or you can register for a free account on our [support portal](https://support.gluu.org). For more Enterprise support, training, and consultations, [VIP Support](http://gluu.org/pricing) can be purchased.

## Do you offer Enterprise Support?

Yes! You can find more information on our [website](http://gluu.org/pricing).

## Does it work for mobile or api access management?

Yes! The Gluu Server provides interfaces for UMA, a new standardized profile of OAuth2. [Using UMA](./admin-guide/uma/) you can protect web URLs like APIs and folders and enforce authorization policies for access.

## How can the Gluu Server make the Internet a safer place?

It is imperative for our society that we decentralize identity. Facebook and
Google have bridged our inability to identify our friends on the Internet by
providing a central identity hub-–you can share a Google doc with someone
only if they have a Google account. With a myriad of vendors producing
hardware and software that interact on our behalf, we cannot build our society on
central identity silos. Like enlightened despotism, it seems efficient. But
over time, it undermines the design goal of the Internet--the resiliancy
of autonomous entities cooperating to form one network.  The Internet
was made possible by standards like tcp/ip, DNS, http and ssl. After 20 years,
we have the standards on which to build the Internet's identity infrastructure.
Free open source tools like the Gluu Server make these new identity standards
accessible to the masses. Now any domain can authenticate like Google (or at
least using the same API's and conventions).

## Why do organizations need the Gluu Server?

For years, deploying an application access management suite was too expensive
for any but the largest enterprises, who engineered tightly bundled proprietary
application security solutions like Oracle Access Manager, IBM Tivoli Access Manager
or CA SiteMinder. These security suites used proprietary protocols and resulted in
“vendor lock-in.” The Gluu server offers an alternative:
enterprise class access management, using 100% open source components
that are free to use in production. This recipe has been developed by Gluu over the
last five years, and is proven to work in a variety of deployments around the globe
that vary in size from small to humongous.

## Why does the Gluu Server rock?

The Gluu server makes simple things easy. For example, if your organization has Active Directory,
without writing any custom code, you can map your users, leverage your existing passwords, and
configure SSO with SAML or OpenID Connect websites. Voila!

But for complex deployments, the Gluu Server is both scalable and flexible.

As mentioned above, the Gluu offers "interception scripts" which enable system administrators to use
Jython to specify custom business logic at several critical integration points. The Gluu Server can call other APIs (for example fraud detection
or strong authentication) to tie together the components of security and identity infrastructure of your domain. Interception scripts are the glue of the Gluu Server. You can implement any crazy plan you can code to define the workflow for authentication, authorization, logout and
more.

This Gluu Server has more features and is easier to manage than commercial alternatives. This
recipe includes some of the most widely deployed federation components: like the Shibboleth SAML
Identity Provider, and some of the most cutting edge security solutions available anywhere: like
the OX UMA Authorization Server.

Feel confident that you are using the best open source application security software on the
planet and even on the Internet too!

## Who wants open source access management?

The Internet will not become a safer place if only big companies can afford security. If organizations
had to pay a license fee for every web, email and DNS server, the Internet would be a much smaller place.
Even companies that may opt for a non-open-source solution, may need a cost effective solutions to
recommend to partners. If you need your partners to support secure open standards for security, you can’t
ask them to buy expensive enterprise software. Finally, privacy advocates around the globe prefer open
source security solutions. Black boxes are anathema to application security.

## What are the future identity protocols and is the Gluu Server future-proof?

There is a major paradigm shift happening right now. In the past, there were too many Internet standards for
web authentication: OpenID 2.0, OAuth 1.0, WS-Federation, CAS, and many other protocols are on the trash heap
of failed or fading efforts. Finally, new standards have arisen that use the OAuth2 pattern, leveraging
a JSON/REST API architecture that is friendly to application developers. There is more consensus than ever
on how to achieve interoperable security.

In the future we will see Microsoft release WAAD - Windows Azure Active Directory. This will position
OpenID Connect to replace Kerberos, LDAP, SAML and WS-Trust as an application protocols to identify a person.
Google is already the biggest OpenID Connect IDP on the Internet, and the most cutting edge user of
identity to deliver services. But in addition to these two giants, a sea of service providers will vie to
help organizations manage identity.

The Gluu Server has been leading the OpenID Connect Interop since [January 2013](http://www.gluu.co/.fm8t)
We lead the development of the [Enterprise UMA](http://www.gluu.co/kantara) use case. We also participated
in the design of the Juju Application Security Protocol, which defines the interfaces between web and mobile
applications, and the open-standard based security components. We are leading an effort to standardize
Oauth2 multi-party federation. We also have the first implemenation of an OpenID Connect Proxy.

The Gluu Server has always been ahead, and without the constraint of know-it-all venture capitalists, telling
us how to run our business, we are free to develop not only what the market wants today, but we think
it needs. And if someone else writes a free open source component that is better than what OX provides,
we will abandon our OX component in its favor. This vaccuum cleaner approach to open source enables us
to stay a step ahead of our slow-footed enterprise competition, getting components to market faster and better.

## What will you learn if you read all the docs?

After reading the docs, you should be ready to deploy the Gluu Server, and start testing your OpenID Connect,
SAML, and UMA applications. You will be able to articulate the roadmap for security to developers in your
organization. Importantly, after reading these docs, programmers, system administrators, and Chief Information
Security Officer should be able to get alignment much more quickly on the important standards, and the
moving pieces that need to be addressed from a business perspective, not just a technical perspective.


