# Resource Registration

UMA protects resources. To let know the Gluu Server about resource it has to be registered. Resource is described by following properties:

- name - name of resource
- scopes - scopes that are available for this resource
- type - type of resource (it can be string, uri or what ever, basically it's up to Resource Server what type it should be).
- icon_uri - uri to the icon.

These properties are standard properties however resource description MAY contain custom properties.

## Register resource via oxTrust

![oxTrust UMA Resources Interface](http://www.gluu.org/docs/img/uma/uma_oxtrust_resources.png "UMA Resources")

![oxTrust UMA Add Resources Interface](http://www.gluu.org/docs/img/uma/uma_oxtrust_resources_add.png "UMA Resources Add")

## References
- [UMA Specifications](http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol)
- [UMA Requestion Party Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RP/)
- [UMA Resource Server Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RS/)
- [Gluu Server](http://gluu.org)
- [Juju Application Security Framework (JASF) Overview](http://www.gluu.co/juju-draft-overview)

[UMA]: http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol
