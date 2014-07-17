## Authentication Script

Interfaces:


        public interface ExternalAuthenticatorType {

                public boolean init(Map<String, SimpleCustomProperty> configurationAttributes);

                public boolean authenticate(Map<String, SimpleCustomProperty> configurationAttributes, Map<String, String[]> requestParameters, int step);

                public boolean prepareForStep(Map<String, SimpleCustomProperty> configurationAttributes, Map<String, String[]> requestParameters, int step);

                public int getCountAuthenticationSteps(Map<String, SimpleCustomProperty> configurationAttributes);

                public String getPageForStep(Map<String, SimpleCustomProperty> configurationAttributes, int step);

                public List<String> getExtraParametersForStep(Map<String, SimpleCustomProperty> configurationAttributes, int step);

        }


Sample Script


        from org.jboss.seam.security import Identity
        from org.xdi.oxauth.service.python.interfaces import ExternalAuthenticatorType
        from org.xdi.oxauth.service import UserService
        from org.xdi.util import StringHelper

        import java

        class ExternalAuthenticator(ExternalAuthenticatorType):
            def __init__(self, currentTimeMillis):
                self.currentTimeMillis = currentTimeMillis

            def init(self, configurationAttributes):
                return True

            def authenticate(self, configurationAttributes, requestParameters, step):
                if (step == 1):
                    print "Basic authenticate for step 1"

                    credentials = Identity.instance().getCredentials()
                    user_name = credentials.getUsername()
                    user_password = credentials.getPassword()

                    logged_in = False
                    if (StringHelper.isNotEmptyString(user_name) and StringHelper.isNotEmptyString(user_password)):
                        userService = UserService.instance()
                        logged_in = userService.authenticate(user_name, user_password)

                    if (not logged_in):
                        return False

                    return True
                else:
                    return False

            def prepareForStep(self, configurationAttributes, requestParameters, step):
                if (step == 1):
                    print "Basic prepare for Step 1"
                    return True
                else:
                    return False

            def getExtraParametersForStep(self, configurationAttributes, step):
                return None

            def getCountAuthenticationSteps(self, configurationAttributes):
                return 1

            def getPageForStep(self, configurationAttributes, step):
                return ""


