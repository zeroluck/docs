# Gluu Server Community Edition (CE) RHEL Configuration Guide

`chroot` is a pre-Docker OS level container technology. Like Docker, the
`chroot` distribution includes a full Linux distribution. As a file
system based "jail", when you login to the Gluu Server from the host
Linux system, the `/` directory in the Gluu Server is actually
`/home/gluu-server24` on the host.

This strategy has its pluses and minuses. In certain circumstances,
there are ways for a hacker to “break out of the jail”, and escalate to
the host file system. (You do not want to make any file system links from
the chroot'd server to the main host!) The benefit is the ease of
deployment (Docker is not required...). We wanted a simple package that
people could install and uninstall quickly.

To report issues or provide feedback about the installation process,
please use
[GitHub](https://github.com/GluuFederation/community-edition-setup/issues)
or register for an account on
[https://support.gluu.org](https://support.gluu.org).

## System Requirements

The Gluu Server Community Edition should be deployed on a VM with:

* RHEL 6.5
* 2 cpu units and at least 4GB of physical memory (more is always better, though)

## Available Components

Please review the [deployment guide](./index.md) for a list of available
components during the installation.

## Installing GLUU Server with yum (RHEL 6):

These are the single steps:

```
# wget http://repo.gluu.org/rhel/Gluu.repo -O /etc/yum.repos.d/Gluu.repo
# wget http://repo.gluu.org/rhel/RPM-GPG-KEY-GLUU -O /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU
# rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-GLUU
# yum clean all
# yum install gluu-server24
```

## Start Gluu Server: 

To start the Gluu Server, run the following command:

```
# service gluu-server24 start
```

## Gluu Server Configuration

To perform the final configuration of the Gluu Server you need to
provide some instance specific information, like the DNS hostname, and
the information required to generate the X.509 certificate. Post rpm
installation, run the Gluu Server `setup.py` to complete the
installation. For both help and the latest installation options see
either [setup.py help](./setup_py.md), or run `./setup.py -h`.

* Login to the Gluu Server container:

```
# service gluu-server24 login
```

* Run "setup" script to perform the final installation:

```
# cd /install/community-edition-setup/
# ./setup.py
```

After the successful execution of the setup script, point your browser
to the uri `https://hostname`. Login with the default user name “admin”,
and the LDAP password printed back in the confirmation (also contained
in `setup.properties.last`). The full LDIF for the admin user contains
the file `/opt/opendj/ldif/people.ldif`.

Make sure you remove or encrypt `setup.properties.last`. It has the
clear text passwords for everything: LDAP, admin user, keystores, and
3DES salt.

If something goes wrong, check `setup.log` for a detailed step-by-step
of the installation. As an alternative you may check the file
`setup_errors.log` to just see the errors (or stderr output from the
scripts).

<!--
If you want to script the installation of the Gluu Server, user the `-f`
option or just save the properties file as `setup.properties` and it
will be automatically detected. Also use the `-n` option to suppress the
interactive confirmation to proceed. For example, to re-run the last
installation:

`./setup.py -n -f setup.properties.last`
-->

## Starting and Stopping the Gluu Server

You can start the Gluu Server with this command:

```
# service gluu-server24 start
```

You can stop the Gluu Server with this command:

```
# service gluu-server24 stop
```

## Login to the chroot environment

To switch to the Gluu Server chroot environment invoke the following
command:

```
# service gluu-server24 login
```

## Gluu Server Uninstallation

In order to uninstall the Gluu Server you exit from the chroot
environment to main Linux, first. Next, remove the Gluu Server package,
and the according Gluu yum repository. To do so invoke the following
commands:

```
# service gluu-server24 stop
# yum remove gluu-server24
# rm -f -r /opt/gluu-server24.rpm.saved
```

<!--
or 

`# rpm -e Gluu-Server-Repo-2.0-0.el6.x86_64`
-->

## Troubleshooting
Please see our [Cloud Deployment FAQ](../../faq/cloud-faq.md) for cloud
specific notes and our [Troubleshooting
FAQ](../../faq/troubleshooting.md) for solutions to common issues we
know about.

## Support
Gluu offers both community and VIP support. Anyone can browse and open
tickets on our [support portal](http://support.gluu.org). For private
support, expedited assistance, and strategic consultations, please view
[our pricing](http://gluu.org/pricing) and [schedule a meeting with
us](http://gluu.org/booking) to discuss VIP support options.

