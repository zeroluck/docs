# Attribute Transformation Script

Interfaces:


        public interface EntryInterceptorType {

                public boolean updateAttributes(GluuCustomPerson person);

        }


Sample Attribute Transformation Script


        # Import of Java classes
        from org.gluu.site.ldap.cache.service.intercept.interfaces import EntryInterceptorType
        from org.gluu.site.util import StringHelper
        from org.gluu.site.model import GluuCustomPerson
        from org.gluu.site.model import GluuCustomAttribute

        import java

        class EntryInterceptor(EntryInterceptorType):
            def __init__(self, currentTimeMillis):
                self.currentTimeMillis = currentTimeMillis

            def updateAttributes(self, person):

                # Assign the current entry's attributes to an array
                attributes = person.getCustomAttributes()

                # Create and set the attribute eduPersonPrincipalName
                uidValue = person.getAttribute('uid')
                attrEPPN = GluuCustomAttribute('edupersonprincipalname', uidValue + '@example.edu')
                attributes.add(attrEPPN)

                # Loop through each attribute in the current entry
                for attribute in attributes:
                    attrName = attribute.getName()

                    # The mapping in the Cache Refresh configuration page set employeeType to
                    # eduPersonScopedAffiliation(EPSA). This means that EPSA currently has an
                    # integer value instead of the value expected by Educause. It needs to be
                    # set to the correct value.
                    if ("edupersonscopedaffiliation" == StringHelper.toLowerCase(attrName)):
                        attrValue = attribute.getValue()
                        newEPSAValue = []

                        if (attrValue==1):
                            newEPSAValue.append('student@example.edu')
                        elif (attrValue==2):
                            newEPSAValue.append('faculty@example.edu')
                        elif (attrValue==3):
                            newEPSAValue.append('student@example.edu')
                            newEPSAValue.append('faculty@example.edu')
                        elif (attrValue==4):
                            newEPSAValue.append('staff@example.edu')
                        elif (attrValue==5):
                            newEPSAValue.append('staff@example.edu')
                            newEPSAValue.append('faculty@example.edu')

                        # Remove current attribute which is EPSA with an integer value
                        attributes.remove(attribute)
                        epsa = GluuAttribute('eduPersonScopedAffiliation', newEPSAValue)
                        attributes.add(epsa)
                return True

