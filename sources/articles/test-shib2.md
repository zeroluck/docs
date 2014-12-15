# TestShib2 Testing For Gluu Server

## Trust Relationship in IdP

It is necessary to create a Trust Relationship in the IdP for TestShib2.

1. Log into the Gluu IdP as an admin user.

2. Click on SAML --> Trust Relationships

![SAML TR](img/testshib_samltr.png)

3. To create a new Trust Relationship, click on the "Add Relationship" button.

![Add TR](img/testshib_addtr.png)

 (a) Configuration

      i. Display Name: TestShib2 testing

     ii. Description: TestShib2 TR

    iii. Metadata type: URL

     iv. Provide TestShib2 XML metadata link: http://www.testshib.org/metadata/testshib-providers.xml

      v. Release Attributes: First Name, Username, "eduPerson TargetedID" if required and released in IdP.

