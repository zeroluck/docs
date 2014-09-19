# SAML

## Trust Relationship

_Trust Relationship_ is the mechanism of SAML based Single Sign On (SSO) establishment with any trusted party (Service Provider) from IdP. Please follow the succeeding steps to create a trust relationship.

### Add Relationship
![Add Trust Relationship](img/admin_saml_create.png)

Clicking on the Add Relationship button will open a new page. The Gluu Server Administrator must provide all relevant information regarding the Service Provider (SP) to establish Trust Relationship from the server.
![New TR](img/admin_saml_newTR.png)

* _Display Name:_ This is the name of the Trust Relationship and this should be unique for every trust relationship.

* _Description:_ The Gluu Server administrator can add a little description in this field along with the purpose and the SSO Link.

* _Metadata Type:_ There are four metadata types available in the Gluu Server that depend on the metadata of the trusted party.

  1. _File:_ If the SP has uploadable metadata in XML format, then this option is the recommended.
![Metadata type File](img/admin_saml_metadatafile.png)

  2. _URI:_ If the metadata of SP has url link and it is accessible through internet, then the Gluu Server Administrator is recommended to use this option.
![Metadata type URI](img/admin_saml_metadatauri.png)

  4. _Public Certificate:_ This option uploads the public certificate for SP server. Please note that the the CN (common name) of the certificate must maintain the Hostname of the SP server. If the SP does not have any certificate, then the Gluu IdP shall generate a certificate with 10 year validity for the SP.

  3. _Released:_ This option lists the required attributes that are released to the SP. The attributes can be dragged from the left panel.

  * The Gluu Server administrator will observe a confirmaiton page after the addition of a new TR (trust relationship). The screenshot does not contain any certificate for the demonstration purposes, but they are necessary.
![Added New Trust Relationship](img/admin_saml_addedTR.png)

If the SP requires custom relying party and/or custom MetadataFilter configuration, they can be achieved from the options provided in the Gluu Server.
