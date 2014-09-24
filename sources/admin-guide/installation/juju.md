# Installing Gluu Server in juju
**note: if you are using trusty, replace all precise to trusty in this doc**

## What you need?
- ubuntu 12.04 LTS (precise) or 14.04 LTS (trusty)
- a basic juju environment 
([getting started guide](https://juju.ubuntu.com/docs/getting-started.html))

## Get Gluu server charms
TODO (git or svn or charmstore or all ???)

## Our goal
![image1][jujugui]

## Create local charm store

make directory:

    $ mkdir -p localcharms/precise

Sync to localcharms from local svn copy:
 
    $ rsync -r -l --exclude=.svn svn/gluu-server localcharms/precise
    $ rsync -r -l --exclude=.svn svn/gluu-opendj localcharms/precise
    $ rsync -r -l --exclude=.svn svn/gluu-apache localcharms/precise

Or sync to localcharms from local git copy:

    $ rsync -r -l --exclude=.git git/gluu-server localcharms/precise
    $ rsync -r -l --exclude=.git git/gluu-opendj localcharms/precise
    $ rsync -r -l --exclude=.git git/gluu-apache localcharms/precise

## Deploy

To deploy from local charm store

    $ juju deploy --repository=<path of localcharms> local:precise/gluu-opendj
    $ juju deploy --repository=<path of localcharms> local:precise/gluu-server
    $ juju deploy --repository=<path of localcharms> local:precise/gluu-apache

## Make relation

To make relation between charms run this commands

    juju add-relation gluu-opendj gluu-server
    juju add-relation gluu-server gluu-apache

## Test installation

get gluu charm service ip using command:

    $ juju status

then hit the browser with this url https://{gluu service ip}/oxTrust
and to test gluu-apache charm. https://{gluu-apache service ip}/ox
**username: admin and password: passpass**


[jujugui]: /img/juju/relation-view.png "juju-gui screen"

