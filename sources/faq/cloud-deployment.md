# Cloud Deployment FAQ

The Cloud Deployemnt FAQ provides cloud specific notes for the cluster installation on different cloud providers. The following are notes, not complete installation guides. Please refer to the [installation](http://www.gluu.org/docs-cluster/admin-guide/installation/#installation) section for a complete installation guide.

## Microsoft Azure
Microsoft Azure assigns a public and private IP to the VM. Initially the server could not be reached at the public address (404 - error).
The Apache VirtualHosts entries were modified to utilize ports 80 and 443 instead of setting directly the Private (or Public IP address).
A second modification of the *hosts* file entries mapping the private IP address of the VM to the custom URI (idp.example.com).
This was done in \etc for both Gluu Server and the VM. 
