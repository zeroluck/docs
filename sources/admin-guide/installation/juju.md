# Installing Gluu Server in juju
**note: if you are using trusty, replace all precise to trusty in this doc**

## What you need?
- ubuntu 12.04 LTS (precise) or 14.04 LTS (trusty)
- a basic juju environment 
([getting started guide](https://juju.ubuntu.com/docs/getting-started.html))

## Get Gluu server charms
TODO (git or svn or charmstore or all ???)

## Create local charm store

make directory:

    $ mkdir -p localcharms/precise

Sync to localcharms from local svn copy:
 
    $ rsync -r -l --exclude=.svn svn/gluu localcharms/precise
    $ rsync -r -l --exclude=.svn svn/gluuldap localcharms/precise
    $ rsync -r -l --exclude=.svn svn/gluu-apache localcharms/precise

Or sync to localcharms from local git copy:

    $ rsync -r -l --exclude=.git git/gluu localcharms/precise
    $ rsync -r -l --exclude=.git git/gluuldap localcharms/precise
    $ rsync -r -l --exclude=.git git/gluu-apache localcharms/precise

Download war file:

put oxauth and oxTrust war files in gluu/resources. Make sure to rename war 
files as oxauth.war and oxTrust.war

    http://ox.gluu.org/maven/org/xdi/oxauth-server/
    http://ox.gluu.org/maven/org/xdi/oxTrust/

## Deploy

To deploy from local charm store

    $ juju deploy --repository=<path of localcharms> local:precise/gluuldap
    $ juju deploy --repository=<path of localcharms> local:precise/gluu
    $ juju deploy --repository=<path of localcharms> local:precise/gluu-apache

## Make relation

To make relation between charms run this commands

    juju add-relation gluu:oxserver gluuldap:gluuserver
    juju add-relation gluuldap:opendjserver gluu:ldapserver
    juju add-relation gluu gluu-apache

## Test installation

get gluu charm service ip using command:

    $ juju status

then hit the browser with this url https://{gluu service ip}/oxTrust
and to test gluu-apache charm. https://{gluu-apache service ip}/ox
**username: admin and password: passpass**
