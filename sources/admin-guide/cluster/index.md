# Cluster Sulution For GLUU IDP Sysytem

## Objectives

The purpose of The technical design is to confirm that the Supplier has identified all the
technical and technological requirements of the Purchaser and has defined the solutions
that meet these requirements.

## Scope

This document presents a conceptual design of the System and includes all technical and
technological system components required to implement the requirements of the GLUU
Inc.
The document does not include other components of the system: documentation,
procedures, instructions, people operating the System.
The technical project will be done in two steps:

* Conceptual design – document based on the GLUU Inc. requirements defines the
basic concepts and solutions by which the system will be built, identifies the scope
of limitations and exclusions; the approval of the GLUU Inc. is necessary to start
the appropriate technical design,

* Technical design – updated conceptual design document with detailed technical
solutions
After the implementation the technical design will be updated and will be as-built
document of the project.

## Glossary

* IDP - Identity Provider
* HA - High Availability
* IDS – Intrusion Detection System
* IPS – Intrusion Prevention System

## Introduction

The purpose of the Document is to describe cluster solution for GLUU Inc. Cluster solution
should be cost effective, flexible, should provide geographic redundancy and scalability,
solution should not impact on main requirements of security in order to it will be
implemented in datacenters where security requirements are high.

## Network And Sceurity Design

The Document doesn’t contain network physical connection solutions, it is important
before cluster implementation to solve HA in network level. The network HA can be
various it depends on the place of installation and special design. Protecting the internal
network from threats can be implemented by firewalls subsystems and IPS / IDS. The
connections between data centers can be implemented via the Internet through the
encrypted or protected connections.
Some data centers have special security requirements. In case of all in one installation (all
components running on single node) it can impact the security requirement “one primary
function per server” to cover this type of requirement and do not lose cost effectiveness,
the application components will be installed in one node but under different chroot
environments. It can be divided in following environments (Apache, Shibboleth, Tomcat,
Ldap, *_Mysql_*).

## Standart Software For The System

* The following standard software is used in the System:
* OpenDJ-2.6.x
* apache-tomcat-7.0.x
* MySQL 5.x (According agreements this component must be removed)
* Shibd
* Apache
* Java SE Development Kit 7 or later
* TwemProxy
* Memcached
* GlusterFS

## Cluster Description

- [Single Group](./single_group.md)
- [Multi Group](./multi_group.md)