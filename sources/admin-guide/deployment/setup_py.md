# setup.py command line options

Use setup.py to configure your Gluu Server and to add initial data required for
oxAuth and oxTrust to start. If setup.properties is found in this folder, these
properties will automatically be used instead of the interactive setup.
Options:

    -a   Install Asimba
    -c   Install CAS
    -d   specify the directory where community-edition-setup is located. Defaults to '.'
    -f   specify setup.properties file
    -h   Help
    -l   Install LDAP
    -n   No interactive prompt before install starts. Run with -f
    -N   No apache httpd server
    -s   Install the Shibboleth IDP
    -u   Update hosts file with IP address / hostname
    -w   Get the development head war files
