# Asimba configuration with Gluu Server


## Base installation of Asimba package

* Get the war for asimba from Gluu
* Send the war file in ~/tomcat/webapps/
* Restart tomcat, it will extract the asimba
* Get the asimba.conf template from Gluu
* Generate the keystore for your Asimba server:
    * Command: `keytool -genkeypair -keyalg RSA -alias "<ALIAS_OF_KEYSTORE>"
    * -keypass <PASSWORD> -keystore <NAME_OF_JKS>.jks -storepass <PASSWORD>`
        * What is your first and last name?: Provide the hostname of Asimba
        * server
        * What is the name of your organizational unit?: IT
        * What is the name of your organization?: Provide name
        * What is the name of your City or Locality?: city name
        * What is the name of your State or Province?: State name
        * What is the two-letter country code for this unit?: US
* Adding IDP / ADFS in Asimba:
    * Gather metadata of IDP / ADFS and keep them in some place under
    * /tomcat/webapps/asimba-saml-proxy/WEB-INF/
    * Collect certificate of IDP / ADFS and import them in Asimba truststore JKS

* Adding SP in Asimba:
    * Gather metadata of SP and keep them in some place under
    * /tomcat/webapps/asimba-saml-proxy/WEB-INF/
    * Collect certificate of SP and import them in Asimba truststore JKS

* Restart tomcat

## Apache configuration

* Configure "idp.conf":

            <Location /asimba-saml-proxy>
                ProxyPass ajp://<ASIMBA_HOSTNAME>:8009/asimba-saml-proxy retry=5
disablereuse=On
                ProxyPassReverse ajp://<ASIMBA_HOSTNAME>:8009/asimba-saml-proxy

                Order allow,deny
                Allow from all
            </Location>

* Restart httpd

## Test Asimba setup

* Try to download the metadata of Asimba server with: `wget -c
* https://<HOSTNAME>/asimba-saml-proxy/profiles/saml2`
