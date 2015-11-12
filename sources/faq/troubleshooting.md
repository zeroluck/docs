[TOC]
# Troubleshooting
## Memory
- Does the system have enough memory/CPU? For a production deployment, at least 4GB of RAM is required for tomcat and the full amount of RAM assigned for the host should be no less than 6GB. 

## OS
- The Gluu Server must be installed on a **64-bit** OS. If the host doesn't meet these requirements, it will not work. 

- Is the Gluu Server installed on a supported OS? Please check our [deployment doc](../admin-guide/deployment/index.md#supported-operating-systems) for supported operating systems and versions. 

## Browser and your local OS
- Is your browser updated to the most recent version available? Have you tried to access your Gluu instance with some other browser? Does it have any 3rd-party security-related add-ons installed? If it does you should try to switch them off and test the connection again.
- Do you have any anti-virus solution installed on the machine from which you are accessing Gluu's box, which tries to filter web traffic? Try to disable it and see whether it will resolve the issue.

## Networking
- Is there an unobstructed route between the machine from which you are accessing your Gluu's instance, and the machine at which it's installed? Firewalls on the destination host or, sometimes, security safeguards put by virtual machine renting service providers can be cutting off your Gluu from the outside world by default, and may require additional configuration efforts, specific to the particular case. Make sure that all needed ports are accessible and that Gluu is indeed the one who is listening on them. For Cache Refresh users: make sure that backend (source) LDAP database is accessible from the machine where Gluu is installed.

## Cloud Setups
- Be particularly cautious when dealing with cloud setups, as some solutions have strange and problematic network layouts, while others can severely limit disk access speeds, which results in prolonged service starts that can be mistaken for malfunctioning. See our [cloud FAQ's](./cloud-faq.md)

## VM Issues
- Have you meddled with your Gluu instance before the issue occurred, i.e. customized any configuration files, or source codes? 
- Was it a freshly installed OS, or has it been / is it being used for other purposes? It should be a freshly installed OS and dedicated to the Gluu Server only.
- **Please use [VMware Player](https://www.vmware.com/products/player).** Not VM Box, or any other virtualization software. 

## Diagnostic Commands to Gauge Health of Installation
- Try running the command `sudo netstat -lnpt`. Next ports must be present in your output (unless you are running some heavily customized version of Gluu):
  - Ports 80 and 443 should be taken by Apache
  - Ports 1389, 1636, 8005, 8009 should be taken by Java / Tomcat
- Try running the command `service gluu-server status` from outside of chroot-ed container; try to stop and start the service with `service gluu-server start/stop` - you should see notifications that Apache/Tomcat/OpenDJ have been started/stopped successfully, respectively.
- Try to run the commands `/etc/init.d/tomcat status` and `/etc/init.d/opendj status` from within chroot-ed container.
- Try stopping the Gluu Service, then check ports again with `netstat` command shown above. 
  - Are some of the required ports still present in the output? 
- Make sure that you have waited long enough after service was restarted (or just installed), especially on slow machines and VMs at problematic cloud providers. Often Gluu needs a minute or two to become fully operational (and until then it will return 404 error or blank pages) even on machines that meet all requirements, and on slow machines it will need even more time.

## Log Monitoring
- Monitor logs with `tail -F`, while repeatedly triggering the issue, and provide any suspicious entries that can be relevant to the case:
`/opt/tomcat/logs/wrapper.log`, `/opt/tomcat/logs/oxauth.log`, `/opt/tomcat/logs/oxtrust.log`, `/opt/tomcat/logs/oxtrust-cache-refresh.log`
Contents of snapshot directory (for instances running Cache Refresh), Apache logs (keep in mind that Gluu usually defines it's own Apache log), etc. 

Stop service, remove/rename wrapper.log and restart the application, then check the recreated wrapper.log (if something fails to start, records telling that may appear in this log)

## Forgot the admin password! 

Oh no, its been a few days since you booted your test Gluu Server, and you can't remember the admin password. No worries, the Gluu
Server stores this in `/install/community-edition-setup/setup.properties.last` under the property `ldapPass`. Try 
    # grep ldapPass= /install/community-edition-setup/*.last

Of course for a production installation, you should remove this file. Wouldn't want to have your admin password sitting on the filesystem!

# Add admin for gluu server

Please follow this steps to restore your Gluu admin account (you will probably need to substitute actual port, bind names and hostnames with ones used by your installation):

1) Login into Gluu's chroot environment with the command below:

`service gluu-server login`

2) Run this command:

`/opt/opendj/bin/ldapsearch -p 1389 -D 'cn=directory manager' -w 'YOUR_BIND_PASSWORD' -b o=gluu gluuGroupType=gluuManagerGroup 1.1`

and copy displayed dn of the Gluu Manager Group for future use

3) Run this command:

`/opt/opendj/bin/ldapsearch -p 1389 -D 'cn=directory manager' -w 'YOUR_BIND_PASSWORD' -b o=gluu ou=people 1.1`

and copy displayed dn of the People ou for future use
4) While staying in chrooted environment, create file "add_user.ldif" in your home ("~/") directory here using your favorite text editor, and copy the following lines to it:
```
dn: inum=tempadmin,ou=people,o=@!F9CC.D762.4778.1032!0001!2C72.BB87,o=gluu
changetype: add
uid: tempadmin
objectClass: gluuPerson
objectClass: top
givenName: tempadmin
sn: tempadmin
inum: tempadmin
gluuStatus: active
userPassword: 1q2w3e
```
Please note the string's segment marked with bold: you will have to substitute it with dn of your own People ou which you've acquired on step 3)

5) Run this command:

`/opt/opendj/bin/ldapmodify -p 1389 -D 'cn=directory manager' -w 'YOUR_BIND_PASSWORD' -f ~/add_user.ldif`

This will create new user tempadmin with attributes provided via file created on step 4)

6) Now create file "add_2_group.ldif" in your home ("~/") directory and copy the following lines to it:
```
dn: inum=@!F9CC.D762.4778.1032!0001!2C72.BB87!0003!60B7,ou=groups,o=@!f9cc.d762.4778.1032!0001!2c72.bb87,o=gluu
changetype: modify
add: member
member: inum=tempadmin,ou=people,o=@!f9cc.d762.4778.1032!0001!2c72.bb87,o=gluu
```

Please again note the strings' segment marked with bold: you will have to substitute contents of the "dn:" string with dn of your own Gluu Manager Group which you've acquired on step 2), and for "member:" string you will have to use the dn of tempadmin user (the one you specified in 1st line of the file in step 4)

7) Run this command:

`/opt/opendj/bin/ldapmodify -p 1389 -D 'cn=directory manager' -w 'YOUR_BIND_PASSWORD' -f ~/add_2_group.ldif`

This will add tempadmin user to the IdP managers group and you can then login and assign another user to act as admin.

# Revert Authentication Method
It is possible to get locked out of Gluu Server if the authentication script is faulty or for various other reasons. It is possible to modify the authentication method to revert back to the older method using `ldap` commands. The follwing guide will help you to revert back to the default authentication method.

* [Revert Authentication Method](http://www.gluu.org/docs/articles/auth-script/#reverting-authentication-method)
