[TOC]
# Connectivity Issues?
## DNS names not resolving!
It is possible that even after configuring everything there is a `DNS` resolve error in Gluu Server.
The reason is the `DNS` used inside the chroot container; the `dns` used by the container is the Google DNS servers 
and the `DNS` for the host OS is not used. Therefore to fix this issue:

- Change the DNS inside the container by editing the `/etc/resolv.conf` file and adding the DNS used by your organization
# Locked Out?
## Forgot the admin password! 

Oh no, its been a few days since you booted your test Gluu Server, and
you can't remember the admin password. No worries, the Gluu Server
stores this information in the file
`/install/community-edition-setup/setup.properties.last` under the
property `ldapPass`. Retrieve the data using this command:

```
# grep ldapPass= /install/community-edition-setup/*.last
```

Of course for a production installation, you should remove this file.
You wouldn't want to have your admin password sitting on the filesystem!

## Add admin for Gluu server

Please follow these steps to restore your Gluu admin account (you will
probably need to substitute actual port, bind names and hostnames with
ones used by your installation):

1) Login into Gluu's chroot environment with the command below:

```
# service gluu-server login
```

2) Run this command:

```
#/opt/opendj/bin/ldapsearch -p 1389 -D 'cn=directory manager' -w 'YOUR_BIND_PASSWORD' -b o=gluu gluuGroupType=gluuManagerGroup 1.1
```

and remember the displayed dn of the Gluu Manager Group for future use.

3) Run this command:

```
# /opt/opendj/bin/ldapsearch -p 1389 -D 'cn=directory manager' -w 'YOUR_BIND_PASSWORD' -b o=gluu ou=people 1.1
```

and remember the displayed dn of the People ou for future use.

4) While staying in the chrooted environment, create the file
`~/add_user.ldif` using your favorite text editor, and copy the
following lines to it:

```
dn: inum=tempadmin,ou=people,o=@!F9CC.D762.4778.1032!0001!2C72.BB87,o=gluu
changetype: add
uid: tempadmin
objectClass: gluuPerson
objectClass: top
givenName: tempadmin
sn: tempadmin
inum: tempadmin
gluuStatus: active
userPassword: 1q2w3e
```

Please note the string's segment marked with bold: you will have to
substitute it with dn of your own People ou which you've acquired in
step 3).

5) Run this command:

```
# /opt/opendj/bin/ldapmodify -p 1389 -D 'cn=directory manager' -w 'YOUR_BIND_PASSWORD' -f ~/add_user.ldif
```

This will create new user tempadmin with attributes provided via file
created in step 4).

6) Now create file `add_2_group.ldif` in your home ("~/") directory and
copy the following lines to it:

```
dn: inum=@!F9CC.D762.4778.1032!0001!2C72.BB87!0003!60B7,ou=groups,o=@!f9cc.d762.4778.1032!0001!2c72.bb87,o=gluu
changetype: modify
add: member
member: inum=tempadmin,ou=people,o=@!f9cc.d762.4778.1032!0001!2c72.bb87,o=gluu
```

Again, please note the strings' segment marked with bold: you will have
to substitute contents of the "dn:" string with dn of your own Gluu
Manager Group which you've acquired in step 2), and for "member:" string
you will have to use the dn of tempadmin user (the one you already
specified in the 1st line of the file in step 4).

7) Run this command:

```
# /opt/opendj/bin/ldapmodify -p 1389 -D 'cn=directory manager' -w 'YOUR_BIND_PASSWORD' -f ~/add_2_group.ldif
```

This will add tempadmin user to the IdP managers group and you can then
login and assign another user to act as admin.

## Revert Authentication Method
It is not unlikely that you will lock yourself out of Gluu Server while testing the authentication script, if there is any problem in it. In such a case the following method can be used to revert back the older authentication method.

1. Run the following command to collect the `inum` for the Gluu Server installation.

`/opt/opendj/bin/ldapsearch -h localhost -p 1389 -D "cn=directory 
manager" -j ~/.pw -b "ou=appliances,o=gluu" -s one "objectclass=*" 
oxAuthenticationMode`

2. Create a `LDIF` file with the contents below:

```
dn: inum=@!1E3B.F133.14FA.5062!0002!4B66.CF9C,ou=appliances,o=gluu
changetype: modify
replace: oxAuthenticationMode
oxAuthenticationMode: internal
```

As an example, we shall call this file `changeAuth.ldif`.

**Note:** Replace the `inum` from the example above with the `inum` of the Gluu Server from the `ldapsearch` command.


3. Replace the the authentication mode using `ldapmodify` command.

`/opt/opendj/bin/ldapmodify -p 1389 -D 'cn=directory manager' -w 'YOUR_BIND_PASSWORD' -f ~/changeAuth.ldif
