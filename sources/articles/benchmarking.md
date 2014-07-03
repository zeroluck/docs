# Gluu Server Benchmark

## Performance Tuning

### LDAP Server

Here we describe most important configuration based on OpenDJ LDAP Server:
1.

 max-allowed-client-connections

### Tomcat

Connector parameters in server.xml
- maxThreads="10000"
- maxConnections="10000"

## Gluu Server Benchmark

Benchmarking based on Authentication Implicit Flow: http://openid.net/specs/openid-connect-core-1_0.html#ImplicitFlowAuth

<table>
  <tr>
    <td><b>Invocations &nbsp;&nbsp;</b></td>
    <td><b>Parallel threads &nbsp;&nbsp;</b></td>
    <td><b>Time</b></td>
  </tr>
  <tr>
    <td>100</td>
    <td>100</td>
    <td>8 seconds </td>
  </tr>
  <tr>
    <td>1000</td>
    <td>200</td>
    <td> 2 minutes 3 seconds </td>
  </tr>
  <tr>
    <td>1000</td>
    <td>200</td>
    <td> 2 minutes 3 seconds </td>
  </tr>
</table>

## Useful Links

[OpenDJ Performance Tuning](http://opendj.forgerock.org/opendj-server/doc/admin-guide/index/chap-tuning.html)
[OpenDJ Global configuration](http://opendj.forgerock.org/opendj-server/configref/global.html#max-allowed-client-connections)

