# Users

## Manage Groups

Gluu Server includes one group, Gluu Server Manager Group named *gluuManager*, by default. By using the *Manage Groups* feature, the Gluu Server Administrator can add, delete or modify any group or any user under the group. The list of available groups can be viewed by hitting the _Search_ button keeping a blank search box.
![Manage User Groups](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_users_managegroups.png)

The Gluu Server Administrator can modify information such as Diplay Name, Group Owner, Visibility type etc. The Server Administrator can also add or delete users under any existing groups. The group information is represented as shown below.
![View group information[(https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_users_groupinfo.png)

If any member of the Organization is required to be added in any specific group, this can be achieved be clicking on the Add Member button. The flow is _Add Member --> Search the name/email of the user --> Select the user --> Click OK --> Update._
![Add Member](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_users_addmember.png)

### Manage People
This feature works like a charm if the organization uses the internal LDAP of the Gluu Server as a data source. A new user can be added with the *Add Person* button. The Gluu Server Administrator needs to provide _UID, First Name, Last Name, Email_ etc and hit *Add.*
![Manage People](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_users_managepeople.png)

This feature also allows the Gluu Server Administrator to search the informaiton of any user. As an example, the screenshot below shows the result of a search. Please note that the feature is only available to the Gluu Server Administrator/ User belonging to the *gluuManager* group.
![Search Result](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrust/admin_users_search.png)
