# Installing Gluu Server in Azure
Accessing Gluu Server on Azure can be a little tricky because of the Public/Private IP. Here is the step by step guide to creating a VM, installing Gluu Server and accessing the same.
These steps are OS independent.
## Setting up VM
1. Log into Windows Azure Administrative Panel

2. Click on `Virtual Machines` tab and click `Create a Virtual Machine` link

3. Choose `Compute` --> `Virtual Machine` --> `From Gallery` brach from the menu.

4. Choose Ubuntu Server 14.04 LTS or CentOS 6.7. Remember to set selinux to permissive if you choose CentOS.

5. Provide a name for the VM in the `Virtual Machine Name` field and use `Standard` for `Tier`.

6. Select at least `A2` variant equipped with 3.5GB RAM in the `Size` dropdown menu.

7. Provide username that will be used to connect via ssh and set access password, or upload certificate for passwordless auth; click `Next`.

8. Create a new cloud service and select `None` for `Availability Set` option.
	* Endpoints Section: This is  where port forwarding is set so that the internal IP address could be selectively reachable from the outside world. By default, only ssh tcp 22 port is there; public ports `http` and `https` (tcp ports 80 and 443) must be added and mapped to the same private ports. If the cloud mappings are flagged conflicting, proceed without setting them. Remember to set them after the cretion of the VM. Click `Next`.

9. Choose not to install `VM Agent` and click the `tick` button to finalize the VM.

10. Go to the `Dashboard` tab of VM Management Panel and copy the `DNS Name`. This is the name that is used to access Gluu Server.

11. SSH into the VM and install Gluu Server. See our [Deployment Guide](http://www.gluu.org/docs/admin-guide/deployment/) for installation instructions.

## Setup.py Configuration
This section describes what to put in the prompt when `setup.py` is run after installing Gluu Server. 

* IP Address: Do not change the default IP address; just hit `enter`

* hostname: Use the DNS name that was copied from the `VM Management Panel.

* Update hostname: Choose to update hostname for Ubuntu, but choose no if you are running CentOS.
	* For CentOS, manually update `/etc/sysconfig/networking` file by adding full DNS name.

* Other Settings: The other settings can be left to the default values.
	* Recommendation: Gluu server requires a 64bit OS and it is recommended to allocate 4GB RAM for `tomcat` in production environments.

* Now the DNS Name can be used to access the Gluu Server.
