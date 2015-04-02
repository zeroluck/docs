The Gluu Server was designed to be very flexible. Gluu Server admins can use Jython interception scripts to customize behavior.

Jython was chosen because an interpreted language facilitates dynamic creation of business logic, and makes it easier to distribute this logic to a cluster of Gluu servers.

Another advantage of Jython was that developers can use either Java or Python classes. Combined with the option of calling web services from Python or Java, this enables the Gluu Server to support any business-driven policy requirement.

There are currently 8 options that can be customized by using interception scripts. Click on the links below to see samples of each script.

- [Application Session Management](./sample-application-session-script.py)
- [Authentication](./sample-authentication-script.py)
- [Authorization](./sample-uma-authorization-script.py)
- [Cache Refresh](./sample-cache-refresh-script.py)
- [Client Registration](./sample-client-registration-script)
- [ID Generation](./sample-id-generation.py)
- [Update User](./sample-update-user-script.py)
- [User Registration](./sample-user-registration.py)
