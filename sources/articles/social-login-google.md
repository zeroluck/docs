# Social Login with Google

So you want to use Google for authentication? Its a nice option to offer to your customers
who may not want to maintain a password in your domain. Sometimes you may even want to let
employees use Google for authentication--everyone's got a Google account right?

Google is an external "identity provider" or IDP. You need to consider the situation that there
may be users who have Google credentials, but don't yet have an account in your domain. You have
two options: (1) don't let the users login; (2) dynamically add the users to your Gluu
Server LDAP server, which is what we call "dynamic enrollment."

Using a Gluu Server
[authentication interception script](../reference/interception-scripts/index.md),
you can implement any kind of business logic. Gluu has contributed an interception script to handle
Google login on
[Github](https://github.com/GluuFederation/oxAuth/blob/master/Server/integrations/gplus/GooglePlusExternalAuthenticator.py).
This article will provide step-by-step instructions on howto install and configure this script.

## Configure Google

In order to call Google API's, you need to register as a developer and create client credentials.
Here are some [instructions](https://developers.google.com/identity/protocols/OAuth2)

The first thing you'll need to do is Create a Project on Google to obtain
client credentials. Click "Create project" and enter project name

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/google_login/01-create-project.png)

Then click on your newly created project from the listing on the dashboard, and under the Credentials section,
you'll need to create a new "OAuth2 2.0 client ID."

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/google_login/02-create-oauth2-creds.png)

Google will ask you to configure your consent screen, to add your logo and other information displayed to the
user to authorize Google to release information.

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/google_login/03-create-oauth2-creds.png)

Fill out the form...

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/google_login/04-configure-authorization-page.png)

Now you're ready to create the credentials. Enter "Authorized JavaScript origins". It should be
the URL of your Gluu Server for example `https://idp.example.com`

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/google_login/05-create-oauth2-creds.png)

Google will display the client-id and secret... ignore it. What you want to do is download the JSON which
you are going to upload into your Gluu Server.

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/google_login/06-download_json.png)

Move this file to `/opt/tomcat/conf/google.json` The JSON will look something like this
(no... these aren't aren't valid creds!):

```json
{
  "web": {
    "client_id": "7a64e55f-724d4e8c91823d5f1f18a0b2.apps.googleusercontent.com",
    "auth_uri": "https:\/\/accounts.google.com\/o\/oauth2\/auth",
    "token_uri": "https:\/\/accounts.google.com\/o\/oauth2\/token",
    "auth_provider_x509_cert_url": "https:\/\/www.googleapis.com\/oauth2\/v1\/certs",
    "client_secret": "bb76a2c99be94e35b874",
    "javascript_origins": [
      "https:\/\/brookie.gluu.info"
    ]
  }
}
```

The last step is to enable Google+ API's:
 - Navigate back to the Google API [console](https://console.developers.google.com/project)
 - Select project and enter project name
 - Open new project "API & auth -> API" menu item in configuration navigation tree
 - Click "Google+ API"
 - Click "Enable API" button

## Configure Gluu Server

Login to oxTrust and navigate to "Configure Custom Scripts"

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/google_login/06-manage-custom-scripts.png)

And at the bottom of the page, click on the little link for "Add custom script configuration"

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/google_login/07-add_custom_script.png)

In the main body of the "Custom Script" section, paste the
[code from github](https://raw.githubusercontent.com/GluuFederation/oxAuth/master/Server/integrations/gplus/GooglePlusExternalAuthenticator.py)

You'll also need to add some custom properties:

 * __gplus_client_secrets_file__ : /opt/tomcat/conf/google.json
 * __gplus_deployment_type__ : enroll
 * __gplus_remote_attributes_list__ : email, email, given_name, family_name, given_name, locale
 * __gplus_local_attributes_list__ : uid, mail, givenName, sn, cn, preferredLanguage

1. _gplus_client_secrets_file_ - It's mandatory property. It's path to application configuration file downloaded from Google console for application.
Example: `/etc/certs/gplus_client_secrets.json`
These are steps needed to get it:
    a) Log into: https://console.developers.google.com/project
    b) Click "Create project" and enter project name
    c) Open new project "API & auth -> Credentials" menu item in configuration navigation tree
    d) Click "Add credential" with type "OAuth 2.0 client ID"
    e) Select "Web application" application type
    f) Enter "Authorized JavaScript origins". It should be CE server DNS name. Example: https://gluu.info
    g) Click "Create" and Click "OK" in next dialog
    h) Click "Download JSON" in order to download gplus_client_secrets.json file
Also it's mandatory to enable Google+ API:
    a) Log into: https://console.developers.google.com/project
    b) Select project and enter project name
    c) Open new project "API & auth -> API" menu item in configuration navigation tree
    d) Click "Google+ API"
    e) Click "Enable API" button

2. _gplus_deployment_type_ - Specify deployment mode. It's optional property. If this property isn't specified script
   tries to find user in local LDAP by 'subject_identifier' claim specified in id_token. If this property has 'map' value script
   allow to map 'subject_identifier' to local user account. If this property has 'enroll' value script should add new user to local LDAP
   with status 'acrtive'. In order to map IDP attributes to local attributes it uses properties gplus_remote_attributes_list and
   gplus_local_attributes_list.
   Allowed values: map/enroll
   Example: enroll

3. _gplus_remote_attributes_list_ - Comma separated list of attribute names (user claims) that Google+
   returns which map to local attributes attributes in the `gplus_local_attributes_list` property.
   It's mandatory only if `gplus_deployment_type` is 'enroll'.

4. _gplus_local_attributes_list_ - Comma separated list of Gluu Server ldap attribute names
   returns are mapped to Google user claims from the `gplus_remote_attributes_list` property.
   It's mandatory only if `gplus_deployment_type` is 'enroll'.

5. _extension_module_ - Optional property to specify the full path of an external module that
implements two methods:

```python
    # This is called when the authentication script initializes
    def init(conf_attr):
        # Code here
        return True/False

    # This is called after authentication
    def postLogin(conf_attr, user):
        # Code here
        return True    # or return False
```

6. _gplus_client_configuration_attribute_ - Optional property to specify client entry attribute name
    which can override `gplus_client_secrets_file file` content. It can be used in cases when all
    clients should use separate `gplus_client_secrets.json` configuration.

## Testing

One simple way to test is to use oxTrust for testing. In the "Configure Authentication" menu dropdown, select
"Google" (or whatever you entered as the "Name" of the custom authentication script--as the default
authentication method.

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/google_login/08-select_default_authentication.png)

After you login and logout, you should be presented with a new login form that has the Google Login button:

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/google_login/09-google-authentication-button.png)

After clicking the Google Login button, you should be presented for authorization--Google needs to make sure
its ok to release attributes to the Gluu Server:

![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/google_login/10-google-authorization.png)

If the script doesn't work, and you locked yourself out of oxTrust, don't worry! You can create an ldif file,
for example `revert.ldif`, to set back the default authentication method, like this:

    dn: inum=@!1E3B.F133.14FA.5062!0002!4B66.CF9C,ou=appliances,o=gluu
    changetype: modify
    replace: oxAuthenticationMode
    oxAuthenticationMode: internal

oxAuthenticationMode corresponds to the 'Name' of the customer authentication script in oxTrust, use
`internal` to revert to the default ldap authentication. You'll have to change the `inum` with the `inum`
for your installation. You can find it an ldapsearch like this:

    /opt/opendj/bin/ldapsearch -h localhost -p 1389 -D "cn=directory manager" -j ~/.pw \
    -b "ou=appliances,o=gluu" -s one "objectclass=*" inum

where `~/.pw` is a file with your Directory Manager password. If you don't remember it, try
    grep ldapPass= /install/community-edition-setup/setup.properties.last

Once your ldif looks ok, then use ldapmodify to revert back to password authentication:

    /opt/opendj/bin/ldapmodify -h localhost -p 1389 -D "cn=directory manager" -j ~/.pw -f revert.ldif

If things go wrong, it can leave the sessions in your browswer in a bad state. If things get really weird,
remove the cookies in your browser for the hostname of your Gluu Server.


