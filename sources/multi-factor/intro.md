# Authentication in the Gluu Server

The Gluu Server was designed to be very flexible in handling unique requirements for authentication. By default, the Gluu Server utilizes LDAP (either the local LDAP included in all Gluu Server deployments, or an existing backend LDAP that is connected via our [Cache Refresh](../cache-refresh/index.md) process) for basic username/password authentication. 

The Gluu Server's authentication cabilities can be extended through the use of [custom jython interception scripts](../customize/script.md/) to call any third party authentication mechanism's APIs. For example, the Gluu Server ships with a script that calls APIs for the free two-factor authentication mobile application, Super Gluu.  

Using custom interception scripts, you can implement sophisticated logic that takes into consideration metadata such as the time of day, location, device, IP address, etc. of the authentication before approving or denying the request. 


