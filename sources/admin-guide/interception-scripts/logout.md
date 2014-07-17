## Logout

Interface:


        public interface CustomLogoutScript{

            /**

             * Provides an interception to insert domain specific logic when a person logs out,
             * such as logout to backend IDPs.
             *
             * @param p_idType   id type : use to specify entity type, i.e. person, client
             * @return int result code
             */
            public String logout(String message);
        }


Sample Script:


        import myIDP

        class ExampleDomainLogout(CustomLogoutScript):
            def logout(self, message):
                print "Executing %s" % message
                try:
                    myIDP.logout()
                except Exception, err:
                    print Exception, err
                    return 1
                return 0

