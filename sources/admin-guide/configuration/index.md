# Configuration

This section of the documentation includes instructions for configuring
a number of the components of the Gluu Server in order to make the
server fit to your organizational needs.

![Configuration Menu](https://cloud.githubusercontent.com/assets/5271048/7146931/b1875eb0-e2bc-11e4-813b-8ffbfe4ae809.png)

# Organization Configuration

The organization configuration section contains the following options:

- [System Configuration](#system-configuration)
- [SMTP Server Configuration](#smtp-server-configuration)
- [oxTrust Settings](#oxtrust-settings)

## System Configuration

This feature allows the Gluu system administrator to customize and
implement various options such as *Cache Refresh*, *Federation Hosting*,
*SCIM Support* etc.

* _White Pages:_ If the user intends to use the built-in White Pages of
the Gluu Server, it can be enabled from the menu.

* _Federation Hosting:_ The Federation hosting is enabled by default.
However, the creation and management of federations can be complicated.
Gluu offers an additional service called *Federation Registry* that
makes the creation and management of identity federations simple and
easy.

* _Self-Service Password Reset:_ The Self-Service Password Reset is
disabled by default. For Self-Service Password Reset to work the SMTP
Server (see below) should be configured as well. Password reset link for
your Gluu Server should be something like
`https://your.idp.link/identity/person/passwordReminder.htm`.

* _Cache Refresh:_ This is the mechanism which pulls and synchronizes
user information from a remote LDAP/Active Directory with the local LDAP
of the Gluu Server. The Gluu Server administrator needs to provide
sufficient information including username and password before enabling
this option. Before configuring Cache Refresh, you should [read the
overview](../../admin-guide/cache-refresh/index.md). After that you can
learn about the [Cache Refresh GUI tools](#cache-refresh).

* _SCIM Support:_ If the organization already has an identity management
or provisioning system in place, the SCIM protocol can be used to push
and synchronize the existing identity data into the Gluu Server.

* _DNS Server:_ The address to the DNS Server goes in this field.

* _Maximum Log Size:_ This option can be used to mitigate the space
issues within the Gluu Server. The Gluu Server automatically compresses
any log file which is bigger than the defined value in this field.

## SMTP Server Configuration

The Gluu Server can communicate to any SMTP server specified in these
fields. All Gluu Server related informats *(cron daemon/logwatch/crash
reports etc.)* can be pushed to the desired Gluu Server administrator
using this feature.

![SMTP Server Configuration](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_smtp.png)

* _SMTP Host:_ Name of the SMTP host server.

* _From Name:_ Name of the Gluu Server administrator.

* _From Email Address:_ Email address of the Gluu Server administrator.

* _Required Authentication:_ If the SMTP server requires authentication
for every access, then please enable this option by ticking the
according checkbox.

* _SMTP User Name:_ The username for the SMTP server goes in this field.

* _SMTP Password:_ The password for the username from above goes here.
  Both the username and password are used to access the SMTP server.

* _Requires SSL:_ If the SMTP server has SSL availability, then enable
  this option by ticking the checkbox.

* _SMTP Port:_ The SMTP host server port number has to be listed here.

## oxTrust Settings

This feature provides options to add various changes in the Gluu Server
User Interface. The Gluu Server administrator can add title, display
name or even modify both the web user interface color and the logo from
this section.

![Configuration Panel](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_config.png)

* _Title:_ The web user interface title can be modified with this link.

![Web Interface Title](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_config_title.png)

* _Display Name:_ This is the display name for the Gluu Server User
Interface. However, this option is yet to be tested properly.

* _Short Name:_ This feature has not been tested yet.

* _Description:_ This feature is yet to be tested for any change in the IdP.

* _Login Page Message:_ The login page now uses oxAuth Web UI. The
  changes made in this field will not affect the IdP.

* _Welcome Title Text:_ With this feature, the Gluu Server administrator
  can add custom welcome text here.

![Welcome Title Text](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_config_welcome.png)

* _Welcome Page Message:_ This feature can be used to add various
  messages and shortcuts in the welcome message.

![Welcome Page Message](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_config_message.png)

* _Manager Group:_ Gluu Server has a single manager group. The users
that belong to the manager group can use the Web User Interface to
operate the Gluu Server. There is no limit to the number of users that
can belong to the manager group.

* _Organization Logo:_ The organization logo can be uploaded and activated from the configuration menu.

* _Organization Favicon:_ This feature can be used to change the organization favicon, if necessary.

* _Menu Color:_ This is the menu color picker for the Gluu Server User Interface. The color used in the demo screenshots is green.

# Manage Authentication
This section allows the Gluu Server administrator to define how and
where the server should connect to authenticate users. If it is a remote
LDAP/Active Directory server, the values are required. Put the details
of the data source that you are trying to connect with Gluu Server. The
data source can be your back-end Active Directory or your local LDAP
server.

![Manage LDAP Authentication](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_manage_ldap.png)

* _Deactivate:_ This button *Deactivates/Activates* the Gluu Server
  accessibility for authentication.

* _Name:_ This field contains the name of the authentication server.

* _Bind DN:_ The *Username* for the authentication server (local
  LDAP/remote LDAP/remote Active Directory) goes here.

* _Use SSL:_ If the authentication server requires a secured port (i.e.
  636) then activate this option.

* _Max Connections:_ This option defines the total number of
  simultaneous connections allowed for reading local LDAP/remote Active
  Directory/remote LDAP.

* _Server:_ The unique name of the authentication server and port number
  goes here. An example is `auth.company.org:636`.

* _Base DN:_ Add base DNs in this field to allow the Gluu Server to
  connect and search the LDAP server. Every directory tree should be added
  separately using the *Add Base DN* option.

* _Primary Key:_ This field contains the primary key to connect to the
  authentication server. An example is `SAMAccountName/uid/mail`.

* _Local Primary Key:_ This field contains the internal LDAP primary key
  of the Gluu Server. In general, the key is either *uid*, or *mail*.

* _Enabled:_ This checkbox is used to enable the keys that are inserted
  in their respective fields.

* _Change Bind Password:_ This button can be used to assign a password
  to authenticate the *Authentication Server*.

* _Test LDAP Connection:_ Based on the provided information, this button
  checks whether the connection to the authentication server works fine.
  The scan runs in real time, and it is advised to use it for the Gluu
  Server administrators.

## Default Authentication Method

This option allows the Gluu Server administrator to select the default
authentication mode and level for person authentication. Both are set to
"Default" until additional authentication mechanisms are enabled via
[custom scripts](#manage-custom-scripts).

![Default Authentication Method](https://cloud.githubusercontent.com/assets/5271048/7147219/f72536f2-e2be-11e4-8259-a52ce0051b12.png)

# Manage Custom Scripts

The latest edition of the Gluu Server introduced a new configuration
section called _Manage Custom Scripts_. This is a single place where the
server administrator can manage and implement interception scripts to
customize the behavior of the Gluu Server.

![Custom Authentication Scritp](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_auth_custom.png)

Currently, there are interception scripts to customize the following
functionalities:

- [Application Session Management](../../reference/interception-scripts/index.md#application-session-management)
- [Authentication](../../reference/interception-scripts/index.md#authentication)
- [Authorization](../../reference/interception-scripts/index.md#authorization)
- [Cache Refresh](../../reference/interception-scripts/index.md#cache-refresh)
- [Client Registration](../../reference/interception-scripts/index.md#client-registration)
- [ID Generation](../../reference/interception-scripts/index.md#id-generation)
- [Update User](../../reference/interception-scripts/index.md#update-user)
- [User Registration](../../reference/interception-scripts/index.md#user-registration)

Due to the significance of custom interception scripts in the Gluu
Server, we have dedicated a separate folder within the docs to more
comprehensively go over [how to use
them](../../reference/interception-scripts/index.md).

# Manage Registration

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/ManageRegistrationStart.jpg?raw=true)

From the Manage Registration interface, the Gluu Server administrator
can customize the self-registration workflow. Each option will be
covered individually below.

There are other ways of creating accounts within the Gluu Server. This
includes SCIM, Cache Refresh, Manual User Management, and Automatic
Enrollment as part of custom authentication (Inbound SAML). Except Cache
Refresh, which is covered [here](#cache-refresh), those additional
methods are covered within the [User
Management](../user-management/index.md) portion of the documentation.

## Activate Invitation Link
When active, the Invitation Links feature allows the server
administrator to control who can register an account by issuing a unique
registration link and sending it to the desired new users.

Any person who knows the link will be able to register an account (as
long as the link is not expired). Expired links are deleted according to
"invite codes expiration process" policy, together with any unconfirmed
accounts if said link is moderated.

As an option, Invitation links can be set to be "moderated", and a
number of moderators can be assigned to the link. The moderators come
from the list of registered users. In this case any newly registered
user who uses this link will not be immediately able to use his account
until his registration is approved by the moderator of his link.

Upon activating Invitation Links Management within the interface, you
will be presented with the following option:

- __Run invite codes expiration process every__: This feature allows you
  to configure how often oxTrust will purge expired invitation links
  from the system.
- __Enable registration without invitation__: Allows public registration
  even when Invitation Links are used.
- __Enable account expiration__: Allows the admin to configure an
  expiration policy for registered accounts.
- __Accounts expire after__: Provides an interface to set the account
  expiration period and how often to run the expiration process. After
  this period registered accounts will be subject to invalidation during
  the next account expiration process run.

## Disable captcha for registration form

Upon activating this feature, the default captcha will be removed from
the registration form.

## Configure Registration Form Attributes

By default, there are a limited number of fields present in the
self-registration form. If more attributes are needed they can be added
in this section of Registration Management. Once you activate this
feature, just start typing the attribute name in the Attributes Filter,
add desired attributes to the right column, and click "Update" to
complete this step.

# Attributes

An *Active* attribute list can be seen from the Configuration >
Attributes section.

![Attribute Menu](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_attribute_menu.png)

The Gluu Server has a large LDAP tree which includes all standard
attributes. It is not necessary for all of them to be *Active*. The
active LDAP trees can be sorted using the *Show only Active Attributes*
link.

![Show Active Attribute](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_attribute_show.png)

The Gluu Server administrator can make modifications, such as changing
the state of an attribute to active/inactive by clicking on the
according attribute.

![Attributes](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_attribute_attribute.png)

Additional attributes can be added from the Gluu Server GUI, oxTrust, by
clicking on the **Add Attribute** button. The following screen will
appear:

![Add Attribute Screen](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_attribute_add.png)

* _Name:_ This field defines the name of the custom attribute which has
  to be unique in the Gluu Server LDAP tree.

* _SAML1 URI:_ This field contains the SAML1 uri for the custom attribute.

* _SAML2 URI:_ This field contains the SAML2 uri for the custom attribute.

* _Display Name:_ This display name can be anything that is human readable.

* _Type:_ The attribute type should be selected from the drop-down menu.
  There are four attribute types supported by the Gluu Server:

  1. text
  2. numeric
  3. photo
  4. date

* _Edit Type:_ This field defines the user who has access to edit the
  specific attribute.

* _View Type:_ This field defines the user who can view this attribute.

* _Privacy Level:_ Please select the desired privacy level from the
  drop-down menu. The privacy level has a specific range of 1 to 5.

* _Multivalued:_ Please select multivalue in this field if the attribute
  contains more than one value.

* _SCIM Attributes:_ If the attribute is a part of SCIM architecture
  select `true` from the list of options.

* _Description:_ This contains a few words to describe the attribute.

* _Status:_ The status, when selected active, will release and publish
  the attribute in IdP.

# Cache Refresh
Cache Refresh was designed by Gluu to enable an organization to sync a backend LDAP like Active Directory with the Gluu Server. Cache Refresh is a big topic, and because so it is detailed under a separate [Cache Refresh Page](http://www.gluu.org/docs/admin-guide/cache-refresh/).

# Configure Log Viewer
The Gluu Server has the facility to read log files using the GUI. The
log file can be displayed from the Web UI with a few clicks of the
mouse. This feature can be enabled from the configuration menu clicking
**Configuration --> Configure Log Viewer**.

![Configure Log Viewer](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_logviewer.png)

Clicking on **Add log template** will bring two boxes. The box on the
left contains the name/description of the log file, and the right box
contains the path of the log file such as `/opt/tomcat/logs/demo.log`.

# View Log File

The log files configured in the earlier section can be viewed using the
**View log file** feature. This feature can be accessed through the
configuration menu using **Configuration --> View Log File**.

![View Log File](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_view_log.png)

The **Display last lines count** field contains the lines that will be
displayed in the Web GUI. If the field contains the value **400**, then
the Gluu Server will show the last 400 lines of the log in the GUI. The
screenshot below shows an example.

![Log file tail](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_view_logtail.png)

# Status

![Status](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_status.png)

The Status section provides a high level overview of server metrics. The
included values are straightforward and shouldn't require any further
explanation.

