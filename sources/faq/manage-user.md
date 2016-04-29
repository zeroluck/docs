# User How-tos
This section contains some hints and how-tos about micro managing users in Gluu Server.

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
