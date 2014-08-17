# Registration
There are four ways to add a user in gluu server:

* Self-Registration
* User Management Interface
* SCIM
* Cache Refresh Script
* Custom Authentication Script (e.g. Inbound Saml Registration)
  
## Self-Registration

Self-Registration is registration done by the users themselves on a self-service basis.

Self-Registration will only be effective if gluu ldap is used for authentication of users as oxTrust user registration cannot add users to the backing AD if it is present.

### Default Self-Registration
By default self-registration view is available at /oxTrust/register url.

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/selfregistration.JPG?raw=true)

Only a limited number of attribute is present in default self-registration form. If more attributes are needed they can be added in Registration Management of Organization Configuration.

### Self-Registration Customization Options
Default Self-Registration workflow can be altered in a Registration Management view.

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/ManageRegistrationMenu.jpg?raw=true)

For default behavior all checkboxes should be unchecked. 

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/ManageRegistrationStart.jpg?raw=true)

### Options reference

  * Activate Invitation Links Management - Disable public registration. Start using Invitation Links. Required for further configuration of the Invitation Links feature.
    * Run invite codes expiration process every: - Part of the Invitation Links feature. Allows to configure how often oxTrust will purge expired invitation links from the system. 
    * Enable registration without invitation - Part of the Invitation Links feature. Allow public registration even when Invitation Links are used.
    * Enable account expiration - Part of the Invitation Links feature. Registered accounts will be subject to an expiration policy
      * Accounts expire after: - Part of the Account Expiration feature. Sets account expiration period. After this period registered accounts will be subject to invalidation during the next account expiration process run.
      * Run accounts expiration process every: - Part of the Account Expiration feature. Allows to configure how often oxTrust will invalidate expired user accounts from the system. 
  * Configure Registration Interception Scripts - Configure Pre-Registration and/or Post-Registration interception scripts. 
  * Configure Registration Form Attributes - Add more attributes to the registration form. 
      Just start typing attribute name in the Attributes Filter and then move desired attributes to the right column. 

### Invitation Link registration
When active Invitation Links feature allows to control who can register an account by issuing a unique registration link and sending it to the desired new users.

Any person who knows the link will be able to register an account(if link is not expired). Expired Links are deleted according to "invite codes expiration process" policy, together with any unconfirmed accounts if said link is moderated.

Invitation Links can be optionally made "moderated" and a a number of moderators can be assigned to the link from among registered users. In this case any newly registered users who used this link will not be immediately able to use their account until their registration is approved by the moderator of their link.

#### Management

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/RegistrationLinksManagementMenu.jpg?raw=true)

  * "Manage Registration Links" and "Registration Requests" menu items become available only if Invitation Links feature is enabled in "Manage Registration".

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/RegistrrationLinksInventory.jpg?raw=true)

  * "Create Invitation Link" - Allows to create new Invitation Links. 

  * "Get new Linktrack link" button becomes available only if Linktrack API has been configured at:

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/LinktrackAPIMenu.jpg?raw=true)

   It allows to get new Linktrack shortened link for the Invitation Link. (https://linktrack.info/)

  * Delete - delete the Invitation Link. Any pending requests associated with this link will also be deleted.

  * Share - This button allows to easily email the invitation to desired recipients. 

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/ShareRegistrationLinks.jpg?raw=true)

In the "To" field any number of comma-separated emails can be typed, then pressing "Add" will verify those emails and add ones that are valid. 

#### Moderation

Users that were chosen as moderators for any links will be able to approve or decline registration requests associated with those links:

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/ModerationMenu.jpg?raw=true)

In a list of pending requests moderator may choose to either "Approve" or "Decline" each user. 

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/Moderation.jpg?raw=true)

  * Approve - makes user able to use the system (authenticate successfully)
  * Decline - removes the user from the system.

## User Management Interface

OxTrust administartors can add, remove or update users using the User Management functionality:

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/UserManagementMenu.jpg?raw=true)

On the User Management page administrator can either Add Person to start new user creation or search the desired user (minimum 2 characters required) by name or uid.

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/UserManagement.jpg?raw=true)

### User Management Interface - Add user

OxTrust administrator may add any configured attributes to the new user and set those attributes that are "writeable by administrator"(administrator cannot set or change iname, inum, etc...).

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/AddUser.png?raw=true)

Note that administrator will either have to change user password right away or add SMTP server configuration in "Organization Configuration" so that user could use "OxTrust Password Recovery System" to change his own password (/oxTrust/person/passwordReminder.htm)

![Image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/registration/UserAdded.jpg?raw=true)

## Custom Authentication Scripts

Custom Authentication Script has access to the java backend functionality and can be used to register user during the first access. An example of such script is InboundSaml Script, which recives user data from a thirdparty SAML IDP and for first-time users creates a new account.

