# Interception Scripts

The Gluu Server was designed to be very flexible. Gluu Server admins can use [Jython](http://www.jython.org/docs/tutorial/indexprogress.html) interception scripts to customize behavior.

Jython was chosen because an interpreted language facilitates dynamic creation of business logic, and makes it easier to distribute this logic to a cluster of Gluu servers.

Another advantage of Jython was that developers can use either Java or Python classes. Combined with the option of calling web services from Python or Java, this enables the Gluu Server to support any business-driven policy requirement.

To access custom scripts within oxTrust, navigate to Configuration > Manage Custom Scripts.

# Overview
There are currently 8 options that can be customized by using interception scripts.    

- [Application Session Management](#application-session-management)         
- [Authentication](#authentication)     
- [Authorization](#authorization)       
- [Cache Refresh](#cache-refresh)       
- [Client Registration](#client-registration)       
- [ID Generation](#id-generation)       
- [Update User](#update-user)       
- [User Registration](#user-registration)       

All script types inherit a base interface which has 3 methods:   
    
`def init(self, configurationAttributes):`      

`def destroy(self, configurationAttributes):`       
    
`def getApiVersion(self):`      

The `configurationAttributes` parameter is `java.util.Map<String, SimpleCustomProperty>` with properties specified in `oxConfigurationProperty` attributes.   

The `init` and `destroy` methods are called only one time during the script initialization and script destroy events. The `init` method can be used to do global script initialization, initiate objects, etc. The `destroy` method can be used to free resources and objects created in the `init` method.    
    
The script manager only loads enabled scripts. Hence, after enabling a script, the script manager should trigger an event to load or destroy script. 

All scripts are stored in LDAP in the `ou=scripts,o=<org_inum>,o=gluu` branch.  

This is a sample entry:     

    dn: inum=@!1111!031C.4A65,ou=scripts,o=@!1111,o=gluu
    objectClass: oxCustomScript
    objectClass: top
    description: <custom_script_description>
    displayName: <display_name>
    gluuStatus: true
    inum: @!1111!031C.4A65
    oxLevel: <priority>
    oxModuleProperty: {"value1":"module_property_name","value2":"module_property_value","description":""}
    oxConfigurationProperty: {"value1":"configuration_property_name","value2":"configuration_property_value","description":""}
    oxRevision: <revision>
    oxScript: <custom_script>
    oxScriptType: <script_type>
    programmingLanguage: python

The script manager reloads scripts automatically without needing to restart the application once `oxRevision` is increased.

The `getApiVersion` method allows API changes in order to do transparent migration from an old script to a new API. Currently all scripts should return 1. For example, in the future we can extend the API of any script and call new method(s) only if API version > 2, etc. exists. 

# Application Session Management
This script allows an admin to notify 3rd party systems about requests to end an OAuth session. This method is triggered by an oxAuth call to the `end_session` endpoint. It's possible to add multiple scripts with this type. The application should call all of them according to the level.

This script type adds only one method to base scipt type:    

`def endSession(self, httpRequest, authorizationGrant, configurationAttributes):`       
        
These are the types of parameters:    
- `httpRequest` is `javax.servlet.http.HttpServletRequest`      
- `authorizationGrant` is `org.xdi.oxauth.model.common.AuthorizationGrant`      
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`        

This script can be used in oxAuth application only.

- [Sample Application Session Management Script](./sample-application-session-script.py)

# Authentication

An authentication script enables you to customize the user authentication experience. For example, you can write a script that enables a two-factor authentication mechnaism like Duo Security. By default oxAuth uses simple username/password authentication method. This scipt type allows an admin to implement more secure workflows to cover an organizations security requirements. It extends the base scipt type with the `init`, `destroy` and `getApiVersion` methods but also adds the following methods:    

`def isValidAuthenticationMethod(self, usageType, configurationAttributes):`

`def getAlternativeAuthenticationMethod(self, usageType, configurationAttributes):`

`def authenticate(self, configurationAttributes, requestParameters, step):`     

`def prepareForStep(self, configurationAttributes, requestParameters, step):`   

`def getCountAuthenticationSteps(self, configurationAttributes):`   

`def getExtraParametersForStep(self, configurationAttributes, step):`   

`def getPageForStep(self, configurationAttributes, step):`      

`def logout(self, configurationAttributes, requestParameters):`     

The `isValidAuthenticationMethod` method is used to check if the authentication method is in a valid state. For example we can check there if a 3rd party mechanism is avalable to authenticate users. As a result it should return `True` or `False`.

This method has the following parameters:    
- `usageType` is `org.xdi.model.AuthenticationScriptUsageType`  
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`    

The `getAlternativeAuthenticationMethod` method is called only if the current authentication method is in an invalid state. Hence authenticator calls it only if `isValidAuthenticationMethod` returns `False`. As a result it should return the reserved authentication method name.

This method has the following parameters:    
- `usageType` is `org.xdi.model.AuthenticationScriptUsageType`  
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`    

The `authenticate` method is the key method within the person authentication script. It checks if the user has passed the specified step or not. As a result it should return `True` or `False`.

This method has the following parameters:    
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`    
- `requestParameters` is `java.util.Map<String, String[]>`  
- step is a java integer

The `prepareForStep` method can be used to prepare variables needed to render login page and store them in event context.
As a result it should return `True` or `False`. 

This method has the following parameters:    
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`    
- `requestParameters` is `java.util.Map<String, String[]>`  
- step is a java integer

The `getCountAuthenticationSteps` method should return an integer value with the number of steps in the authentication workflow.

This method has the following parameters:    
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`    

The `getExtraParametersForStep` method provides a way to notify the authenticator that it should store specified event context parameters event in the oxAuth session. It's needed in few cases, for example when an authentication script redirects the user to a 3rd party authentication system and expects the workflow to resume after that. As a result it should return a java array of strings.

This method has the following parameters:    
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`    
- step is a java integer    

The `getPageForStep` method allows the admin to render a required page for a specified authentication step. It should return a string value with a path to an XHTML page. If the return value is empty or null, the authenticator should render the default log in page `/login.xhtml`.

This method has the following parameters:     
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`    
- step is a java integer    

The `logout` method is not mandatory. It can be used in cases when you need to execute specific logout logic within the authentication scipt when oxAuth receives an end session request. Also it allows oxAuth to stop processing the end session request workflow if it returns `False`. As result it should return `True` or `False`.

This method has the following parameters:     
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`    
- `requestParameters` is `java.util.Map<String, String[]>`  

This script can be used in oxAuth application only.

**For a complete list of pre-written, open source Gluu authentication scripts, view our [server integrations](https://github.com/GluuFederation/oxAuth/tree/master/Server/integrations)**

- [Sample Authentication Script](./sample-authentication-script.py) 

# Authorization
This is a special script for UMA. It allows an admin to protect UMA scopes with policies. It's possible to add more than one UMA policy to an UMA scope. On requesting access to a specified resource, the application should call specified UMA policies in order to grant/deny access.

This script type adds only one method to base scipt type:    

`def authorize(self, authorizationContext, configurationAttributes):`   

These are types of parameters:     
- `authorizationContext` is `org.xdi.oxauth.service.uma.authorization.AuthorizationContext`     
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`        

This script can be used in oxAuth application only.

- [Sample Authorization Script](./sample-uma-authorization-script.py)   

# Cache Refresh
In order to integrate with an existing authentication server oxTrust provides a mechanism called [Cache Refresh](../../admin-guide/configuration/index.md#cache-refresh) to copy user data to the local LDAP server. During this process it's posible to specify key attribute(s) and specify attribute name transformations. There are also cases when it can be used to overwrite attribute values or add new attributes based on other attributes values. 

This script type adds only one method to base scipt type:     

`def updateUser(self, user, configurationAttributes):`      

These are types of parameters:     
- `user` is `org.gluu.oxtrust.model.GluuCustomPerson`       
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`        

This script can be used in oxTrust application only.
    
- [Sample Cache Refresh Script](./sample-cache-refresh-script.py)       

# Client Registration
oxAuth implements the [OpenID Connect dynamic client registration](https://openid.net/specs/openid-connect-registration-1_0.html) specification. All new clients have the same default access scopes and attributes except password and client ID. The Client Registration script allows an admin to modify this limitation. In this script it's possible to get a registration request, analyze it, and apply customizations to registered clients. For example, a script can give access to specified scopes if `redirect_uri` belongs to a specifed service or domain. 

This script type adds only one method to base scipt type:    

`def updateClient(self, registerRequest, client, configurationAttributes):`     

These are types of parameters:     
- `registerRequest` is `org.xdi.oxauth.client.RegisterRequest`      
- `client` is `org.xdi.oxauth.model.registration.Client`        
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`        

This script can be used in oxAuth application only.

- [Sample Client Registration Script](./sample-client-registration-script)      

# ID Generation
By default oxAuth/oxTrust uses an internal method to generate unique identifiers for new person/client, etc. entries. In most cases the format of the ID is:    

`'!' + idType.getInum() + '!' + four_random_HEX_characters + '.' + four_random_HEX_characters.`     

The ID generation script enables an admin to implement custom ID generation rules. 

This script type adds only one method to base scipt type:     

`def generateId(self, appId, idType, idPrefix, configurationAttributes):`       

These are types of parameters:     
- `appId` is application ID     
- `idType` is ID Type       
- `idPrefix` is ID Prefix       
- `user` is `org.gluu.oxtrust.model.GluuCustomPerson`       
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`        

This script can be used in oxTrust application only.     

- [Sample ID Generation Script](./sample-id-generation.py)      

# Update User
oxTrust allows an admin to add and modify users wich belong to groups. In order to simplify this process and apply repeating actions, oxTrust supports an Update User script. In this script it's possible to modify a person entry before it is persisted in LDAP.

This script type adds only one method to base scipt type:     

`def updateUser(self, user, persisted, configurationAttributes):`       

These are types of parameters:     
- `user` is `org.gluu.oxtrust.model.GluuCustomPerson`       
- persisted is boolean value to specify if operation type: add/modify       
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`        

This script can be used in oxTrust application only.     

- [Sample Update User Script](./sample-update-user-script.py)       

# User Registration
oxTrust allows users to perform self-registration. In order to control/validate user registrations there is the user registration script type.

This script type adds three methods to the base scipt type:     

`def initRegistration(self, user, requestParameters, configurationAttributes):`     

`def preRegistration(self, user, requestParameters, configurationAttributes):`      

`def postRegistration(self, user, requestParameters, configurationAttributes):`     

All these methods expect the same parameters:      
- `user` is `org.gluu.oxtrust.model.GluuCustomPerson`       
- `requestParameters` is `java.util.Map<String, String[]>`      
- `configurationAttributes` is `java.util.Map<String, SimpleCustomProperty>`        

First oxTrust executes the `initRegistration` method to do inital user entry update. The `preRegistration` method is called  before persisting the user entry in LDAP. Hence in this script it's possible to validate the user entry. The `postRegistration` method is called after successfully persisting the user entry in LDAP. In this method, for example, the script can send an e-mail or send notifications to other organization systems about the new user entry.

All three methods should return `True` or `False`.       

- [Sample User Registration Script](./sample-user-registration-script.py)       
