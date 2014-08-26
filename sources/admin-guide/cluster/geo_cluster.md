## Geo Cluster

The **Geo Cluster** solution is approaching to connect more than one **Cluster** together. **Geo Cluster** solution is flexible and scalable for geographically
dispersed cluster design [Figure 7](../../../img/cluster/multi_group_cluster.png).

![Image](../../../img/cluster/multi_group_cluster.png)
Figure 7


#### Advices

* In case of geographically dispersed **Geo Cluster** clouds, sharing information
between memcached out of locations will not be effective way. To split requests
geographically can be used Split-horizon DNS solution.

### Technologes

* The following Technologies must be used to achieve **Geo Cluster** clustering solution
in one geographical location.

#### DNS Load Balancing

* Distributing workloads across multiple Hardware Load Balancers can be used
with DNS load balancing mechanism. The DNS load balancing mechanism is
not described in current document.

#### OpenDJ

* For OpenDJ - LDAP replication must be used multimaster synchronization. In
order to decrease total number of replication connections, must be used
Stand-alone Replication Servers. The replication topology and suggestions
have been taken from official site of Opendj. LDAP Replication Topology for
**Geo Cluster** clustering in case of 4 SINGLE GROUP connection is
presented in [Figure 8](../../../img/cluster/ldap_multimaster.png).

![Image](../../../img/cluster/ldap_multimaster.png)
Figure 8

* Between Directory Servers and Stand Alone LDAP servers can be used
Hardware Load Balancers.

#### Twemproxy

* In order to decrease total number of memcached connections in single
TwemProxy server, must be used TwemProxy Topology for **Geo Cluster**
clustering [Figure 9](../../../img/cluster/twemproxy_multi.png).

![Image](../../../img/cluster/twemproxy_multi.png)
Figure 9


#### GlusterFS

* In order to decrease total number of replicated connections can be used
stand alone GlusterFS servers. The GlusterFS topology for **Geo Cluster**
clustering [Figure 10](../../../img/cluster/glusterfs_multi.png).

* In case if operating system of Node doesn’t support GlusterFS, can be used
NFS client server connection between Node and GlusterFS server.

* Between GlusterFS servers in different geo-locations the glusterfs georeplication
can be used.

![Image](../../../img/cluster/glusterfs_multi.png)
Figure 10
