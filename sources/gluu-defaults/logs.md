# Gluu Server Logs
## Tomcat Logs
Gluu Server Tomcat logs are available under the `/opt/tomcat/logs/` folder. The following logs are present in the logs folder

* cas.log
* catalina.<date>.log
* cas_perfStats.log
* host-manager.<date>.log
* localhost.<date>.log
* manager.<date>.log
* oxauth.log
* oxauth_persistence_ldap_statistics.log
* oxauth_script.log
* oxtrust.log
* oxtrust_cache_refresh.log
* oxtrust_cache_refresh_python.log
* oxtrust_persistence.log
* oxtrust_persistence_ldap_statistics.log
* oxtrust_script.log
* velocity.log
* wrapper.log

The logs can be tailed from the terminal and logging into Gluu Server chroot environment or they can be accessed from the oxTrust Admin GUI.

The following snippet will appear in the `wrapper.log` when Gluu Server starts :

```
INFO   | jvm 1    | 2016/05/09 23:05:22 | INFO: Server startup in 93381 ms
INFO   | jvm 1    | 2016/05/09 23:05:45 | 2016-05-09 23:05:45,507 INFO  [org.gluu.oxtrust.ldap.service.LogFileSizeChecker] OutXML: <?xml version="1.0" encoding="UTF-8"?>
INFO   | jvm 1    | 2016/05/09 23:05:45 | <entries>
INFO   | jvm 1    | 2016/05/09 23:05:45 |     <entry>
INFO   | jvm 1    | 2016/05/09 23:05:45 |         <prefix>host-manager</prefix>
INFO   | jvm 1    | 2016/05/09 23:05:45 |         <location>/opt/tomcat/logs</location>
INFO   | jvm 1    | 2016/05/09 23:05:45 |     </entry>
INFO   | jvm 1    | 2016/05/09 23:05:45 |     <entry>
INFO   | jvm 1    | 2016/05/09 23:05:45 |         <prefix>oxTrust</prefix>
INFO   | jvm 1    | 2016/05/09 23:05:45 |         <location>/opt/tomcat/logs</location>
INFO   | jvm 1    | 2016/05/09 23:05:45 |     </entry>
INFO   | jvm 1    | 2016/05/09 23:05:45 |     <entry>
INFO   | jvm 1    | 2016/05/09 23:05:45 |         <prefix>catalina</prefix>
INFO   | jvm 1    | 2016/05/09 23:05:45 |         <location>/opt/tomcat/logs</location>
INFO   | jvm 1    | 2016/05/09 23:05:45 |     </entry>
INFO   | jvm 1    | 2016/05/09 23:05:45 |     <entry>
INFO   | jvm 1    | 2016/05/09 23:05:45 |         <prefix>localhost</prefix>
INFO   | jvm 1    | 2016/05/09 23:05:45 |         <location>/opt/tomcat/logs</location>
INFO   | jvm 1    | 2016/05/09 23:05:45 |     </entry>
INFO   | jvm 1    | 2016/05/09 23:05:45 | </entries>
```
## IdP Logs
The IdP logs are stored under the `/opt/idp/logs/` folder within the Gluu Server Chroot environment. The following logs are available:

* idp-access.log
* idp-audit.log
* idp-process.log

## Configure Logs
Gluu Server has the ability to specify oxAuth/oxTrust log level using profiles. The default level is `INFO`, but it can be set to `TRACE` or `DEBUG` as well. The log levels cannot be changed from the oxTrust Admin GUI, it requires loggin into the Gluu Server chroot environment. The log level can be changed in the following file:
```
/opt/tomcat/webapps/oxauth/WEB-INF/classes/log4j.xml
``` 
