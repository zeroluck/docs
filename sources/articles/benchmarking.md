# Gluu Server Benchmark

## Performance Tuning

Gluu Server has stateless architecture, it scales quite easy. However to get high-performant server it must be tuned accordingly.

Tuning consists of:

- LDAP Server (OpenDJ, OpenLDAP)
- Web Application Container (Tomcat, Jetty, JBoss)
- Gluu Server configuration Tuning

### LDAP Server

(For convenience all samples sticks to OpenDJ however general recommendations are the same for other LDAP Servers)

1. Maximum allowed connections

If there is not enough connections to serve the client, connection is put "on hold" and waits. To avoid delays it's recommended to provide expected maximum allowed connections.

```
 max-allowed-client-connections=1000
```

2. Provide enough resources to LDAP Server

For example OpenDJ use JVM for running, for high performance it's recommended to give enough memory via JVM system properties.

3. Allow LDAP Server use cache as much as possible.

```
    dsconfig -n set-backed-prop --backend-name userRoot --set db-cache-percent:50
```

### Tomcat

  1. Set maxmimum for parallel requests.

Connector parameters in server.xml:

- maxThreads="10000"
- maxConnections="10000"

  2. Set memory settings via JAVA_OPTS

set "JAVA_OPTS=-Xms1456m -Xmx7512m -XX:MaxPermSize=256m -XX:+DisableExplicitGC"

  3. Operating time

Check via Tomcat monitor whether requests are handled or just "hangs" because there no enough resources

Here is sample when processing time increase due to lack of resources:

![Alt text](http://gluu.org/docs/img/benchmark/tomcatStatus.png "Tomcat status")

## Gluu Server

- oxauth-ldap.properties - Increase ldap connection pool size

    maxconnections: 1000


## Gluu Server Benchmark

Benchmarking based on Authentication Implicit Flow: http://openid.net/specs/openid-connect-core-1_0.html#ImplicitFlowAuth

Measures were made on single machine with Gluu Server, LDAP Server and test runner (clients). Therefore here is quite <b>subjective</b> results

<table>
  <tr>
    <td><b>Invocations &nbsp;&nbsp;</b></td>
    <td><b>Parallel threads &nbsp;&nbsp;</b></td>
    <td><b>Time</b></td>
    <td><b>Comments</b></td>
  </tr>
  <tr>
    <td>100</td>
    <td>100</td>
    <td>8 seconds </td>
    <td></td>
  </tr>
  <tr>
    <td>1000</td>
    <td>100</td>
    <td>-</td>
    <td></td>
  </tr>
  <tr>
    <td>1000</td>
    <td>200</td>
    <td>-</td>
    <td>Not representable: CPU 100%</td>
  </tr>
  <tr>
    <td>2000</td>
    <td>100</td>
    <td>-</td>
    <td>Not representable: CPU 100%</td>
  </tr>
  <tr>
    <td>2000</td>
    <td>200</td>
    <td>-</td>
    <td>Not representable: CPU 100%</td>
  </tr>
  <tr>
    <td>10000</td>
    <td>300</td>
    <td>-</td>
    <td>Not representable: CPU 100%</td>
  </tr>
  <tr>
    <td>1000000</td>
    <td>300</td>
    <td>-</td>
    <td>Not representable: CPU 100%</td>
  </tr>
</table>

## Useful Links

- [OpenDJ Performance Tuning](http://opendj.forgerock.org/opendj-server/doc/admin-guide/index/chap-tuning.html)
- [OpenDJ Global configuration](http://opendj.forgerock.org/opendj-server/configref/global.html#max-allowed-client-connections)

