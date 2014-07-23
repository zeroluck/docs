# UMA Scopes

UMA Scopes is central part of UMA protocol which is bound to resource set and is used by policy to check whether user has access to resource or not.

In UMA Scope is described by json document and has following properties:

- name - name of scope (e.g. View photo, Edit photo)
- icon_uri - optional property to specify icon for photo

Example of typical json document of scope:

```
{
  "name": "Add photo",
  "icon_uri": "http://www.gluu.org/icons/add_photo_scope.png"
}
```

Scope description json document MAY contains custom properties which is out of scope of this document.

## Define UMA Scopes via oxTrust

![Alt text](/img/uma/uma_oxtrust_scopes.png "UMA Scopes")

![Alt text](/img/uma/uma_oxtrust_scopes_add.png "UMA Scopes Add")


## References
- [UMA Specifications](http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol)
- [UMA Requestion Party Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RP/)
- [UMA Resource Server Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RS/)
- [Gluu Server](http://gluu.org)
- [Juju Application Security Framework (JASF) Overview](http://www.gluu.co/juju-draft-overview)

[UMA]: http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol