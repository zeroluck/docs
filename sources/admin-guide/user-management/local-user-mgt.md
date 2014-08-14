# Local User Management
In oxTrust, you can add, edit and manage people, groups and user attributes and claims to ensure the proper information is released about the right people. 

##Manage People
To manage people, navigate to User → Manage People, as shown in the screenshot below. From this interface, you can add users, search for specific users, or click 'search' with a blank field to display all. 

![](http://www.gluu.org/docs/img/local_user_admin/manage_people.png)

##Manage Groups
Out of the box, the Gluu Server includes one group: Gluu Server manager group, named: “gluuManager”. Groups can be added and populated as needed. Available groups can be seen by leaving the search field blank and clicking “Search.”

##Attributes
An “Active” attribute list can be seen from the Configuration → Attributes section. By default, only active attributes are shown. To see inactive attributes, click the "Show All Attributes" link above the table. To edit an attribute simply click on the Display Name.

![](http://www.gluu.org/docs/img/local_user_admin/attr_list.png "Managing Person Attributes")

When you configure the attribute, you can make it viewable or editable by the user. If you are using [cache refresh](http://www.gluu.org/docs/admin-guide/user-management/ldap-sync/), you should make sure that the attributes are not editable. You wouldn't want a person to change an attribute in the cache, as it will be updated at the next cache refresh interval. 

![](http://www.gluu.org/docs/img/local_user_admin/attr_detail.png "View / Edit Attribute")



