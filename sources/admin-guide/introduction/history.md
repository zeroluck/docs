# History

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
At that demo, Hakeem Fahm, then IT director at the University of the District of Columbia (UDC),
was impressed and decided that the Gluu Server was exactly what his campus needed to join InCommon. Deliverying
the first Gluu Server into production took three months. The order was placed before Thanksgiving, and it was finally
delivered in early February 2011. Mike helped write some of the python scripts, and establish the operating
procedures for deliver of the Gluu Server. In 2011, a few more campuses also adopted the Gluu Server.

## Enter OpenID Connect

Gluu started working on OpenID Connect at the end of 2011. OAuth2 had been on Gluu's roadmap, and the impetus to
actually start work on it was a consulting project we had undertaken for [IDCubed](https://idcubed.org). This is
the reason the OX software is MIT license--IDCubed insisted on it. The project was a flop--Gluu couldn't deliver the
graph based federated data solution quickly enough, and IDCubed never paid their bill. However, the upside was that
as a result of this project Gluu was forced to accelerate the launch of our OpenID Connect OP, which turned
out to be a competitive advantage for Gluu.

## Enter UMA

In late 2012, after reviewing the UMA standard, written by form OpenSSO team member and SAML specification edition Eve Maler,
the Gluu team felt that it provided a Policy Decision Point, Policy Enforcement Point framework that might enable
the use of OAuth2 for Web Access Management.

## Gluu Server Community Edition

At OSCON 2014, Gluu introduced easier to install packages for the Gluu Server.

## Gluu Server Juju Delivery

Also at OSCON in 2014, Gluu introduced the Juju delivered version of the Gluu Server.
