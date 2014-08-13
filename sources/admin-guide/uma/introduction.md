# Introduction

User-Managed Access ([UMA]) is an OAuth-based web-based access management protocol. The protocol is defined in a draft version 1.0 specification. A corresponding specification defines obligations of legally responsible parties that engage in UMA-conforming interactions. Although UMA's primary use cases have centered on individual people (that is, the "users" who manage access to their own online resources), the UMA notion of authorization as a service also has relevance to modern enterprises that must secure APIs and other web resources in a developer-friendly way.

##Enterprise UMA
The Gluu Server implements UMA actively in a way that enables the protectection of any web resource. Through the oxTrust interface, the server admin can write custom [authorization interception scripts](http://www.gluu.org/docs/admin-guide/interception-scripts/authorization/) which may contain logic to grant (or forbid) access. All terminology used by this page is borrowed from UMA and Connect specs.

## UMA in Action

[UMA Authorization Workflow](http://www.gluu.org/docs/img/uma/uma_parts.png "UMA Parts")
[Detailed authorization overview](http://www.gluu.org/docs/img/uma/uma_flow.png "UMA Parts")
[UMA Authorization token workflow](http://www.gluu.org/docs/img/uma/uma_token_workflow.png "UMA Parts")
[UMA Authorization complete sequence diagram](http://www.gluu.org/docs/img/uma/uma_very_detailed_flow.png "UMA Parts")

## References
- [UMA Specifications](http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol)
- [UMA Requestion Party Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RP/)
- [UMA Resource Server Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RS/)
- [Gluu Server](http://gluu.org)
- [Juju Application Security Framework (JASF) Overview](http://www.gluu.co/juju-draft-overview)

[UMA]: http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol
