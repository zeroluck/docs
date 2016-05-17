# Lock User Account
Gluu Server does not come with a ready script to lock user accounts if they fail to meet certain conditions, but it is possible to inplement such behaviour using custom script. Locking user account is only available for username/password flow and it is not supported for multi-factor authentications.

## User Status Attribute
Gluu Server makes it easy by using a single attribute to enable/disable user. The `gluuStatus` attribute
is used to enable/disable the user. This attribute holds the value `acive/inactive` and setting `gluuStatus=inactive`
any user can be locked from Gluu Server.

So in any condition, if any user needs deactivation, the `gluuStatus` attribute can be used to that purpose.

## Custom Script
In this part, we focus only on how to find and deactivate the user, because the requirement varies among institutions and there is no set standard. The following links to a custom script to lock user after four unsuccessful login attempts.

* [Lock User Custom Script](https://github.com/GluuFederation/oxAuth/blob/master/Server/integrations/basic.lock.account/BasicLockAccountExternalAuthenticator.py)

The following snippet will help you find the user by UID and set the `gluuStatus` attribute to inactive.

```
from org.xdi.oxauth.service import UserService
...
# Find user entry by UID
user_uid = credentials.getUser().getUserId()
find_user_by_uid = userService.getUser(user_uid)

# Update user entry and persist it
find_user_by_uid.setAttribute("gluuStatus", "inactive")
userService.updateUser(find_user_by_uid)
```

**Note:** The users can be activated again by clicking on the update button in oxTrust.

