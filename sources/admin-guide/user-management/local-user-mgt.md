# Local User Management

So you want a GUI to view or manage users? You're in luck... the Gluu Server has got that too.
The first thing to consider is what attributes (user claims) the administrator sees.  This is
configured in the attributes section of oxTrust

![](http://www.gluu.org/docs/img/local_user_admin/attr_list.png "Managing Person Attributes")

When you configure the attribute, you can make it viewable or editable by the user.
If you are using [cache refresh](http://www.gluu.org/docs/admin-guide/user-management/ldap-sync/), you should make sure that the attributes are not editable.
You wouldn't want a person to change an attribute in the cache, as it will be updated at the
next cache refresh interval. 

![](http://www.gluu.org/docs/img/local_user_admin/attr_detail.png "View / Edit Attribute")

The user browser can be found under the "Users" menu list.

![](http://www.gluu.org/docs/img/local_user_admin/manage_people.png)

You can add, edit, view or delete a person. To add an attribute, click on the respective 
objectclass, and then click on the attribute. This will dynamically add it to the form:

![](http://www.gluu.org/docs/img/local_user_admin/add_person_form.png)

