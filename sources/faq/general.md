## How do I change the IP address of my Gluu Server?

There is no easy way to change the IP address of your Gluu Server once it's already deployed. If you need to change an IP address, we recommend doing a fresh install on a new VM.

## How do I customize the IDP to ask for Email instead of Username for login? 

  - Configuration: In oxTrust navigate to the Manage Authentication tab within the Configuration section. By default the Primary Key and Local Key are set to `uid`. Set those values to `mail` for both 'Primary key' and 'Local primary key' and now people will be prompted for email instead of username.  
  - 
  - Login page modification: 
