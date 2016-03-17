# Twilio SMS Authentication Script
This script enables the multi-factor authentication based on a [sms][sms]. 
There are two steps for the SMS authentication.

1. Standard username/password authentication against local Gluu Server LDAP

2. Code sent via [SMS][sms] to user mobile number

The script uses [Twilio service](https://www.twilio.com/) to send messages to the 
user mobile number. The user must sign up with Twilio to acquire the credentials to call the 
Twilio API.
## Requirement

1. Go to Custom Scirpt under Configuration.
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_menu.png)

2. Click on the `Add custom script configuration` button.
![image](https://raw.githubusercontent.com/GluuFederation/docs/master/sources/img/2.4/config-script_add.png)

3. Fill in the form and add the [Twilio Script](https://raw.githubusercontent.com/GluuFederation/oxAuth/master/Server/integrations/TwilioSMS/TwilioSmsAuthenticator.py) in the `Script` box.
## Installing Twilio Java 
The script requires the twilio helper jar file with dependencies to be installed.

1. Download the [Twilio Java Files](http://search.maven.org/#browse%7C-1416163511)

2. Install the [Twilio Java Files](http://search.maven.org/#browse%7C-1416163511) to the `/opt/tomcat/endorsed/` folder

## Properties
There are three required properties in the [twilio script](https://raw.githubusercontent.com/GluuFederation/oxAuth/master/Server/integrations/TwilioSMS/TwilioSmsAuthenticator.py).

|	Property	|	Description			|
|-----------------------|---------------------------------------|
|	twilio_sid	|	Account id at Twilio		|
|	twilio_token	|	API secret provided by Twilio	|
|	from_number	|	Phone number			|

**Note:** Please see the [formatting faq](https://www.twilio.com/help/faq/phone-numbers/how-do-i-format-phone-numbers-to-work-internationally) for the Phone Number property.

[sms]: https://en.wikipedia.org/wiki/Short_Message_Service "short message service"
