# Advanced User Management
## Lock User Account
This section will help in locking a user account using custom scripts in solutions where it is
mandatory to limit access trials to a specific number i.e. lock user account if the user fails to 
produce correct password 3 times.

Gluu Server makes it easy by using a single attribute to enable/disable user. The `gluuStatus` attribute
is used to enable/disable the user. This attribute holds the value `acive/inactive` and setting `gluuStatus=inactive`
any user can be locked from Gluu Server.

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

The users can be activated again by clicking on the update button in oxTrust.

## DUO User management
This section will point out the part where any organization can implement their own logic to DUO authentication.
Gluu Server Community Edition uses a `duo_group` distinguish between DUO activated and normal users. This entire logic
is handled by custom scripts, so it is possible to rearrange/rewrite the logic entirely using `jython`. 

The following snippet checks the availability of the user in the `duo_group` and sends for multi-factor authentication.
```
user = credentials.getUser()
if (self.use_duo_group):
   print "Duo. Authenticate for step 1. Checking if user belong to Duo group"
   is_member_duo_group = self.isUserMemberOfGroup(user, self.audit_attribute, self.duo_group)
   if (is_member_duo_group):
      print "Duo. Authenticate for step 1. User '" + user.getUserId() + "' member of Duo group"
      duo_count_login_steps = 2
   else:
```

Keeping the same logic, it is possible to user any other attribute/group to enable DUO for that specific group. Please let us know 
if there is anything more we can add to this guide.
