# Cloud Deployment FAQ

The Cloud Deployemnt FAQ provides cloud specific notes for the cluster installation on different cloud providers. 
The following are notes, not complete installation guides. 
Please see the [Deployment Guide](http://www.gluu.org/docs/admin-guide/deployment/) for complete installation instructions.

## Microsoft Azure
Microsoft Azure assigns a public and private IP to the VM. Initially the server could not be reached at the public address (404 - error).
The Apache VirtualHosts entries were modified to utilize ports 80 and 443 instead of setting directly the Private (or Public IP address).
A second modification of the *hosts* file entries mapping the private IP address of the VM to the custom URI (idp.example.com).
This was done in \etc for both Gluu Server and the VM.

Without the hosts entries, a "404 not found" page would result, even though Apache logs indicated that it was seeing inbound traffic. It was only after the above mentioned changes were in place, the Gluu Server login page displayed correctly and admin login achieved.

One other discovery was made; Azure assigns a new Public/Private IP addresses each time the server is started. This was troublesome as manual editing of the hosts file necessary to change the private IP mapping in the hosts file, every time the VM was shutdown or rebooted. 
The VM was rebuilt from image and placed into a Networking group to set a static Private IP to bypass the assigning of new Public/Private IP.
