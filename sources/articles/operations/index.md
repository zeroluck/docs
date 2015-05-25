**Table of Contents** 

- [Starting Gluu Server chroot environment](#starting-gluu-server-chroot-environment)
- [Stopping Gluu Server chroot environment](#stopping-gluu-server-chroot-environment)
- [Restarting OpenDJ service](#restarting-opendj-service)
- [Restarting Apache service](#restarting-apache-service)
	- [Restart apache in Ubuntu](#restart-apache-in-ubuntu)
	- [Restart apache in CentOS](#restart-apache-in-centos)
- [Restarting Tomcat service](#restarting-tomcat-service)

# Starting Gluu Server chroot environment

To start the the Gluu Server chroot environment, use the command:

`/etc/init.d/gluu-chroot start` 

Sample result of running the command is as follows:

	root@gluu:~# /etc/init.d/gluu-chroot start
	Starting Gluu Chroot Server: Starting OpenDJ: 
	Rather than invoking init scripts through /etc/init.d, use the service(8)
	utility, e.g. service S20cron start
	initctl: Unknown job: S20cron
	
	Since the script you are attempting to invoke has been converted to an
	Upstart job, you may also use the start(8) utility, e.g. start S20cron
	Starting Tomcat Servlet Container...
	Waiting for Tomcat Servlet Container......
	running: PID:11767
 	* Starting NTP server ntpd                                                                                                                                      [ OK ] 
 	* Starting web server apache2                                                                                                                                          AH00557: apache2: apr_sockaddr_info_get() failed for DA855F9895A1CA3B00020B185D7A.gluu.info
	AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.0.1. Set the 'ServerName' directive globally to suppress this message
 	* 


# Stopping Gluu Server chroot environment

To stop Gluu Server chroot environment, we simply issue the command::

`/etc/init.d/gluu-chroot stop`

Sample result of running the command is as follows:

	root@gluu:~# /etc/init.d/gluu-chroot stop
	Shutting down Gluu Chroot Server: Shutting down OpenDJ: [25/Aug/2014:11:33:13 +0000] category=BACKEND severity=NOTICE msgID=9896306 msg=The backend inumDB is now taken offline
	[25/Aug/2014:11:33:13 +0000] category=BACKEND severity=NOTICE msgID=9896306 msg=The backend userRoot is now taken offline
	[25/Aug/2014:11:33:13 +0000] category=CORE severity=NOTICE msgID=458955 msg=The Directory Server is now stopped
	
	Rather than invoking init scripts through /etc/init.d, use the service(8)
	utility, e.g. service S80cron stop
	initctl: Unknown job: S80cron
	
	Since the script you are attempting to invoke has been converted to an
	Upstart job, you may also use the stop(8) utility, e.g. stop S80cron
	Stopping Tomcat Servlet Container...
	Stopped Tomcat Servlet Container.
 	* Stopping NTP server ntpd                                                                                                                                      [ OK ] 
 	* Stopping web server apache2                                                                                                                                           * 
# Restarting OpenDJ service

To restart the opendj service, use the command:

`/etc/init.d/opendj restart` 

Sample result of running the command is as follows:

	GLUU.root@DA855F9895A1CA3B00020B185D7A:~# /etc/init.d/opendj restart
	[26/Aug/2014:20:12:00 +0000] category=BACKEND severity=NOTICE msgID=9896306 msg=The backend inumDB is now taken offline
	[26/Aug/2014:20:12:00 +0000] category=BACKEND severity=NOTICE msgID=9896306 msg=The backend userRoot is now taken offline
	[26/Aug/2014:20:12:00 +0000] category=CORE severity=NOTICE msgID=458955 msg=The Directory Server is now stopped
	
	GLUU.root@DA855F9895A1CA3B00020B185D7A:~# telnet localhost 1636
	Trying ::1...
	Connected to localhost.
	Escape character is '^]'.
	quit
	Connection closed by foreign host.
	GLUU.root@DA855F9895A1CA3B00020B185D7A:~# 
	


# Restarting Apache service 

The apache service in ubuntu is known as apache2 and for CentOS it's called httpd.

## Restart apache in Ubuntu

`/etc/init.d/apache2 restart`

## Restart apache in CentOS

`/etc/init.d/httpd restart`


# Restarting Tomcat service

The tomcat service is restarted in same way in both CentOS and Ubuntu.
Below is the command:
`/etc/init.d/tomcat  restart` 

The sample run is as follow:

	GLUU.root@DA855F9895A1CA3B00020B185D7A:~# /etc/init.d/tomcat restart
	Stopping Tomcat Servlet Container...
	Stopped Tomcat Servlet Container.
	Starting Tomcat Servlet Container...
	Waiting for Tomcat Servlet Container......
	running: PID:6967
	GLUU.root@DA855F9895A1CA3B00020B185D7A:~# 
