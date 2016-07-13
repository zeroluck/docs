## How do I change the IP address of my Gluu Server?

There is no easy way to change the IP address of your Gluu Server once it's already deployed. If you need to change an IP address, we recommend doing a fresh install on a new VM.

## How do I customize the IDP to ask for Email instead of Username for login? 

  - In oxTrust navigate to the Manage Authentication tab within the Configuration section. By default the Primary Key and Local Key are set to `uid`. Set those values to `mail` for both 'Primary key' and 'Local primary key' and now people will be prompted for email instead of username.  ![Screenshot](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/Configuration/Authentication/Manage_Authentication_Primary_key_change.png)
  - You might wanna change the 'Username' to 'Email Adress' in login page as well. In order to do that you need to modify a little in 'login.xhtml' ( location: /opt/tomcat/webapps/oxauth/ ). Add 'Email Adress' as value for 'outputLabel'; this snippet is under 'dialog' class. ![Screenshot](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/oxTrustConfiguration/Configuration/Authentication/Email_Address.png)
