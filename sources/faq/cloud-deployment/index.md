# Cloud Deployment FAQ
[TOC]

The Cloud Deployment FAQ provides cloud specific notes for the cluster installation on different cloud providers. 
The following are notes, not complete installation guides. 
Please see the [Deployment Guide](http://www.gluu.org/docs/admin-guide/deployment/) for complete installation instructions.

## Microsoft Azure
Microsoft Azure assigns a public and private IP to the VM. Initially the server could not be reached at the public address (404 - error) even though Apache logs indicated inbound traffic and Gluu server login page was unavailable.

The Apache Virtual Hosts entries were modified to utilize specific ports `x.x.x.x:80` and `x.x.x.x:443` instead of setting any Public/Private IP address directly. A second modification of the `/etc/hosts` file of the Gluu Server and the `C:\Windows\System32\Drivers\etc` file of the host machine was edited mapping the private IP address of the VM to the custom URI (idp.example.com).

Another discovery was made; Azure assigns a new Public/Private IP addresses each time the server is started. This was troublesome as manual editing of the hosts file necessary to change the private IP mapping in the hosts file, every time the VM was shutdown or rebooted. 
The VM was rebuilt from image and placed into a Networking group to set a static Private IP to bypass the assigning of new Public/Private IP.

## Amazon AWS
Amazon AWS provides a public and private IP address to its clouds. 
Normal installation following the [deployment guide](http://www.gluu.org/docs/admin-guide/deployment/) was not working.

After installing the `gluu-package` server, a python script called `setup.py` must run to complete the installation. Running the script prompts for some values including hostname, IP address, locale etc. The script/installer will not work if the AWS Public IP address is used.

The Private IP address, provided in the `setup.py` prompt did not create any problem and the server ran without any hiccups. There was no issue found with the numeric portion of the domain name either.

## Help Us

Please help us by giving us your feedback sharing any knowledge you have regarding any tips or tricks to deploy Gluu Server in any specific cloud platform. Your feedback and suggestions are valuable to us and will allow us to enrich the community knowledge. Please to post a commit in this page in [this link](https://github.com/GluuFederation/docs/blob/master/sources/faq/cloud-deployment/index.md) or open a support ticket in the Gluu [Support Portal](support.gluu.org) to notify us about your feedback and suggestions.
