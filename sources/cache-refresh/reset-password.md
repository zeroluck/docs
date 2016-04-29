# Reset User Password
Gluu Server Community Edition comes with a password reset feature, but it is deisabled by default.
This feature is available for those setups which use Gluu Server's internal LDAP as the user data source.
This document shows how to setup password reset feature.

1. Enable `Self-Service Password Reset` from oxTrust `Organization Configuration` Menu
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/admin_menu_configuration.png)
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/password-reset.png)

2. Configure SMTP Server from oxTrust
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/admin_menu_configuration.png)
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/admin_config_smtp.png)

3. Now the password reset link will be available at `https://<hostname>/identity/person/passwordReminder.htm`
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/pass-reset.png)

    1. Enter the email address and Gluu Server will send the passsword reset link via email.
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/pass-reset-email.png)

    2. The email link will allow the user to set a new password.
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/new-pass.png)



