# UMA

Gluu Server has complete implementation of UMA protocol and in addition provides flexible authorization scripts.

## Reference

### UMA Client

* UMA Client on Maven repo: http://ox.gluu.org/maven/org/xdi/oxauth-client/1.3.2.Final/oxauth-client-1.3.2.Final.jar
* UMA Client sources: https://svn.gluu.info/repository/openxdi/oxAuth/trunk/Client/src/main/java/org/xdi/oxauth/client/uma/
* UMA Client test sources: https://svn.gluu.info/repository/openxdi/oxAuth/trunk/Client/src/test/java/org/xdi/oxauth/ws/rs/uma/

If you use maven you can use Gluu Maven public repository:

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

UMA Server is part of Gluu Server. To pick it up please refer to Gluu Server (oxAuth) documentation.

UMA Server source code:

```
https://svn.gluu.info/repository/openxdi/oxAuth/trunk/Server/src/main/java/org/xdi/oxauth/uma/ws/rs/
https://svn.gluu.info/repository/openxdi/oxAuth/trunk/Server/src/main/java/org/xdi/oxauth/service/uma/
```

## Sample of Gluu Server in Action

It may be not as obvious how to make whole UMA scenario work between different parties : Resource Server, Relying Party and Authorization Server. For this reason Gluu prepares :

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

