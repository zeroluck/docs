**Table of Contents** 

- [Configuration](#configuration)	
- [Organization Configuration](#organization-configuration)	
	- [System Configuration](#system-configuration)	
	- [Manage Email Addresses](#manage-email-addresses)	
	- [SMTP Server Configuration](#smtp-server-configuration)	
	- [oxTrust Configuration](#oxtrust-configuration)	
- [Manage Authentication](#manage-authentication)	
	- [Default Authentication Method](#default-authentication-method)	
- [Manage Custom Scripts](#manage-custom-scripts)	
- [Manage Registration](#manage-registration)	
	- [Activate Invitation Link](#activate-invitation-link)	
	- [Disable Captcha for Registration Form](#disable-captcha-for-registration-form)	
	- [Configure Registration Form Attributes](#configure-registration-form-attributes) 	
- [Attributes](#attributes)	
- [Cache Refresh Directory Integration](#cache-refresh)	
	- [Customer Backend Key/Attributes](#customer-backend-key-and-attributes)	
	- [Source Backend LDAP Servers](#source-backend-ldap-servers)	
	- [Inum LDAP Server](#inum-ldap-server)	
	- [Attributes Mapping](#attributes-mapping)	
	- [Customizing Behavior](#customizing-behavior)	
- [Configure Log Viewer](#configure-log-viewer)	
- [View Log File](#view-log-file)		
- [Status](#status)	

#Configuration
This section of the documentation includes instructions for configuring a number of the components of the Gluu Server in order to make the server fit for your organizational needs. 

![Configuration Menu](https://cloud.githubusercontent.com/assets/5271048/7146931/b1875eb0-e2bc-11e4-813b-8ffbfe4ae809.png)

# Organization Configuration
The organization configuration section contains the following options:    
- [System Configuration](#system-configuration)		
- [Manage Email Addresses](#manage-email-addresses)		
- [SMTP Server Configuration](#smtp-server-configuration)		
- [oxTrust Configuration](#oxtrust-configuration)		

## System Configuration
This feature allows the Gluu system administrator to customize and implement various options such as *Cache Refresh*, *Federation Hosting*, *SCIM Support* etc. 

![System Configuration](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_system.png)

* _White Pages:_ If the user intends to use the built-in White Pages of the Gluu Server, it can be enabled from the menu.

* _Federation Hosting:_ The Federation hosting is enabled by default. However, the creation and management of federations can be complicated. Gluu offers an additional service called *Federation Registry* that makes the creation and management of identity federations simple and easy. 

* _Self-Service Password Reset:_ The Self-Service Password Reset is disabled by default. For Self-Service Password Reset to work SMTP Server(see below) should be configured as well. Password reset link for your Gluu server should be something like: "https://your.idp.link/identity/person/passwordReminder.htm"

* _Cache Refresh:_ This is the mechanism which pulls and synchonises user information from a remote LDAP/Active Directory with the local LDAP of Gluu server. The Gluu server administrator needs to provide sufficient information including username and password before enabling this option. Before configuring Cache Refresh, you should read the [overview here](../../articles/cache-refresh.md). After reading the overview, you c an learn about the Cache Refresh GUI tools [here](#cache-refresh).

* _SCIM Support:_ If the organization already has an identity management or provisioning system in place, the SCIM protocol can be used to push and synchronise the existing identity data into the Gluu Server.

* _DNS Server:_ The address to the DNS Server goes in this field.

* _Maximum Log Size:_ This option can be used to mitigate the space issues within the Gluu Server. The Gluu Server automatically zips any log file which is bigger than the defined value in this field. 

## Manage Email Addresses
This feature allows the Gluu Server Administrator to manage notifications for the IdP.

![Manage Email Addresses](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_email.png)

* _Email for Centreon:_ Centreon is the server monitoring system used by Gluu. The email address in this field shall recieve various notifications from Centreon.

* _Email for Jira:_ The customers are not provided the jira access, and it will be removed from oxTrust soon. Please visit [Gluu Support](https://support.gluu.org) for customer support.

* _Email for Billing:_ The email address in this field will receive the billing invoices from Gluu.

* _Email for Privacy:_ This email address will receive news and updates about the privacy related matters of Gluu.

* _Email for SVN:_ The IdP related configuration files are are saved in the [Gluu SVN](https://svn.gluu.info). Configuration files are generally saved under */opt/* and */etc/httpd/*. The email address will get access to the checked-in files section of the corresponding IdP.

## SMTP Server Configuration
The Gluu server can communicate to any SMTP server specified in these fields. All Gluu Server related informats *(cron daemon/logwatch/crash reports etc.)* can be pushed to the desired Gluu Server Administrator using this feature.

![SMTP Server Configuration](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_smtp.png)

* _SMTP Host:_ Name of the SMTP Host server.

* _From Name:_ Name of the Gluu Server Administrator.

* _From Email Address:_ Email Address of the Gluu Server Administrator.

* _Required Authentication:_ If the SMTP server requires authentication every access, then please enable this option by ticking the checkbox.

* _SMTP User Name:_ The username for the SMTP server goes in this field.

* _SMTP Password:_ The password for the username above goes here. The username and password are used to access the SMTP server.

* _Requires SSL:_ If the SMTP Server has SSL availability, then enable this option by ticking the checkbox.

* _SMTP Port:_ The SMTP Host server port number must be listed here.

## oxTrust Configuration
This feature provides options to add various changes in the Gluu Server User Interface. Gluu Server Administrator can add Title, Display Name or evern modify the Web User Interface color and logo from this section.

![Configuration Panel](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_config.png)

* _Title:_ The Web User Interface title can be modified with this link.

![Web Interface Title](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_config_title.png)

* _Display Name:_ This is the display name for the Gluu Server User Interface. However, this option is yet to be tested properly.

* _Short Name:_ This feature has not been tested yet.

* _Description:_ This feature is yet to be tested for any change in the IdP.

* _Login Page Message:_ The login page now uses oxAuth Web UI and the changes made in this field will not affect the IdP.

* _Welcome Title Text:_ The Gluu Server Administrator can add custom welcome text tile with this feature.

![Welcome Title Text](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_config_welcome.png)

* _Welcome Page Message:_ This feature can be used to add various messages and shortcuts in the welcome message.

![Welcome Page Message](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_config_message.png)

* _Manager Group:_ Gluu server has a single manager group. The users under the manager group can use the Web User Interface to operate the Gluu Server. There is no limit to the users that can be added to the manager group.

* _Organization Logo:_ The orgaziation logo can be uploaded and activated from the configuration menu.

* _Organization Favicon:_ This feature can be used to change the organization favicon, if necessary.

* _Menu Color:_ This is the menu color picker for the Gluu Server User Interface. The color used in the demo screenshots is Green.

# Manage Authentication
This section allows the Gluu Server Administrator to define how and where the server should connect to authenticate users. If it is a remote LDAP/Active Directory server, the values are required. The values can also be used if the organization is using the local LDAP for authentication. 

![Manage LDAP Authentication](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_manage_ldap.png)

* _Deactivate:_ This button *Deactivates/Activates* the Gluu Server accessibility for authentication.

* _Name:_ This field contains the name of the authentication server.

* _Bind DN:_ The *Username* for the authentication server (local LDAP/remote LDAP/remote Active Directory) goes here.

* _Use SSL:_ If the authentication server requires a secured port (i.e. 636) then this option should be activated using the checkbox.

* _Max Connections:_ This option can be used to define the total number of simultaneous connections allowed for reading local LDAP/remote Active Directory/remote LDAP.

* _Server:_ The unique name of the authentication server and port number (i.e. auth.company.org:636) goes here.

* _Base DN:_ Add base DNs in this field to allow the Gluu Server to connect and search the LDAP server. Every directory tree should be added separately using the *Add Base DN* option.

* _Primary Key:_ This field contains the primary key to connect to the authentication server (i.e. SAMAccountName/uid/mail etc).

* _Local Primary Key:_ This field contains the internal LDAP primary key of the Gluu Server. Gererally the key is either the *uid* or the *mail*.

* _Enabled:_ This checkbos is used to enable the keys that are inserted in their respective fields.

* _Change Bind Password:_ This button can be used to assign a password to authenticate the *Authentication Server*.

* _Test LDAP Connection:_ This button checks whether the provided information can connect to the authentication server. The scan is real time and it is advised to use it for the Gluu Server Administrators.

## Default Authentication Method
This allows the Gluu Server Administrator to select the default authentication mode and level for person authentication. Both are set to "Default" until additional authentication mechanisms are enabled via [custom scripts](#manage-custom-scripts). 

![Default Authentication Method](https://cloud.githubusercontent.com/assets/5271048/7147219/f72536f2-e2be-11e4-8259-a52ce0051b12.png)

# Manage Custom Scripts  
  
The latest edition of the Gluu Server introduced a new Configuration section called _Manage Custom Scripts_. This is a single place where the server administrator can manage and implement interception scripts to customize the behavior of the Gluu Server. 

![Cuscom Authentication Scritp](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_auth_custom.png)

Currently, there are interception scripts to customize the following functionalities:      

- [Application Session Management](../../reference/interception-scripts/index.md#application-session-management)    	
- [Authentication](../../reference/interception-scripts/index.md#authentication)	 
- [Authorization](../../reference/interception-scripts/index.md#authorization)	
- [Cache Refresh](../../reference/interception-scripts/index.md#cache-refresh)	
- [Client Registration](../../reference/interception-scripts/index.md#client-registration)	
- [ID Generation](../../reference/interception-scripts/index.md#id-generation)	
- [Update User](../../reference/interception-scripts/index.md#update-user)	
- [User Registration](../../reference/interception-scripts/index.md#user-registration)	

Due to the significance of custom interception scripts in the Gluu Server, we have dedicated a separate folder within the docs to more comprehensivley go over [how to use them](../../reference/interception-scripts/index.md). 

# Manage Registration
![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/ManageRegistrationStart.jpg?raw=true)

From the Manage Registration interface, the Gluu Server admin can customize the self-registration workflow. Each option will be covered individually below.

There are other ways of creating accounts within the Gluu Server, including: SCIM, Cache Refresh, Manual User Management, and Automatic Enrollment as part of custom authentication (Inbound SAML). Except Cache Refresh, which is covered [here](#cache-refresh), those additonal methods are covered within the [User Management](../user-management/index.md) portion of the documentation.

## Activate Invitation Link
When active, the Invitation Links feature allows the server admin to control who can register an account by issuing a unique registration link and sending it to the desired new users.

Any person who knows the link will be able to register an account (as long as the link is not expired). Expired Links are deleted according to "invite codes expiration process" policy, together with any unconfirmed accounts if said link is moderated.

Invitation Links can be optionally made "moderated" and a number of moderators can be assigned to the link from among registered users. In this case any newly registered users who used this link will not be immediately able to use their account until their registration is approved by the moderator of their link.

Upon activating Invitation Links Management within the interface, you will be presented with the following option:    

- **Run invite codes expiration process every**: This feature allows you to configure how often oxTrust will purge expired invitation links from the system. 
- **Enable registration without invitation**: Allows public registration even when Invitation Links are used.
- **Enable account expiration**: Allows the admin to configure an expiration policy for registered accounts. 
	- **Accounts expire after**: Provides interface to set account expiration period and how often to run the expiration process. After this period registered accounts will be subject to invalidation during the next account expiration process run.

## Disable Captcha for registration form
Upon activating this feature, the default Captcha will be removed from the registration form. 

## Configure Registration Form Attributes
By default, there are a limited number of fields present in the self-registration form. If more attributes are needed they can be added in this section of Registration Management. Once you activate this feature, just start typing the attribute name in the Attributes Filter and then add desired attributes to the right column and click "Update". 

# Attributes
An *Active* attribute list can be seen from the Configuration > Attributes section.

![Attribute Menu](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_attribute_menu.png)

The Gluu Server has a large LDAP tree which includes all standard attributes. It is not necessary for all of them to be *Active*. The active LDAP trees can be sorted using the *Show only Active Attributes* link.

![Show Active Attribute](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_attribute_show.png)

The Gluu Server Administrator can make changes, such as changing the status to active/inactive, to an attribute after clicking on it.

![Attributes](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_attribute_attribute.png)

Additional attributes can be added from the Gluu Server GUI, oxTrust, by clicking the **Add Attribute** button. On clicking the **Add Attribute** button, the following screen shall appear.

![Add Attriute Screen](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_attribute_add.png)

* _Name:_ This field defines the name of the custom attribute which must be unique in the Gluu Server LDAP tree.

* _SAML1 URI:_ This field contains the SAML1 URI for the custom attribute.

* _SAML2 URI:_ This field contains the SAML2 URI for the custom attribute.

* _Display Name:_ Thi display name can be anything that is human readable.

* _Type:_ The attribute type should be selected from the drop-down meny. There are four attribute types supported by Gluu:    
  1. Text	
  2. Numeric	
  3. Photo	
  4. Date	

* _Edit Type:_ This field defines the user who has access to edit the specific attribute.

* _View Type:_ This field defines the user who can view thie attribute.

* _Privacy Level:_ Please select the desired privacy level from the drop-down menu. The privacy level has a specific range of 1 to 5.

* _Multivalued:_ Please select miltivalue in this field if the attribute contains more than one value.

* _SCIM Attributes:_ If the attribute is a part of SCIM architecture select true.

* _Description:_ This contains a few words to describe the attribute.

* _Status:_ The status, when selected active, will release and publish the attribute in IdPThe status, when selected active, will release and publish the attribute in IdP.

# Cache Refresh

**Cache Refresh** was built by Gluu to pull user information from a backend customer Active Directory/LDAP Server. Cache refresh dynamically synchronises user information from the backend data source of the customer to the Gluu Server in order to maximize performance. This feature is sensitive in nature and any incorrect action may result in loss of data within the Gluu Server. Before configuring Cache Refresh, you should read the [overview here](../../articles/cache-refresh.md). For any questions relating to Cache Refresh functionality, you can seek assistance from [Gluu Support](http://support.gluu.org). 

![Cache Refresh Menu](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_menu.png)

* _Last Run:_ The date and time of the latest cache refresh cycle completion is shown in the last run.

* _Updates at the Last Run:_ This shows the total number of users who have been updated in the last Cache Refresh cycle. For example an user who has any of his attribute updated will show up here.

* _Problem at the Last Run:_ This shows the number of users who have been rejected by the Gluu Server during the update. If there are any rejections, please contact Gluu Support for clarification and help.

![Last Run](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_lastrun.png)

## Customer Backend Key and Attributes
![Customer Backend Key](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_backend.png)

* _Key Attribute:_ This is the unique key attribute of backend Active Directory/LDAP Server such as sAMAccountname for any Active Directory.

* _Object Class:_ This contains the Object Classes of the backend Active Directory/LDAP which has permission to talk to Gluu Server Cache Refresh such as person, organizationalPerson, user etc.

* _Source Attribute:_ This contains the list of attributes which will be pulled and read by the Gluu Server.

* _Custom LDAP Filter:_ If there is any custom search required, this filtering mechanism can be used such as "sn=*" where the value of this field ensures that every user must contain an attribute named SN.

## Source Backend LDAP Servers
![Source Backend](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_sourcebackend.png)

This section allows the Gluu Server to connect to the backend Active Directory/LDAP server of the organization.

* _Name:_ Please input **source** as the value.

* _Use Anonymous Bind:_ Some customers do now allow username/password connections to their backend server. Enable this option if this applies to your organization.

* _Bind DN:_ This contains the username to connect to the backend server. You need to use full DN here. As for example, _cn=gluu,dc=company,dc=org_

* _Use SSL:_ Use this feature if the backend server allows SSL connectivity.

* _Max Connections:_ This value defines the maximum number of connection that are allowed to read the backend Active Directory/LDAP server. It is recommended to keep the value 2 or three.

* _Server:_ This contains the backend Active Directory/LDAP server hostname with port i.e. backend.organization.com:389. If organization has a failover server, click **Add Server** and more hostnames with port.

* _Base DN:_ This contains the location of the Active Directory/LDAP tree from where the Gluu Server shall read the user informaiton.

* _Enabled:_ This checkbox is to save and push the changes and only to be used when the server administrator has entered all the required values.

* _Change Bind Password:_ This can be used for a new password or to change any existing password.

If any organization has multiple Active Directory/LDAP server, click on **Add source LDAP server** and add the additional server information. Please remember that a *failover server* is not a new server.

## Inum LDAP Server

![Inum LDAP Server](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_inum.png)

This section of the application allows the server administrator to connect to the internal LDAP of the Gluu Server. Please contact Gluu Support for the values for this section.

* _Name:_ This contains the name of the Gluu LDAP server.

* _Bind DN:_ This field contains the username to connect to the internal server.

* _Use SSL:_ Please tick the ckeckbox because the SSL must be activated.

* _Max Connections:_ The recommended number of connections is 2.

* _Server:_ The hostname of the server with IP should be put here.

* _Base DN:_ This contains the Gluu Server LDAP tree which is allowed to access the user information.

* _Enabled:_ Enabling this feature saves the values inside the gluu server.

* _Change Bind Password:_ This option can be used to bind/change the password to connect to the internal LDAP of the Gluu Server.

* _Refresh Method:_ The Gluu Server allows the Server Administrator to apply two types of Cache Refresh mechanism (i) VDS Method and (ii) Copy Method.

  1. _VDS Method:_ Any organization with a database like *mysql* can use the VDS method. This option can be enabled via the dropdown menu in Refresh Method option.

![Refresh VDS](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_refresh_vds.png)

  2. _Copy Method:_ If the organization has any kind of Active Directory/LDAP server, they are strongly recommened to use the *Copy Method* from the dropdown menu.

![Refresh Copy](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_cache_refresh_copy.png)

## Attributes Mapping

When the Copy method is selected, a section for Attribute mapping will be exposed. In this section, the Gluu Server Administrator can map any attribute from the backend Active Directory/LDAP to the LDAP cache of the Gluu Server.

![Attribute Mapping](https://cloud.githubusercontent.com/assets/5271048/7093434/b8a04996-df7e-11e4-977d-b8fcdf5381d7.png)

In the source attribute to destination attribute mapping field, you can enter the source attribute value on the left, and the destination attribute on the right. In other words, you can specify what the attribute is on the backend in the left field, and what it should be rendered as when it comes through the Gluu Server in the right field. 

The Administrator can select any Cache Refresh Method according to the backend Active Directory/LDAP server, but there are some essential values for both types of cache refresh method. The values are given below.

  * _Pooling Interval (Minutes):_ This is the vnterval value for running the Cache Refresh mechanism in the Gluu Server. It is recommended to be kept higher than 15 Minutes.

  * _Script File Name:_ Gluu Server cache refresh can accept any kind of Jython Script which might help calculate any custom/complex attribute i.e. eduPersonScopedAffiliation calculation is highly targeted field where such scripts can be used. For more information please contact Gluu Support.

  * _Snapshot Folder:_ Every cycle of of Gluu Server Cache Refresh cycle save an overall snapshot and problem-list record on a specified location. This is where the Gluu Server Administrator can specigy the location. A Gluu Server administrator can easily decide whether cache refresh has synchronised all users or not. Generally the rejected users are enclosed in the problem-list file. An overall report is displayed at the top of the cache refresh page with headings **Updated at the last run** and **Problems at the last run.**

  * _Snapshot Count:_ This defines the total number of snapshots that are allowed to be saved in the hard drive of the VM. It is recommended to be kept to 20 shapshots.
  
Latest Gluu Servers ( including Community Edition ) introduced two updgraded sections here. 

  * _Server IP Address:_ Include the IP of your Gluu Server here. This feature basically added to run Cache Refresh mechanism perfectly in clustered environment.
  
  * _Removed Script File Name location:_ New version of Gluu Server allows Gluu Server Administrator to manage your custom scripts with more interctive section under configuration named "[Manage Custom Scripts](http://www.gluu.org/docs/admin-guide/oxTrust/configuration/#manage-custom-scripts)"

  * _Update:_ This button is to push the changes in the Gluu Server and it should be hit only when the values have been entered.

  * _Update and Validate Script:_ This button is used to test the operation and integrity of any custom script such as a Jython Script.
  
## Customizing Behavior
Specifics about the behavior of Cache Refresh can be customized within the custom scripts section. Please see more information [here](../../reference/interception-scripts/index.md#cache-refresh)

# Configure Log Viewer

Gluu Server has the facility to read log files using the GUI. The log file can be displayed from the Web UI with a few clicks of the mouse. This feature can be enabled from the configuration menu clicking **Configuration --> Configure Log Viewer.**

![Configure Log Viewer](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_logviewer.png)

Clicking on **Add log template** will bring two boxes. The boxes on the left contains the name/description of the log file, and the right boxes contain the path of the log file such as _/opt/tomcat/logs/demo.log._

# View Log File

The log files configured in the earlier section can be viewed using the **View log file** feature. This feature can be accessed through the configuration menu using **Configuration --> View Log File.**

![View Log File](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_view_log.png)

The **Display last lines count** field contains the lines that will be displayed in the Web GUI. If the field contains the value **400**, then the Gluu Server will show the last 400 lines of the log in the GUI. The screenshot below shows an example.

![Log file tail](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_view_logtail.png)

# Status

![Status](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_config_status.png)
The Status section provides a high level overview of server metrics. The included values are straightforward and shouldn't require any further explanation. 

