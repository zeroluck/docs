# Gluu Server Logs

When it comes to troubleshooting issues in the Gluu Server, from service hiccups to outages, logs are the best place to start. 

The Gluu Server's logs can be found in the following locations:

#### System logs 
- For Ubuntu: `var/log`
- For rpm based systems: `/var/log/messages/

#### Web Server logs
- For Debian: `/var/log/apache2/`
- For rpm: `/var/log/httpd/`

#### Core Gluu Server logs
- `opt/tomcat/logs/`

#### SAML transaction related logs
- `/opt/idp/logs/`

#### LDAP logs
- `/opt/opendj/logs/`

#### Miscellaneous logs
- `/var/logs/`

#### Sometimes it's required to escalate the log levels. 
- OpenID Connect or any core logging: `log4j.xml`, which is located in `/opt/tomcat/webapps/oxauth/WEB-INF/classes/`
- SAML logging: `logging.xml`, which is located in `/opt/idp.conf/`

## System Logs

Sometimes it worthy to check system logs like `/var/log/messages`. These logs contain global system messages.

## Web Server logs

Apache httpd / apache2 logs are available in `/var/log/httpd` or `/var/log/apache2` for Ubutu.

1. `access_log`: This log contains information about requests coming into the Gluu Server, success status or requests, execution time for any request etc.

2. `error_log`: This log shows error messages if the web server encounter any issue while processing incoming requests.

3. `other_vhosts_access.log`: This log is specific to the Gluu Server setup and those links which are being requested by a user from a web browser. An example below:

        test.gluu.org:443 192.168.201.184 - - [17/Jul/2016:18:25:21 +0000] "GET /index.html HTTP/1.1" 200 13239 "-" "Java/1.7.0_95"
        test.gluu.org:443 192.168.201.1 - - [17/Jul/2016:18:25:56 +0000] "GET / HTTP/1.1" 302 2185 "-" "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36"
        test.gluu.org:443 192.168.201.1 - - [17/Jul/2016:18:25:56 +0000] "GET /identity/ HTTP/1.1" 200 583 "-" "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36"
        test.gluu.org:443 192.168.201.1 - - [17/Jul/2016:18:25:56 +0000] "GET /identity/home.htm HTTP/1.1" 302 272 "https://test.gluu.org/identity/" "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36"
        test.gluu.org:443 192.168.201.1 - - [17/Jul/2016:18:25:56 +0000] "GET /identity/login?cid=4 HTTP/1.1" 302 474 "https://test.gluu.org/identity/" "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36"
        test.gluu.org:443 192.168.201.1 - - [17/Jul/2016:18:25:56 +0000] "GET /oxauth/authorize?scope=openid+profile+email+user_name&response_type=code+id_token&nonce=nonce&redirect_uri=https%3A%2F%2Ftest.gluu.org%2Fidentity%2Fauthentication%2Fauthcode&client_id=%40%21EFCB.890F.FB6C.2603%210001%210A49.F454%210008%21F047.7275 HTTP/1.1" 302 450 "https://test.gluu.org/identity/" "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36" 

4. There are a few other logs like `ssl_access_log` , `ssl_error_log` , and `ssl_request_log` which are collecting information on port 443 specifically. 

Remember the initial `GET` request will hit the Apache server first, and then be proxied via the AJP port 8009 to tomcat. If you see traffic on the web server, but not on tomcat, this is a good place to check to see if something is wrong. For example, you might want to check if the firewall is blocking port 8009 if you see somthing like this:

        [Thu Jul 14 23:49:19 2016] [error] ajp_read_header: ajp_ilink_receive failed
        [Thu Jul 14 23:49:19 2016] [error] (70007)The timeout specified has expired: proxy: read response failed from (null) (localhost)
        [Thu Jul 14 23:49:20 2016] [error] (70007)The timeout specified has expired: ajp_ilink_receive() can't receive header
        [Thu Jul 14 23:49:20 2016] [error] ajp_read_header: ajp_ilink_receive failed
        [Thu Jul 14 23:49:20 2016] [error] (70007)The timeout specified has expired: proxy: read response failed from (null) (localhost)
        [Thu Jul 14 23:49:20 2016] [error] (70007)The timeout specified has expired: ajp_ilink_receive() can't receive header
        [Thu Jul 14 23:49:20 2016] [error] ajp_read_header: ajp_ilink_receive failed
        [Thu Jul 14 23:49:20 2016] [error] (70007)The timeout specified has expired: proxy: read response failed from (null) (localhost)

## Core logs

### oxAuth logs

1. `oxauth.log`

This log is gathering most of the authentication related information. Generally this is the first log to review for any authentication-related troubleshooting, like authentication failure or missing clients etc. Here's an example showing a successful user authentication:

        2016-07-16 15:43:28,232 INFO  [org.xdi.oxauth.auth.Authenticator] Authentication success for Client: '@!EFCB.890F.FB6C.2603!0001!0A49.F454!0008!F047.7275'
        2016-07-16 15:43:28,232 TRACE [org.xdi.oxauth.auth.Authenticator] Authentication successfully for '@!EFCB.890F.FB6C.2603!0001!0A49.F454!0008!F047.7275'
        2016-07-16 15:43:28,238 DEBUG [xdi.oxauth.token.ws.rs.TokenRestWebServiceImpl] Attempting to request access token: grantType = authorization_code, code = 61ba3c0d-42c4-4f1f-8420-fd5f6707f1b1, redirectUri = https://test.gluu.org/identity/authentication/authcode, username = null, refreshToken = null, clientId = null, ExtraParams = {grant_type=[Ljava.lang.String;@1add2a62, redirect_uri=[Ljava.lang.String;@2e0995b5, code=[Ljava.lang.String;@7743b5af}, isSecure = true, codeVerifier = null
        2016-07-16 15:43:28,249 DEBUG [org.xdi.oxauth.service.UserService] Getting user information from LDAP: userId = zico 

2. `oxauth_script.log` 

Most of the custom script's initialization and few more information are loaded here in this script. In the sample log below we can see 'Super Gluu' MFA has been loaded in the Gluu Server:

        2016-07-16 19:06:32,705 INFO  [org.xdi.service.PythonService] (pool-2-thread-2) oxPush2. Initialization
        2016-07-16 19:06:32,713 INFO  [org.xdi.service.PythonService] (pool-2-thread-2) oxPush2. Initialize notification services
        2016-07-16 19:06:32,750 INFO  [org.xdi.service.PythonService] (pool-2-thread-2) oxPush2. Initialized successfully. oneStep: 'False', twoStep: 'True', pushNotifications: 'False'

### oxTrust logs

1. `oxtrust.log` 

This log gathers logs related to Gluu Server Admin panel (called oxTrust). For example, what is the clientID of an oxTrust session? Or, what scopes are being used, etc. In the example below, you can see an admin user has successfuly logged into the `test.gluu.org` Gluu Server admin panel, has the proper authorizationCode, a redirectURI, and the user's role:

        2016-07-16 16:41:55,690 INFO  [org.gluu.oxtrust.action.Authenticator] authorizationCode : 555a7586-6ca2-4b39-ab39-2ac78ec81524
        2016-07-16 16:41:55,690 INFO  [org.gluu.oxtrust.action.Authenticator]  scopes : user_name email openid profile
        2016-07-16 16:41:55,691 INFO  [org.gluu.oxtrust.action.Authenticator] clientID : @!EFCB.890F.FB6C.2603!0001!0A49.F454!0008!F047.7275
        2016-07-16 16:41:55,691 INFO  [org.gluu.oxtrust.action.Authenticator] getting accessToken
        2016-07-16 16:41:55,691 INFO  [org.gluu.oxtrust.action.Authenticator] tokenURL : https://test.gluu.org/oxauth/seam/resource/restv1/oxauth/token
        2016-07-16 16:41:55,691 INFO  [org.gluu.oxtrust.action.Authenticator] Sending request to token endpoint
        2016-07-16 16:41:55,692 INFO  [org.gluu.oxtrust.action.Authenticator] redirectURI : https://test.gluu.org/identity/authentication/authcode
        2016-07-16 16:41:55,919 DEBUG [org.gluu.oxtrust.action.Authenticator]  tokenResponse : org.xdi.oxauth.client.TokenResponse@1914b8d
        2016-07-16 16:41:55,920 DEBUG [org.gluu.oxtrust.action.Authenticator]  tokenResponse.getErrorType() : null
        2016-07-16 16:41:55,921 DEBUG [org.gluu.oxtrust.action.Authenticator]  accessToken : d39bd11c-7bc0-45e1-b772-2d0a5f74e6fb
        2016-07-16 16:41:55,921 DEBUG [org.gluu.oxtrust.action.Authenticator]  validating AccessToken
        2016-07-16 16:41:56,004 DEBUG [org.gluu.oxtrust.action.Authenticator]  response3.getStatus() : 200
        2016-07-16 16:41:56,004 DEBUG [org.gluu.oxtrust.action.Authenticator] validate check session status:200
        2016-07-16 16:41:56,004 INFO  [org.gluu.oxtrust.action.Authenticator] Session validation successful. User is logged in
        2016-07-16 16:41:56,108 INFO  [org.gluu.oxtrust.action.Authenticator] user uid:admin
        2016-07-16 16:41:56,119 INFO  [org.gluu.oxtrust.action.Authenticator] Authenticating user 'admin'
        2016-07-16 16:41:56,125 DEBUG [org.gluu.oxtrust.action.Authenticator] Configuring application after user 'admin' login 

2. `oxtrust_script.log` 

This log collects information on oxTrust related scripts and their operations. For example, if an organization uses a custom attribute which populates values for every user, then the Gluu Server Administrator needs to use a custom script for their 'Cache Refresh' process. This log will receive information when the custom script runs.

3. `oxtrust_cache_refresh.log`

Cache Refresh related information is available here, such as Status, Primary failure etc. In the sample snippet below we are seeing the status of users that have been synced into Gluu Server, number of failures, and total number of updated users.

        2016-07-16 17:18:17,691 DEBUG [gluu.oxtrust.ldap.cache.service.CacheRefreshTimer] (pool-1-thread-9) Updated person '@!EFCB.890F.FB6C.2603!0001!0A49.F454!0000!40EB.AB8E'
        2016-07-16 17:18:17,691 INFO  [gluu.oxtrust.ldap.cache.service.CacheRefreshTimer] (pool-1-thread-9) Updated '2,002' entries
        2016-07-16 17:18:17,722 INFO  [gluu.oxtrust.ldap.cache.service.CacheRefreshTimer] (pool-1-thread-9) Failed to update '0' entries
        2016-07-16 17:18:17,738 DEBUG [gluu.oxtrust.ldap.cache.service.CacheRefreshTimer] (pool-1-thread-9) Keep external persons: 'true'
        2016-07-16 17:18:17,739 DEBUG [gluu.oxtrust.ldap.cache.service.CacheRefreshTimer] (pool-1-thread-9) Count entries '0' for removal from target server
        2016-07-16 17:18:17,739 INFO  [gluu.oxtrust.ldap.cache.service.CacheRefreshTimer] (pool-1-thread-9) Removed '0' persons from target server
        2016-07-16 17:18:17,739 INFO  [gluu.oxtrust.ldap.cache.service.CacheRefreshTimer] (pool-1-thread-9) There are '2,002' entries before updating inum list
        2016-07-16 17:18:17,740 INFO  [gluu.oxtrust.ldap.cache.service.CacheRefreshTimer] (pool-1-thread-9) There are '2,002' entries after removal '0' entries 
