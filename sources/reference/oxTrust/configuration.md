# Configuration

## Configuration Menu
The configuration menu on the home screen has shortcuts to the different configurations available in the oxTrust by Gluu.
![Configuration Menu](img/admin_menu_configuration.png)

### Organization Configuration
The organization congiguration contains a set  of different configurations under it. The configurations are given under their headings in this document.

#### Configure Cluster Partner
![Configure Cluster Partner](img/admin_config_cluster.png)
This feature or option is still in the testing phase and you will be notified when it is available.

#### System Configuration
This feature allows the Gluu system administrator to choose various options such as *Cache Refresh*, *Federation Hosting*, *SCIM Support* etc. 
![System Configuration](img/admin_config_system.png)

* _White Pages:_ If the user intends to use the built-in White Pages of the Gluu Server, it can be enabled from the menu.

* _Federation Hosting:_ The Federation hosting is enabled by default. However, the creation and management of federations can be complicated. Gluu offers an additional service called *Federation Registry* that makes the creation and management of identity federations simple and easy. 

* _Cache Refresh:_ This is the mechanism which pulls and synchonises user information from a remote LDAP/Active Directory with the local LDAP of Gluu server. The Gluu server administrator needs to provide sufficient information including username and password before enabling this option.

* _SCIM Support:_ If the organization already has an identity management or provisioning system in place, the SCIM protocol can be used to push and synchronise the existing identity data into the Gluu Server.

* _DNS Server:_ The address to the DNS Server goes in this field.

* _Maximum Log Size:_ This option can be used to mitigate the space issues within the Gluu Server. The Gluu Server automatically zips any log file which is bigger than the defined value in this field. 

#### Manage Email Addresses
This feature allows the Gluu Server Administrator to manage notifications for the IdP.
![Manage Email Addresses](img/admin_config_email.png)

* _Email for Centreon:_ Centreon is the server monitoring system used by Gluu. The email address in this field shall recieve various notifications from Centreon.

* _Email for Jira:_ The customers are not provided the jira access, and it will be removed from oxTrust soon. Please visit [Gluu Support](https://support.gluu.org) for customer support.

* _Email for Billing:_ The email address in this field will receive the billing invoices from Gluu.

* _Email for Privacy:_ This email address will receive news and updates about the privacy related matters of Gluu.

* _Email for SVN:_ The IdP related configuration files are are saved in the [Gluu SVN](https://svn.gluu.info). Configuration files are generally saved under */opt/* and */etc/httpd/*. The email address will get access to the checked-in files section of the corresponding IdP.

#### SMTP Server Configuration
The Gluu server can communicate to any SMTP server specified in these fields. All Gluu Server related informats *(cron daemon/logwatch/crash reports etc.)* can be pushed to the desired Gluu Server Administrator using this feature.
![SMTP Server Configuration](img/admin_config_smtp.png)

* _SMTP Host:_ Name of the SMTP Host server.

* _From Name:_ Name of the Gluu Server Administrator.

* _From Email Address:_ Email Address of the Gluu Server Administrator.

* _Required Authentication:_ If the SMTP server requires authentication every access, then please enable this option by ticking the checkbox.

* _SMTP User Name:_ The username for the SMTP server goes in this field.

* _SMTP Password:_ The password for the username above goes here. The username and password are used to access the SMTP server.

* _Requires SSL:_ If the SMTP Server has SSL availability, then enable this option by ticking the checkbox.

* _SMTP Port:_ The SMTP Host server port number must be listed here.

#### Configuration
This feature provides options to add various changes in the Gluu Server User Interface. Gluu Server Administrator can add Title, Display Name or evern modify the Web User Interface color from this section.
![Configuration Panel](img/admin_config_config.png)

* _Title:_ The Web User Interface title can be modified with this link.
![Web Interface Title](img/admin_config_config_title.png)

* _Display Name:_ This is the display name for the Gluu Server User Interface. However, this option is yet to be tested properly.

* _Short Name:_ This feature has not been tested yet.

* _Description:_ This feature is yet to be tested for any change in the IdP.

* _Login Page Message:_ The login page now uses oxAuth Web UI and the changes made in this field will not affect the IdP.

* _Welcome Title Text:_ The Gluu Server Administrator can add custom welcome text tile with this feature.
![Welcome Title Text](img/admin_config_config_welcome.png)

**Welcome Page Message:** This feature can be used to add various messages and shortcuts in the welcome message.
![Welcome Page Message](img/admin_config_config_message.png)

* _Manager Group:_ Gluu server has a single manager group. The users under the manager group can use the Web User Interface to operate the Gluu Server. There is no limit to the users that can be added to the manager group.

* _Organization Logo:_ The orgaziation logo can be uploaded and activated from the configuration menu.

* _Organization Favicon:_ This feature can be used to change the organization favicon, if necessary.

* _Menu Color:_ This is the menu color picker for the Gluu Server User Interface. The color used in the demo screenshots is Green.

### Manage Certificates
#### Certificate Management
This allows the users to choose whether to use the JRE public certificates or not.
![JRE Certificate Management](img/admin_manage_jre.png)

#### Manage Server SSL Certificates
The Gluu Server has different certificates for Apache and SSO handling. The certificate must be a well known CA certificate for Apache HTTPS and for SSO handling it can either be self-signed or a CA certified certificate. In both the cases, the CN of the certificate must follow the HOSTNAME of the Gluu Server. 

![Manage Certificates](img/admin_manage_cert.png)
This feature of the oxTrust allows the Gluu Server Administrator to manage both types of certificates. The First box which has **DA...-java.crt** operates the SSL/Apache/HTTPS functions of Gluu Server. The second box is where there is **DA...-shib.cert** is relevant to the SAML transaction.

In order to update/install Gluu Server certificates, both Private key and Public certificates are required. It is essential to update both the public and private keys when updating the server or updating the certificates.

#### Manage Public Certificates
This allows the addition of custom authentication configuration and changing of public certificates.
![Manage Public Certificates](img/admin_manage_public.png)

### Manage Authentication
#### Manage LDAP Authentication
This feature allows the Gluu Server Administrator to define how and where the server should connect to authenticate users. If it is a remote LDAP/Active Directory server, the values are required. The values can also be used if the organization uses the local LDAP of the Gluu Server for authentication. 
![Manage LDAP Authentication](img/admin_manage_ldap.png)

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

#### Default Authentication Method
This allows the Gluu Server Administrator to select the authentication mode and level for the persons. The four modes of authentication are *default, basic, duo* and *saml*. The authentication level can be *default, 10*, or *20*.
![Default Authentication Method](img/admin_auth_default.png)

#### Manage Custom Authentication Method
The Gluu Server supports username/password authentication against the local LDAP or a remote LDAP/Active Directory by default. In addition, oxTrust provides the interface for inserting *Jython* code to enable dynamic authentication logic including the use of any strong and multi-step authentication process. Gluu can write the custom scripts for *premium customers* and release them under open source license for others to use. There are two-factor authentication scripts under the open source license available in [Gluu Two Factor](http://gluu.org/two-factor).
![Custom Authentication Method Screenshot 1](img/admin_auth_custom.png)
![Custom Authentication Method Screenshot 2](img/admin_auth_custom1.png)

* _Name:_ A unique name should be defined for every authentication method. For example, the sections representing the *Duo two-factor authentication* are appropriately named **Duo**.

* _Level:_ This field defines a domain-relevant security level for each supported authentication method.

* _Usage Type:_ Interactive.

* _Custom Property (Key/Value):_ Every two factor authentication method has its own key values. Typically the keys/values are provided by the two factor authentication company. Gluu Engineers can help the Server Administrators to gain and push the values.

### Manage Registration
#### Configure Registration Workflow
This allows the activation of invitation links and has options to allow registration in the IdP without any invitation. There are options to change the expiration of accounts with the option to change the time for account expiration process.
![Configure Registration Workflow](img/admin_config_workflow.png)

### Import People
This feature allows the Gluu Server Administrator to bulk import users. The user *xls* file can be added using the **Add** button.
![Import User](img/admin_config_people.png)

Validation checking for the added *xls* file can be done using the **Validate** button. If the file is not formatted properly, the server will reject the same with an error as shown below in the screenshot.
![Validation Error Message](img/admin_config_people_validate.png)

### Attributes
An *Active* attribute list can be seen from the **Configuration --> Attributes** section.
![Attribute Menu](img/admin_menu_attributes.png)
![Attribute Menu](img/admin_attribute_menu.png)

The Gluu Server has a large LDAP tree which includes all standard attributes. It is not necessary for all of them to be *Active*. The active LDAP trees can be sorted using the *Show only Active Attributes* link.
![Show Active Attribute](img/admin_attribute_show.png)

The Gluu Server Administrator can make changes, such as changing the status to active/inactive, to an attribute after clicking on it.
![Attributes](img/admin_attribute_attribute.png)

Additional attributes can be added from the Gluu Server GUI, oxTrust, by clicking the **Add Attribute** button. On clicking the **Add Attribute** button, the following screen shall appear.
![Add Attriute Screen](img/admin_attribute_add.png)

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
