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
The `setup.properties.file` contains the RS and RP JWKS in Base64 format.

* Use the following command to extract OpenID SCIM RS and RP Client ID
` cat setup.properties.last | grep "scim_rs_client_id\|scim_rp_client_id"`

* The UMA SCIM client requires JWKS, so the setup script extracts the JWKS from `setup.properties.last` and puts it into the `./output/scim-rp.jks` file.

**_NOTE:_ For versions before v2.4.4, the JWKS is put in the `./output/scim-rp-openid-keys.json` file instead.**

# Configuration

* Enable SCIM from Organization Configuration

![image](/sources/img/2.4/enable-scim.png)

* oxTrust SCIM UMA configuration is automatically updated while running the `setup.py` and the correct values are setup 
in the [oxtrust-config.json](https://github.com/GluuFederation/community-edition-setup/blob/master/templates/oxtrust-config.json#L122) file.
```
  "umaIssuer":"https://%(hostname)s",
  "umaClientId":"%(scim_rs_client_id)s",
  "umaClientKeyId":"",
  "umaResourceId":"1447184268430",
  "umaScope":"https://%(hostname)s/oxauth/seam/resource/restv1/uma/scopes/scim_access",
  "umaClientKeyStoreFile":"%(scim_rs_client_jks_fn)s",
  "umaClientKeyStorePassword":"%(scim_rs_client_jks_pass_encoded)s",
```

* `umaClientKeyId` can be updated with the `alias` from `scim-rp.jks` file; if it is not updated, the first key from the file is used automatically.

# Testing SCIM UMA
The following is a sample code that can be run to test the configured SCIM UMA Gluu CE. It uses [SCIM-Client](https://github.com/GluuFederation/SCIM-Client), a Java library also developed by Gluu intended for client applications.

* If you are using Maven, below is how to add SCIM-Client to your project:
```
<repositories>
  <repository>
    <id>gluu</id>
    <name>Gluu repository</name>
    <url>http://ox.gluu.org/maven</url>
  </repository>
</repositories>
...
<dependency>
  <groupId>gluu.scim.client</groupId>
  <artifactId>SCIM-Client</artifactId>
  <version>${scim.client.version}</version>
</dependency>
```

* Add your domain's SSL certificate to the JRE's `cacerts` certificate key store where your client application will run. There are lots of articles around the Web on how to do this.

* Replace the UMA parameters and run the code.

```

package gluu.scim.client.dev.local;
 
import gluu.scim.client.ScimClient;
import gluu.scim.client.ScimResponse;
import gluu.scim2.client.Scim2Client;
 
import java.io.IOException;
 
import javax.ws.rs.core.MediaType;
import javax.xml.bind.JAXBException;
 
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
 
public class TestScimClient {
 
	private static void testScim1Uma(String domain, String umaMetaDataUrl, String umaAatClientId, String umaAatClientJksPath, String umaAatClientJksPassword, String umaAatClientKeyId) throws IOException, JsonGenerationException, JsonMappingException, JAXBException {
	
		final ScimClient scimClient = ScimClient.umaInstance(domain, umaMetaDataUrl, umaAatClientId, umaAatClientJksPath, umaAatClientJksPassword, umaAatClientKeyId);
 
		ScimResponse response = scimClient.personSearch("uid", "admin", MediaType.APPLICATION_JSON);
		System.out.println("SCIM1 " + response.getResponseBodyString());
	}
 
	private static void testScim2Uma(String domain, String umaMetaDataUrl, String umaAatClientId, String umaAatClientJksPath, String umaAatClientJksPassword, String umaAatClientKeyId) throws IOException, JsonGenerationException, JsonMappingException, JAXBException {
	
		final Scim2Client scim2Client = Scim2Client.umaInstance(domain, umaMetaDataUrl, umaAatClientId, umaAatClientJksPath, umaAatClientJksPassword, umaAatClientKeyId);
 
		String filter = "userName eq \"admin\"";
		ScimResponse response = scim2Client.searchUsers(filter, 1, 1, "", "", null);
		System.out.println("SCIM2: " + response.getResponseBodyString());
	}
 
	public static void main(String[] args) throws IOException, JAXBException {
	
		final String domain = "https://c67.gluu.info/identity/seam/resource/restv1";
		final String umaMetaDataUrl = "https://c67.gluu.info/.well-known/uma-configuration";
		final String umaAatClientId = "@!A410.188A.95DD.EA5A!0001!3A1E.BAA5!0008!5870.A795";
 
		final String umaAatClientJksPath = "D:\\Development\\test_data\\scim\\scim-rp.jks";
		final String umaAatClientJksPassword = "secret";
		final String umaAatClientKeyId = "";
 
		testScim1Uma(domain, umaMetaDataUrl, umaAatClientId, umaAatClientJksPath, umaAatClientJksPassword, umaAatClientKeyId);
		testScim2Uma(domain, umaMetaDataUrl, umaAatClientId, umaAatClientJksPath, umaAatClientJksPassword, umaAatClientKeyId);
    }
}

```
