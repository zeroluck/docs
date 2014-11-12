# Registration flow and customization

Registration workflow defines process of account creation through a "self-service" registration page.
There may be other ways of creating accounts: SCIM, Cache Refresh, User Management, Automatic Enrollment as part of custom authentication (Inbound SAML). They will not be covered in this document.

Registration Workflow starts when user access /register page and goes as:

1. User Opens /regiser
2. InitRegistration Script(s) runs
3. User Enters registration data
4. PreRegistration Script(s) runs
5. User registration data is saved to the database
6. PostRegistration Script(s) runs
7. User is redirected on a postRegistration landing page.

User request in 1. can contain url-encoded request parameters: /register?param1=data1&param2=data2. these parameters will be available in registration scripts.

InitRegistration Script in 2. runs before rendering of the page for the user and thus can be used to customize registration page according to the situation (including request parameters)

Data entered by user in 3. is subject to custom ajax validation based on regular expressions set for attributes in Attribute Management System.

PreRegistration Script in 4. is ran just before saving user data to the database, has access to all user data and can be used to make any last-minute changes to the registration data.

After 5. user can be used to access system.

PostRegistration Script in 6. can be used to do any post-processing necessary after the user is registered. For example call a third-party API.

After successful execution of PostRegistration Script user is redirected to the customizable landing page on which registration scripts can render arbitrary data to help notify user about registration process. By default this page is empty.

Registration workflow is customized at Registratiom Management page (Configuration->Registration Management)  