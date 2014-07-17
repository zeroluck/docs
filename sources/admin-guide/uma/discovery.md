# Discovery

User-Managed Access ([UMA]) is an OAuth-based web-based access management protocol. The protocol is defined in a draft version 1.0 specification. A corresponding specification defines obligations of legally responsible parties that engage in UMA-conforming interactions. Gluu Server implements UMA protocol and use it actively for protecting resources. It's possible to hook up authorization interception script which may contain logic when to grand (or forbid) access. All terminology used by this page is borrowed from UMA and Connect specs.

## UMA in Action

![Alt text](/img/uma/uma_parts.png "UMA Parts")
![Alt text](/img/uma/uma_flow.png "UMA Parts")
![Alt text](/img/uma/uma_token_workflow.png "UMA Parts")
![Alt text](/img/uma/uma_very_detailed_flow.png "UMA Parts")

## References
- [UMA Specifications](http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol)
- [UMA Requestion Party Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RP/)
- [UMA Resource Server Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RS/)
- [Gluu Server](http://gluu.org)
- [Juju Application Security Framework (JASF) Overview](http://www.gluu.co/juju-draft-overview)

[UMA]: http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol
