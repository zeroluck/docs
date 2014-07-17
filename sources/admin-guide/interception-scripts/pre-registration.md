# Pre-Registration Script

## Place in registration workflow and sample use cases.
Pre-Registration script is being executed after oxTrust gathered enough data about the user and before actually saving the user in either ACTIVE(User can use IDP) or INACTIVE(Administrator must activate user first) state. (Note that user may already exist in database as a result of Custom Authentication Script or Expiration).

Pre-Registration Script can be used to 
    ensure that new user is not a duplicate of an existing user (ensuring that email is unique for example), 
    interrupt registration of users with unacceptable attributes (for example age restrictions),
    make changes to database for specific user (deleting expired duplicates, creating custom groups o4r attributes, etc...)

## Script interface 
Pre-Registration script implement a Registration Script interface:
```
package org.gluu.oxtrust.service.python.interfaces;

import java.util.List;

import org.gluu.oxtrust.model.GluuCustomPerson;
import org.xdi.model.SimpleCustomProperty;

/**
 * Base interface for registration python script
 *
 * @author Oleksiy Tataryn Date: 04.22.2014
 */
public interface RegistrationScript {
	public boolean execute(List<SimpleCustomProperty> list, GluuCustomPerson person);
}
```
Class name MUST be "RegistrationScriptClass"

## Script example
This script verifies that specified attributes are unique and that email is not from a forbidden list of domains. 
It requires two attributes to be specified:
uniqueAttributes - comma-separated list of attributes. (mail,uid)
forbiddenDomains - comma-separated list of domains. (gmail.com,yahoo.com)

```
from org.gluu.oxtrust.service.python.interfaces import RegistrationScript
from org.gluu.oxtrust.ldap.service import PersonService
from org.gluu.oxtrust.model import User
from java.lang import String

import java

class RegistrationScriptClass(RegistrationScript):

    def __init__(self, currentTimeMillis):
        self.currentTimeMillis = currentTimeMillis
        
    def execute(self, configAttributes, registrationAttributes):
        print "configAttributes"
        print configAttributes
        print "registrationAttributes"
        print registrationAttributes
        customAttributes = registrationAttributes.getCustomAttributes()
        print "customAttributes"
        print customAttributes
        personService = PersonService.instance()
        
        for attribute in customAttributes:
            if(attribute.getName() == "inum" ):
                inumValue = attribute.getValues().pop(0)
                print "InumValue " + inumValue

        for configAttribute in configAttributes:
            if (configAttribute.getValue1() == "uniqueAttributes"):
                print "uniqueAttributes present. Value = " + configAttribute.getValue2()
                uniqueAttributes = String.split(configAttribute.getValue2(), ",")
                for uniqueAttribute in uniqueAttributes:
                    print "Checking if " + uniqueAttribute + " is Unique"
                    for attribute in customAttributes:
                        if(attribute.getName() == uniqueAttribute):
                            attributeValue = attribute.getValues().pop(0)
                            print uniqueAttribute + " value is " + attributeValue
                            user = personService.getPersonByAttribute(attribute.getName(), attributeValue)
                            if(user != None and user.getInum() != inumValue):
                                print "user " + user.getInum() + " contains duplicate attribute " + attribute.getName() + ":" + attributeValue
                                return False
            if (configAttribute.getValue1() == "forbiddenDomains"):
                print "forbiddenDomains present. Value = " + configAttribute.getValue2()
                forbiddenDomains = String.split(configAttribute.getValue2(), ",")
                for forbiddenDomain in forbiddenDomains:
                    for attribute in customAttributes:
                        if(attribute.getName() == "mail"):
                            if(attribute.getValues().pop(0).endswith(forbiddenDomain)):
                                print "domain " +  forbiddenDomain + " is forbidden"
                                return False

        return True
```