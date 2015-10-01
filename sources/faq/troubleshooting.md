# Troubleshooting

## Memory
- Does the system have enough memory/CPU? At least 4GB of RAM is required for for tomcat so the full amount of RAM assigned for the host should be no less than 6GB. 

## OS
- The Gluu Server must be installed on a 64 bit OS. If the host doesn't meet these requirements, it **will not** work. 

- Is the Gluu Server installed on a supported OS? Please check our [deployment doc](../admin-guide/deployment/index.md#supported-operating-systems) for supported operating systems and versions. 

## Browser and your local OS
- Is your browser updated to the most recent version available? Have you tried to access your Gluu instance with some other browser? Does it have any 3rd-party security-related add-ons installed? If it does you should try to switch them off and test the connection again.
- Do you have any anti-virus solution installed on the machine from which you are accessing Gluu's box, which tries to filter web traffic? Try to disable it and see whether it will resolve the issue.

## Networking
- Is there an unobstructed route between the machine from which you are accessing your Gluu's instance, and the machine at which it's installed? Firewalls on the destination host or, sometimes, security safeguards put by virtual machine renting service providers can be cuting off your Gluu from the outside world by default, and may require additional configuration efforts, specific to the particular case. Make sure that all needed ports are accessible and that Gluu is indeed the one who is listening on them. For Cache Refresh users: make sure that backend (source) LDAP database is accessbile from the machine where Gluu is installed.

## Cloud Setups
- Be particularly cautious when dealing with cloud setups, as some solutions have strange and problematic network layouts, while others can severly limit disk access speeds, which results in prolonged service starts that can be mistaken for malfunctioning. See our [cloud FAQ's](./cloud-faq.md)

## VM Issues
- Have you medddled with your Gluu instance before the issue occured, i.e. customized any config files, or source codes? 
- Was it a freshly installed OS, or has it been / is it being used for other purposes? It should be a freshly installed OS and dedicated to the Gluu Server only.

## Diagnostic Commands to Gauge Health of Installation
- Try running the command `sudo netstat -lnpt`. Next ports must be present in your output (unless you are running some heavily customized version of Gluu):
  - Ports 80 and 443 should be taken by Apache
  - Ports 1389, 1636, 8005, 8009 should be taken by Java / Tomcat
- Try running the command `service gluu-server status` from outside of chroot-ed container; try to stop and start the service with `service gluu-server start/stop` - you should see notifications that Apache/Tomcat/OpenDJ have been started/stopped successfully, respectively.
- Try to run the commands `/etc/init.d/tomcat status` and `/etc/init.d/opendj status` from within chroot-ed container.
- Try stopping the Gluu Service, then check ports again with `netstat` command shown above. 
  - Are some of the required ports still present in the output? 
- Make sure that you have waited long enough after service was restarted (or just installed), especially on slow machines and VMs at problematic cloud providers. Often Gluu needs a minute or two to become fully operational (and until then it will return 404 error or blank pages) even on machines that meet all requirements, and on slow machines it will need even more time.

## Log Monitoing
- Monitor logs with `tail -F`, while repeatedly triggering the issue, and provide any suspicious entries that can be relevant to the case:
`/opt/tomcat/logs/wrapper.log`, `/opt/tomcat/logs/oxauth.log`, `/opt/tomcat/logs/oxtrust.log`, `/opt/tomcat/logs/oxtrust-cache-refresh.log`
Contents of snapshot directory (for instances running Cache Refresh), Apache logs (keep in mind that Gluu usually defines it's own Apache log), etc. 

Stop service, remove/rename wrapper.log and restart the application, then check the recreated wrapper.log (if something fails to start, records telling that may appear in this log)
