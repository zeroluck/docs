# How to Start/Stop Services Within Chroot Environment

The commands are common for centos and ubuntu both.
We've specified wherever these are different.
Although we've given only the restarting commands.
But the other commands like start/stop etc. may also be available depending upon the distribution in use.

There are three services which should be running at any instance of time the server is running.
These are:

* LDAP service i.e opendj.
* Apache web service i.e apache2 or httpd.
* Tomcat web service i.e tomcat. 

### Restarting opendj service

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
	


### Restarting Apache service 

The apache service in ubuntu is known as apache2 and for CentOS it's called httpd.

#### Restart apache in Ubuntu

`/etc/init.d/apache2 restart`

#### Restart apache in CentOS

`/etc/init.d/httpd restart`



### Restarting Tomcat service

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

