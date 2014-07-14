# History

## How we got started

Gluu was founded in 2009 by Michael Schwartz. After selling his ISP to Verio in 1998, Mike
advised many large companies on identity and access management, directory services, and
application security. In late 2008, Mike had a hunch that Web single sign-on
was too complex, too proprietary and too expensive for many organizations. He felt that
a utility approach to SSO using open source software could provide an alternative to
expensive enterprise solutions. The Gluu Server was envisioned as an integrated
identity platform, based on free open source software, to make application security available
to significantly greater number of organizations.

## Early days : versions 1 and 2

Versions 1 of the Gluu Server was based on Sun OpenSSO and OpenDS. Mike Schwartz, foudner of Gluu,
presented the idea at an OpenSSO community group at the European Identity Conference in Munich in May 2009.
Version 1 worked a little, but there was no easy way to manage it. Version 2 of the Gluu Server had a better UI, but
it was just a facade--the UI didn't actually do anything to configure OpenSSO. Version 3 was launched after
Mike Schwartz met with members of the InCommon steering committee, after a meeting in San Antonio in October 2009.
Due to protocol, Mike couldn't attend the InCommon meeting, so Bob Morgan from the University of Washington
helped arrange drinks sponsored by Gluu at a nearby location.

At that meeting, Mike expressed concerned that OpenSSO might be end-of-life. Oracle had recently purchased
Sun Microsystems, and before ForgeRock was formed, it seemed possible that Oracle would simply
migrate OpenSSO customers to Oracle Access Manager. Bob convinced Mike that the Shibboleth IDP was a reasonable
alternative, and arguably had even more features in SAML, including fine grain access release policies, and
a better approach for multi-party federation. As the InCommon federation's efforts to evangelize SAML federation
would support Gluu's message, Mike considered that switching would have marketing advantages, would reduce the
event risk around OpenSSO, and might even be a better technical solution.

After this meeting, Mike was in Seattle, and met with Bob Morgan at UW campus. He also spoke with Steve
Carmody, then project manager for Shibboleth, and visited him in Providence at Brown. Shortly thereafter, a
new project from scratch was launched for Gluu Server v3 with the goal of using templates to simplify the
management of the Shibboleth IDP. This was really the birth of the first real Gluu Sever!

## V3: Gluu Server Ships!

The first live demo of the Gluu Server was at an InCommon event in Atlanta, GA in early November 2010.
At that demo, Hakeem Fahm, then IT director at the University of the District of Columbia,
was impressed and decided that the Gluu Server was exactly what his campus needed to join InCommon. Delivering
the first Gluu Server into production took three months. The order was placed before Thanksgiving, and it was finally
delivered in early February 2011. Mike helped write some of the python scripts, and establish the operating
procedures for deliver of the Gluu Server. In 2011, a few more campuses also adopted the Gluu Server.

## Enter OAuth2

OAuth2 had been on Gluu's roadmap since inception, but the impetus to actually start work on it was a consulting
project we had undertaken for [IDCubed](https://idcubed.org). This is the reason the OX software is MIT license--IDCubed
insisted on it. The project was a flop--Gluu couldn't deliver the graph based federated data solution quickly
enough. However, the upside was that as a result of this project Gluu was forced to accelerate the launch of
our OAuth2 based features, first with OpenID Connect in 2011, and then in late 2012, with the User Managed
the Gluu team felt that it provided a Policy Decision Point, Policy Enforcement Point framework that might enable
Access protocol.

## New Delivery Options

At OSCON 2014, Gluu introduced easier to install packages for the Gluu Server and support for the Ubuntu Juju
orchestration framework.

## The Future of the Gluu Server

