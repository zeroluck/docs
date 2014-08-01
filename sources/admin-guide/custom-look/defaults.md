# Style customization guide

Static style elements like css, js and images are packaged into separate jar named
_\<ProjectName\>_ Static- _\<version\>_ .jar and is added to the deployable 
war during the build time.

Structure of the jar allows it's context to be accessible from the contextroot, so 
default values of the css and js locations are 
*\<contextPath\>/stylesheet* and *\<contextPath\>/js* in the configuration file.

If look and feel customization is required it is possible to unpack the contents of
the said jar into arbitary location served by the web server and change the default 
cssLocation, jsLocation and imgLocation attributes to the new path (possibly even 
hosted on a different location).

