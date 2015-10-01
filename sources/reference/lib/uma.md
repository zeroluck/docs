# UMA

The Gluu Server has a complete implementation of the UMA protocol. In
addition, it provides flexible authorization scripts.

## Reference

### UMA Client

* UMA Client on Maven repo: http://ox.gluu.org/maven/org/xdi/oxauth-client/1.3.2.Final/oxauth-client-1.3.2.Final.jar
* UMA Client sources: https://svn.gluu.info/repository/openxdi/oxAuth/trunk/Client/src/main/java/org/xdi/oxauth/client/uma/
* UMA Client test sources: https://svn.gluu.info/repository/openxdi/oxAuth/trunk/Client/src/test/java/org/xdi/oxauth/ws/rs/uma/

If you use Maven you can use the Gluu Maven public repository:

Repo url:

```
http://ox.gluu.org/maven/
```

Dependency:

```
   <groupId>org.xdi</groupId>
   <artifactId>oxauth-client</artifactId>
   <version>1.3.2.Final</version>
```

### UMA Server

The UMA Server is part of the Gluu Server. To pick it up please refer to
the Gluu Server (oxAuth) documentation.

The UMA Server source code is available from here:

```
https://svn.gluu.info/repository/openxdi/oxAuth/trunk/Server/src/main/java/org/xdi/oxauth/uma/ws/rs/
https://svn.gluu.info/repository/openxdi/oxAuth/trunk/Server/src/main/java/org/xdi/oxauth/service/uma/
```

## Sample of Gluu Server in Action

It may be not as obvious how to make the whole UMA scenario work between
the different parties -- the Resource Server, Relying Party, and the
Authorization Server. For this reason Gluu prepares these components:

- Gluu Server - Authorization Server
- [oxuma-rp](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RP/) - sample Relying Party
- [oxuma-rs](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RS/) - sample Resource Server

## References
- [UMA Specifications](http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol)
- [UMA Requestion Party Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RP/)
- [UMA Resource Server Sample implementation](https://svn.gluu.info/repository/openxdi/oxUmaDemo/RS/)
- [Gluu Server](http://gluu.org)
- [Juju Application Security Framework (JASF) Overview](http://www.gluu.co/juju-draft-overview)

[UMA]: http://kantarainitiative.org/confluence/display/uma/UMA+1.0+Core+Protocol

