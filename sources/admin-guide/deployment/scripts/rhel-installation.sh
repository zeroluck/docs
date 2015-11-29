#!/bin/bash

# --------------------------------------------------
# Gluu Server installation script for RHEL 6
#
# 2015 Frank Hofmann <frank.hofmann@efho.de>
# Released under GNU Public License (GPL)
# derived from official Gluu Server documentation
# --------------------------------------------------

# set -x

# retrieve Gluu repository information
wget http://repo.gluu.org/rhel/Gluu.repo -O /etc/yum.repos.d/Gluu.repo

# retrieve the according Gluu repo GPG key
wget http://repo.gluu.org/rhel/RPM-GPG-KEY-GLUU -O /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU

# add the Gluu repo GPG key to the local GPG key list
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU

# clear the local yum package cache
yum clean all

# retrieve and install the Gluu Server 2.4 package
yum install gluu-server24

