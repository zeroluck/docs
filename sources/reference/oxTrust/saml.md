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

  * _Configure Metadata Filters:_ 
![Configure Metadata Filter](img/admin_saml_configmetadata.png)

Clicking on this option allows the Gluu Server Administrator to configure MetadataFilters in the Web UI(oxTrust).
![Metadata Filter](img/admin_saml_metadatafilter.png)

  * _Configure specific Relying Party:_ 
![Configure Relying Party](img/admin_saml_configrelying.png)

Clicking on this option allows the Gluu Server Administrator to modify various Relying Party Configurations such as SALM2SSO, SAML2AtttributeQuery, ShibbolethSSO etc through oxTrust.
![Config Relying Party](img/admin_saml_relyingparty.png)

    * _Federation:_ If the target SP is affiliated with any Federation server such as InCommon, NJEdge etc, then please select Federation from the Metadata type.
![Metadata Type](img/admin_saml_metadatatype.png)z

Select *Federation* in the Metadata Type and a drop-down menu  with the tile *Federation Title* shall appear. The desired federation can be selected from the drop-down menu. The screenshot below uses InCommon Federation as an example.
![Select Federation](img/admin_saml_federation.png)

After selecting the federation name, a new link titled *Click to select entity id* shall appear. Gluu Server Administrator can select all InCommon affiliated SP entityIDs from this link. THe screenshot below shows a demo SP entityID discovery page that will appear on clicking the link.
![EntityID discovery page](img/admin_saml_newentityid.png)

Gluu Server administrator can grab any SP entityID from *Filter* box. The screenshot below shows filtering for Educase entityID.
![Demo Screenshot Educase](img/admin_saml_entityiddemo.png)

Select the desired entityID and click *Done* followed by clocking on *Add* and the Trust Relationship with an InCommon affiliated SP shall be created.
