[TOC]
# Overview
Gluu Server supports only UMA protection for SCIM endpoints from version 2.4.0 onwards. 
A machine based authorization method is used to obtain the access tokens. SCIM/UMA is built
into the Gluu Server CE and does not require any special package or installation. Please checkout 
[Deployment Guides](../deployment/index.md) for installation instructions.

# Installation

* Install Gluu Server CE following the [Deployment Guides](../deployment/index.md) and 
remember to install `Asimba` while running the setup script.  The setup script prepares the 
configuration necessary for SCIM UMA RS endpoints and SCIM UMA RP client 
and [this template](https://github.com/GluuFederation/community-edition-setup/blob/master/templates/scim.ldif) 
is used. 

**Note:** The JWKS for RS and RP clients are put into the `./output/scim.ldif` file ready for SCIM configuration.
The `setup.properties.file` contains the RS and RP `JWKS.jason` in Base64 format.

* Use the following cmmand to extract OpenID SCIM RS and RP Client ID
` cat setup.properties.last | grep "scim_rs_client_id\|scim_rp_client_id"`

* Extract the JWKS from `setup.properties.last` and put it into `./output/scim-rp-openid-keys.jason` file.

# Configuration

* Enable SCIM from Organization Configuration
![image](https://raw.githubusercontent.com/GluuFederation/docs/2.4/sources/img/2.4/admin_config_system.png)

* oxTrust SCIM UMA configuration is automacially updated while running the `setup.py` and the correct values are setup 
in the [oxtrust-config.json](https://github.com/GluuFederation/community-edition-setup/blob/master/templates/oxtrust-config.json#L122) file.
```
  "umaIssuer":"https://%(hostname)s",
  "umaClientId":"%(scim_rs_client_id)s",
  "umaClientKeyId":"",
  "umaResourceId":"1447184268430",
  "umaScope":"https://%(hostname)s/oxauth/seam/resource/restv1/uma/scopes/scim_access"
```

* Update the `umaClientID` with the `keyID` from `scim-rp-openid-keys.jason` file; if it is not updated, the first key from 
the file is used.

# Testing SCIM UMA
The following is a sample code that can be run to test the configured SCIM UMA Gluu CE.

* Replace `scim_rp_client_id` and `scim_rp_client_jwks_key_id` and run the code.

```
package gluu.scim.client.dev.local;
 
import gluu.scim.client.ScimClient;
import gluu.scim.client.ScimResponse;
import gluu.scim2.client.Scim2Client;
 
import java.io.File;
import java.io.IOException;
 
import javax.ws.rs.core.MediaType;
import javax.xml.bind.JAXBException;
 
import org.apache.commons.io.FileUtils;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
 
public class TestScimClient {
 
	private static void testScim1Uma(String domain, String umaMetaDataUrl, String umaAatClientId, String umaAatClientJwks, String umaAatClientKeyId) throws IOException, JsonGenerationException, JsonMappingException, JAXBException {
        final ScimClient scimClient = ScimClient.umaInstance(domain, umaMetaDataUrl, umaAatClientId, umaAatClientJwks, umaAatClientKeyId);
 
        ScimResponse response = scimClient.personSearch("uid", "admin", MediaType.APPLICATION_JSON);
		System.out.println("SCIM1 " + response.getResponseBodyString());
	}
 
	private static void testScim2Uma(String domain, String umaMetaDataUrl, String umaAatClientId, String umaAatClientJwks, String umaAatClientKeyId) throws IOException, JsonGenerationException, JsonMappingException, JAXBException {
        final Scim2Client scim2Client = Scim2Client.umaInstance(domain, umaMetaDataUrl, umaAatClientId, umaAatClientJwks, umaAatClientKeyId);
 
        ScimResponse response = scim2Client.personSearch("uid", "admin", MediaType.APPLICATION_JSON);
		System.out.println("SCIM2: " + response.getResponseBodyString());
	}
 
	public static void main(String[] args) throws IOException, JAXBException {
		final String domain = "https://c67.gluu.info/identity/seam/resource/restv1";
		final String umaMetaDataUrl = "https://c67.gluu.info/.well-known/uma-configuration";
		final String umaAatClientId = "@!A410.188A.95DD.EA5A!0001!3A1E.BAA5!0008!5870.A795";
 
		final String umaAatClientJwks = FileUtils.readFileToString(new File("D:\\Development\\test_data\\scim\\scim-rp-openid-keys.json"));;
		final String umaAatClientKeyId = "6a0fb7eb-a197-412b-a0a0-794999ac0b31";
 
		testScim1Uma(domain, umaMetaDataUrl, umaAatClientId, umaAatClientJwks, umaAatClientKeyId);
    	testScim2Uma(domain, umaMetaDataUrl, umaAatClientId, umaAatClientJwks, umaAatClientKeyId);
    }
```
