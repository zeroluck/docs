# Asimba configuration with Gluu Server


## Base installation of Asimba package

* Get the war for asimba from Gluu
* Send the war file in ~/tomcat/webapps/
* Restart tomcat, it will extract the asimba
* Get the asimba.conf template from Gluu
* Generate the keystore for your Asimba server:
    * Command: `keytool -genkeypair -keyalg RSA -alias "<ALIAS_OF_KEYSTORE>" -keypass <PASSWORD> -keystore <NAME_OF_JKS>.jks -storepass <PASSWORD>`
        * What is your first and last name?: Provide the hostname of Asimba server
        * What is the name of your organizational unit?: IT
        * What is the name of your organization?: Provide name
        * What is the name of your City or Locality?: city name
        * What is the name of your State or Province?: State name
        * What is the two-letter country code for this unit?: US
* Adding IDP / ADFS in Asimba: 
    * Gather metadata of IDP / ADFS and keep them in some place under /tomcat/webapps/asimba-saml-proxy/WEB-INF/ 
    * Collect certificate of IDP / ADFS and import them in Asimba truststore JKS

* Adding SP in Asimba: 
    * Gather metadata of SP and keep them in some place under /tomcat/webapps/asimba-saml-proxy/WEB-INF/
    * Collect certificate of SP and import them in Asimba truststore JKS

* Restart tomcat

## Apache configuration

* Configure "idp.conf": 

            <Location /asimba-saml-proxy>
                ProxyPass ajp://<ASIMBA_HOSTNAME>:8009/asimba-saml-proxy retry=5 disablereuse=On
                ProxyPassReverse ajp://<ASIMBA_HOSTNAME>:8009/asimba-saml-proxy
    
                Order allow,deny
                Allow from all
            </Location>

* Restart httpd 

## Test Asimba setup

* Try to download the metadata of Asimba server with: `wget -c https://<HOSTNAME>/asimba-saml-proxy/profiles/saml2`
 

## Adding new Service Provider or Identity Provider in Asimba server

### A new IDP / ADFS configuration in Asimba

All our configurations are based on one Asimba configuration file named
"asimba.xml". It's also possible to configure Asimba with JDBC. For more info
Asimba [wiki](http://sourceforge.net/p/asimba/wiki/Home/) is availalbe.

* Required tools
    * Metadata of remote IDP
    * SAML certificate of remote IDP

* Configuring asimba.xml: 
    * Grab the metadata of remote IDP and save it in some place. Make sure that user tomcat can read this xml copy. 
        * Specify this metadata in  `<websso>\<method>\<idps>` section. 
            * `idp id` must follow the entityID of this metadata.
            * `scoping` should be "false"
            * Add the static path of metadata inside `<file>` section. 
    
A sample configuration should look like below:

<code>

            <idp id="https://idp.gluu.org/idp/shibboleth" friendlyname="Gluu IDP" scoping="false" 
                avoid_subjectconfirmation="false">
                    <nameidpolicy enabled="false" />
                        <metadata>
                            <file>${webapp.root}/WEB-INF/metadata/idp/idp_gluu_org.xml</file>
                        <metadata>
            </idp>

</code>
