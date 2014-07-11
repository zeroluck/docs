## Authorization Script

Interfaces:


        public interface IPolicyExternalAuthorization {
            public boolean authorize(AuthorizationContext p_authorizationContext);
        }

        public interface IAuthorizationContext {
            String getClientClaim(String claimName);
            String getUserClaim(String claimName);
            String getUserClaimByLdapName(String ldapName);
            Integer getAuthLevel();
            String getAuthMode();
            String getIpAddress();
            boolean isInNetwork(String cidrNotation);
            RequesterPermissionToken getRPT();
            ResourceSetPermission getPermission();
            AuthorizationGrant getGrant(); // here return unmodifiable version of grant, e.g. to avoid new token creation
            HttpServletRequest getHttpRequest();
        }


**Python sample authorization script** (authorize only if user location claim equals to Austin)


        from org.xdi.oxauth.service.uma.authorization import IPolicyExternalAuthorization
        from org.xdi.util import StringHelper

        class PythonExternalAuthorization(IPolicyExternalAuthorization):

            def authorize(self, authorizationContext):

                print "authorizing..."

                if StringHelper.equalsIgnoreCase(authorizationContext.getUserClaim("locality"), "Austin"):
                    print "authorized"
                    return True

                return False



