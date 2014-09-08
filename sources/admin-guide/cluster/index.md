## 1. Introduction

### 1.1 Objectives

The purpose of the technical design is to confirm that the Supplier has identified all the 
technical and technological requirements of the Purchaser and has defined the solutions that 
meet these requirements. This technical design of High Available Gluu Cluster can involve in 
it at least 2 and up to 5 fully redundant Gluu servers nodes. All available nodes will handle 
real time traffic, thus the server load will be distributed among all cluster member-nodes.


### 1.2 Glossary

* IDP - Identity Provider
* HA - High Availability
* IDS - Intrusion Detection System
* IPS - Intrusion Prevention System
* LB -  Load Balancer


### 1.3 Network and Security design

Gluu cluster has 2 primary requirement related to network design of data center. 
A local 1/10 Gbit/s interconnection between cluster member-nodes and load balancer in front of them, 
which will load balance http traffic to backend member-nodes. Gluu cluster has no any exact requirement 
related to LB algorithms or where in OSI stack is the LB implementation (e.g. TCP or HTTP). 
Some security standards have requirement “one primary function per server”, which can be accomplished 
by running each component of Gluu server under different chroot environments on member-node. 
For example Apache, Shibboleth, Tomcat, LDAP could be run physically on same node, under different chroot environments.

### 1.4  Cluster Description

Logical network diagram of Cluster is presented in [Figure 1](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/cluster/cluster.png)

#### 1.4.1  Requirments:

a) The quantity of active nodes in Gluu Cluster with can be no more than 5 nodes. If there will be necessity to increase quantity of nodes, then must be used Geo Cluster approach.

b) There must be LB in front of all nodes, which will load balance the traffic for real ip address between backend cluster member nodes. Gluu cluster has no requirment related to type of Interconnection between LB and member-nodes. 80 and 443 tcp ports must be open from outside world to front-end ip address of LB.

c) All member nodes must have LAN interconnection with at least 1 Gbit/ For easy and fast installation of IDP environment in every node, inside of cluster can be used single Linux distribution package.

#### 1.4.2  Advices:

a) For easy and fast installation of IDP environment in every node, on all member-nodes better to use same Linux distribution package.

#### 1.4.3  Brief description of cluster components and their roles (See Figure 1):

Each member node will act as Gluu server, which will actively serve traffic distributed to it by load balancer. 
As front end web server is being used Apache with mod_jk connector, which will load balance traffic between Tomcat servers on member-nodes. Mod_jk is being used with sticky sessions, which will route requests from same client to same member-node.
For file system sharing, real time synchronization and HA is being used GlusterFS. 
For LDAP real-time synchronization between member-nodes is being used OpenDJ multimaster replication. 
TwemProxy is being used as proxy for memcached servers. All member nodes will connect to locally and identically installed TwemProxy servers which will distribute memcached keys between memcached servers, based on consistent hashing algorithm.  
On each member node there is Health Check monitoring script, which will check the health of all important components of Gluu-server, and in case of fail of any component will isolate that node from cluster.
For shared file system backups is being used environment , which will do incremental and full backup within defined time intervals

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/cluster/cluster.png)
*Figure 1*


## 2.  Components

### 2.1 Load Balancer (LB)

LB is distributing workloads across multiple cluster member-nodes direct to apache servers. 
As LB there can be used any type of load balancer which can distribute HTTP traffic.  
The only requrment for LB is open tcp 80 and 443 ports from outside worls and distribute 
http/s traffic came on mentioned ports between cluster member nodes.

### 2.2 Apache 

Apache Behaves as front end web server, which load balances traffic to Tomcat servers in member-nodes, 
using Apache mod_jk connector. Mod_jk is installed with sticky sessions, which will pass requests of 
clients back to the same worker they were talking to last time.

### 2.3 OpenDJ

OpenDJ - LDAP replication must be used with multimaster synchronization mechanism. 
This will let to keep ldap databases synchronized on all member-nodes and the simultaneous load 
balancing of active traffic, will not break synchronization between nodes.
The replication topology and suggestions have been taken from official site of Opendj. 
LDAP Replication Topology for Cluster is presented in [Figure 2](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/cluster/ldap.png).

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/cluster/ldap.png)
*Figure 2* 

### 2.4 Memcached 

Memcached with Twemproxy is used for caching and session sharing.  
On each there is installed memcahed server which will act as backend for TwemProxy servers.

### 2.5  Twemproxy

Twemproxy is used as proxy server on front of memcached servers on member-nodes. 
Each member-node, to operate with memcached, will connect to locally installed Twemproxy server, 
which in its turn will distribute keys between memcached servers, based on consistent hashing algorithm. 
In case of fail of memcached on any member-node, TwemProxy will stop use failed node. 
All Twemproxy servers on member-nodes must have identical configuration files, listening localhost.
 
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/cluster/twemproxy.png)
*Figure 3*


TwemProxy detailed connection topology between two nodes for **Cluster** is presented [Figure 4](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/cluster/twemproxy2.png)
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/cluster/twemproxy2.png)
*Figure 4*

### 2.6	GlusterFs

Glusterfs is used for sharing and real-time synchronization of static files (keys, certificates, configuration files) 
between member-nodes. GlusterFs breaks are created as mirrors, and each node mounts the appropriate mirror break from localhost 
(from within itself). 

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/cluster/glusterfs.png?raw=true)
*Figure 5*


GlusterFS detailed connection topology between two nodes for Gluu Cluster is presented in [Figure 6](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/cluster/glusterfs2.png).
The files and directories inside of GlusterFS mount point can be mounted to the appropriate place in local node with 
bind option in mount utility.

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/cluster/glusterfs2.png)
*Figure 6*

### 2.7	Health check monitoring Script

Health check script is intended to monitor each service on member-node, 
and in case fail of any service, it will take action and isolate that member node from cluster.
Health check script must check health status of

a)	System components. According checking algorithm appropriate service can be stopped or isolated from cluster, 
	using firewall rules inside of Nodes. (Checking algorithm must be provided in other document)

b)	Integrity checking of files inside of mount point of GlusterFS. Collecting centralized integrity checking 
	information can help to monitor and determine the failure of GlusterFS inside of node.

c)	The status of component which is responsible for restarting a service in current node. 
	(Can be implemented in LDAP or in status file inside of GlusterFS)

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/cluster/flowchart_design.png)
Figure 7



