# ID Generation Script 

Interface:


        public interface IdGenerator {

            /**

             * Generates id.
             *
             * @param p_idType   id type : use to specify entity type, i.e. person, client
             * @param p_idPrefix id prefix : If you want to prefix all ids, use this, otherwise pass ""
             * @return generated id as string
             */
            public String generateId(String p_idType, String p_idPrefix);
        }


Sample Script:


        import uuid

        class ExampleDomainUniqueIdPolicyClass(IdGenerator):
            def generateId(self, entityType, prefix):
                print "Generating %s ID for prefix %s" % entityType, prefix
                # make a UUID using an MD5 hash of a namespace UUID and a name
                id = uuid.uuid3(uuid.NAMESPACE_DNS, 'example.co')
                return "%s%s" % (prefix, id)

