# oxD Communication Protocol

**state:** in progress (not finished yet)

Communication is made in JSON format as request-response model. Since there is no HTTP involved command types, statuses are built-in in format itself as:

	
	Request:
	{
	    "command":"`<command type>`",
	    "params": {
	        `<parameters of command>`
	    }
	}
	
	Response:
	{
	    "status":"`<status of command: ok or error>`",
	    "data":{
	        `<response data>`
	    }
	}


oxD must provide:
 1.  simultaneous requests handling for multiple plugins (one oxD for multiple apache plugins);
 2.  one apache plugin can send multiple commands sequentially without input steam closing (resource reusing - better performance)

Streams are considered as characters streams (according to [Reader](http://docs.oracle.com/javase/6/docs/api/java/io/Reader.html)). To distinguish different commands sent from the same plugin (within the same session) length prefix is used. First 4 characters are always length of command that follows directly after it. (Example: 0154 - command consists of 154 characters). 

## Command Response Status

Possible statuses are: ok, error.
If error returned then "data" part contains error description.

**Example of error response**

	
	{
	    "status":"error",
	    "data":{
	        "error":"`<error code, e.g. authorization_server_not_found,>`"
	        "error_description":`<error description as human-readable text>`
	    }
	}


## Command Types

Command types:
 1.  [Register client](#Register client) - register_client
 2.  [Client read](#Client read) - client_read
 3.  [Obtain PAT](#Obtain PAT) - obtain_pat
 4.  [Register resource](#Register resource) - register_resource
 5.  [Check status of RPT](#Check status of RPT) - rpt_status
 6.  [Check status of ID Token](#Check status of ID Token) - id_token_status
 7.  [Check status of Access Token](#Check status of Access Token) - access_token_status
 8.  [Register permission ticket](#Register permission ticket) - register_ticket
 9.  [Discovery](#Discovery) - discovery

### Register client

Client registered by oxd has fallback values for following parameters if they are not provided in request :

*  application_type: web;

*  response_types: code, id_token, token

**Pattern**

	
	Request:
	{
	    "command":"register_client",
	    "params": {
	        "discovery_url":"`<discovery url>`",
	        "redirect_url":"`<redirect url>`",
	        "logout_redirect_url":"`<logout redirect url>`",
	        "client_name":"`<client name>`",
	        "response_types":"`<response types>`",
	        "app_type":"`<application type>`",
	        "grant_types":"`<grant types>`",
	        "contacts":"`<contacts>`",
	        "jwks_uri":"`<jwks uri>`"        
	    }
	}
	
	Response:
	{
	    "status":"`<command status>`",
	    "data":{
	        "client_id":"`<client id>`",
	        "client_secret":"`<client secret>`",
	        "registration_access_token":"`<registration access token>`",
	        "client_secret_expires_at": "`<client secret expiration time>`",
	        "registration_client_uri":"`<registration client uri>`",
	        "client_id_issued_at":"`<client id issued at>`"        
	    }
	}


**Sample**

	
	Sample request:
	{
	    "command":"register_client",
	    "params": {
	        "discovery_url":"https://seed.gluu.org/.well-known/openid-configuration",
	        "redirect_url":"https://rs.gluu.org/resources",
	        "client_name":"oxD Client",
	        "response_types":"code id_token token",
	        "app_type":"web",
	        "grant_types":"authorization_code implicit",
	        "contacts":"mike@gluu.org yuriy@gluu.org",
	        "jwks_uri":"https://seed.gluu.org/jwks"   
	    }
	}
	
	Sample response:
	
	{
	    "status":"ok",
	    "data":{
	        "client_id":"@!1111!0008!0001",
	        "client_secret":"ZJYCqe3GGRvdrudKyZS0XhGv_Z45DuKhCUk0gBR1vZk",
	        "registration_access_token":"this.is.an.access.token.value.ffx83",
	        "client_secret_expires_at": 1577858400,
	        "registration_client_uri":"https://seed.gluu.org/oxauth/rest1/register?client_id=23523534",
	        "client_id_issued_at": 1577858300      
	    }
	}


### Client read

**Pattern**

	
	Request:
	{
	    "command":"client_read",
	    "params": {
	        "registration_client_uri":"`<registration client uri>`",
	        "registration_access_token":"`<registration access token>`"        
	    }
	}
	
	Response:
	{
	    "status":"`<command status>`",
	    "data":{
	        "client_id":"`<client id>`",
	        "client_secret":"`<client secret>`",
	        "registration_access_token":"`<registration access token>`",
	        "client_secret_expires_at": "`<client secret expiration time>`",
	        "registration_client_uri":"`<registration client uri>`",
	        "client_id_issued_at":"`<client id issued at>`"        
	    }
	}


**Sample**

	
	Sample request:
	{
	    "command":"client_read",
	    "params": {
	        "registration_client_uri":"https://seed.gluu.org/oxauth/rest1/register?client_id=23523534",
	        "registration_access_token":"this.is.an.access.token.value.ffx83"    
	    }
	}
	
	Sample response:
	
	{
	    "status":"ok",
	    "data":{
	        "client_id":"@!1111!0008!0001",
	        "client_secret":"ZJYCqe3GGRvdrudKyZS0XhGv_Z45DuKhCUk0gBR1vZk",
	        "registration_access_token":"this.is.an.access.token.value.ffx83",
	        "client_secret_expires_at": 1577858400,
	        "registration_client_uri":"https://seed.gluu.org/oxauth/rest1/register?client_id=23523534",
	        "client_id_issued_at": 1577858300      
	    }
	}


### Obtain PAT

**Pattern**

	
	Request:
	{
	    "command":"obtain_pat",
	    "params": {
	        "discovery_url":"`<discovery url>`",
	        "uma_discovery_url":"`<uma discovery url>`",
	        "redirect_url":"`<redirect url>`",
	        "client_id":"`<client id e.g. @!1111!0008!0001>`",
	        "client_secret":"`<client secret>`",    
	        "user_id":"`<user id>`",
	        "user_secret":"`<user secret>`";    
	    }
	}
	
	Response:
	{
	    "status":"ok",
	    "data": {
	        "pat_token":"`<pat token>`",
	        "expires_in_seconds":"`<expires in seconds>`",
	        "pat_refresh_token":"`<pat refresh token>`",
	        "authorization_code:"`<authorization code>`",
	        "scope":"`<scope>`"
	    }
	}


**Sample**

	
	Sample Request:
	{
	    "command":"obtain_pat",
	    "params": {
	        "discovery_url":"https://seed.gluu.org/.well-known/openid-configuration",
	        "uma_discovery_url":"http://seed.gluu.org/.well-known/uma-configuration",
	        "redirect_url":"https://rs.gluu.org/resources",
	        "client_id":"@!1111!0008!0068.3E20",
	        "client_secret":"32c2fb17-409d-48a2-b793-a639c8ac6cb2",    
	        "user_id":"yuriy",
	        "user_secret":"secret";    
	    }
	}
	
	Sample Response:
	{
	    "status":"ok",
	    "data": {
	        "pat_token":"eyJ0eXAiOiJKV1MiLCJhbGciOiJSUzI1NiIsImprdSI6Imh0dHBzOi8vc2VlZC5nbHV1L",
	        "expires_in_seconds":3599,
	        "pat_refresh_token":"UzI1NiIsImprdSI6Imh0dHBzOi8vc2VlZC5nbHV",
	        "authorization_code:"1e436c1a-6e96-4d98-81d6-8f4019ab4636",
	        "scope":"http://docs.kantarainitiative.org/uma/scopes/prot.json"
	    }
	}


### Obtain AAT

**Pattern**

	
	Request:
	{
	    "command":"obtain_aat",
	    "params": {
	        "discovery_url":"`<discovery url>`",
	        "uma_discovery_url":"`<uma discovery url>`",
	        "redirect_url":"`<redirect url>`",
	        "client_id":"`<client id e.g. @!1111!0008!0001>`",
	        "client_secret":"`<client secret>`",    
	        "user_id":"`<user id>`",
	        "user_secret":"`<user secret>`";    
	    }
	}
	
	Response:
	{
	    "status":"ok",
	    "data": {
	        "aat_token":"`<aat token>`",
	        "expires_in_seconds":"`<expires in seconds>`",
	        "aat_refresh_token":"`<aat refresh token>`",
	        "authorization_code:"`<authorization code>`",
	        "scope":"`<scope>`"
	    }
	}


**Sample**

	
	Sample Request:
	{
	    "command":"obtain_aat",
	    "params": {
	        "discovery_url":"https://seed.gluu.org/.well-known/openid-configuration",
	        "uma_discovery_url":"http://seed.gluu.org/.well-known/uma-configuration",
	        "redirect_url":"https://rs.gluu.org/resources",
	        "client_id":"@!1111!0008!0068.3E20",
	        "client_secret":"32c2fb17-409d-48a2-b793-a639c8ac6cb2",    
	        "user_id":"yuriy",
	        "user_secret":"secret";    
	    }
	}
	
	Sample Response:
	{
	    "status":"ok",
	    "data": {
	        "aat_token":"eyJ0eXAiOiJKV1MiLCJhbGciOiJSUzI1NiIsImprdSI6Imh0dHBzOi8vc2VlZC5nbHV1L",
	        "expires_in_seconds":3599,
	        "aat_refresh_token":"UzI1NiIsImprdSI6Imh0dHBzOi8vc2VlZC5nbHV",
	        "authorization_code:"1e436c1a-6e96-4d98-81d6-8f4019ab4636",
	        "scope":"http://docs.kantarainitiative.org/uma/scopes/prot.json"
	    }
	}


### Obtain RPT

**Pattern**

	
	Request:
	{
	    "command":"obtain_rpt",
	    "params": {
	        "aat_token":"`<AAT token>`",
	        "am_host":"`<AS host>`"
	    }
	}
	
	Response:
	{
	    "status":"ok",
	    "data": {
	        "rpt_token":"`<rpt token>`"
	    }
	}


**Sample**

	
	Sample Request:
	{
	    "command":"obtain_rpt",
	    "params": {
	        "aat_token":"eyJ0eXAiOiJKV1MiLCJhbGciOiJSUzI1NiIsImprdSI6Imh0dHBzOi8vc2VlZC5nbHV1L",
	        "am_host":"seed.gluu.org"  
	    }
	}
	
	Sample Response:
	{
	    "status":"ok",
	    "data": {
	        "rpt_token":"32c2fb17-409d-48a2-b793-a639c8ac6cb2"
	    }
	}


### Authorize RPT

**Pattern**

	
	Request:
	{
	    "command":"authorize_rpt",
	    "params": {
	        "aat_token":"`<AAT token>`",
	        "rpt_token":"`<RPT token>`"
	        "am_host":"`<AS host>`",
	        "ticket":"`<permission ticket>`",
	        "claims":{`<user claims>`}
	    }
	}
	
	OK Response (authorized):
	{
	    "status":"ok",
	    "data":null
	}
	
	Error Response (not authorized):
	{
	    "status":"error",
	    "data":{
	        "error":"`<error code, e.g. not_allowed,>`"
	        "error_description":`<not allowed to authorize rpt>`
	    }
	}


**Sample**

	
	Sample Request:
	{
	    "command":"authorize_rpt",
	    "params": {
	        "aat_token":"eyJ0eXAiOiJKV1MiLCJhbGciOiJSUzI1NiIsImprdSI6Imh0dHBzOi8vc2VlZC5nbHV1L",
	        "rpt_token":"fb17-409d-48a2-b793-a639c"
	        "am_host":"seed.gluu.org",
	        "ticket":"48a2-b793-a639c8ac6cb2",
	        "claims":{"uid":["user1"],"email":["user1@gluu.org","user1@gmail.com"]}
	    }
	}
	
	Sample Response:
	{
	    "status":"ok",
	    "data":null
	}


### Register resource

**Pattern**

	
	Request:
	{
	    "command":"register_resource",
	    "params": {
	        "uma_discovery_url":"`<uma discovery url>`",
	        "pat":"`<pat token>`",
	        "name": "`<name>`",
	        "scopes": [
	            `<array of scopes for this resource>`
	        ]
	    }   
	}
	
	Response:
	{
	    "status":"`<status of command>`",
	    "data":{
	        "_id": "`<id of created resource set>`",
	        "_rev": "<ETag of created resource set"
	    }
	}


**Sample**

	
	Sample Request:
	{
	    "command":"register_resource",
	    "params": {
	        "uma_discovery_url":"https://seed.gluu.org/.well-known/uma-configuration",
	        "pat":"eyJ0eXAiOiJKV1MiLCJhbGciOiJSUzI1NiIsImprdSI6Imh0dHBzOi8vc2VlZC5nbHV1L",
	        "name": "My Resource",
	        "scopes": [
	            "http://photoz.example.com/dev/scopes/view",
	            "http://photoz.example.com/dev/scopes/all"
	        ]
	    }   
	}
	
	Sample Response:
	{
	    "status":"ok",
	    "data":{
	        "status": "created",
	        "_id": "1366810445313",
	        "_rev": "1"
	    }
	}


### Check status of RPT

**Pattern**

	
	Request:
	{
	    "command":"rpt_status",
	    "params": {
	        "uma_discovery_url":"`<uma discovery url>`"
	        "pat": "`<pat>`",
	        "rpt": "`<rpt>`"
	    }   
	}
	
	Response:
	{
	    "status":"ok",
	    "data":{
	        "active": "`<whether rpt is active (true|false)>`",
	        "expires_at": `<rpt expires at (date)>`,
	        "issued_at": `<rpt issued at (date)>`,
	        "permissions":[
	            `<permissions of rpt>`
	        ]
	    }
	}


**Sample**

	
	Sample request:
	{
	    "command":"rpt_status",
	    "params": {
	        "uma_discovery_url":"https://seed.gluu.org/.well-known/uma-configuration",
	        "pat": "eyJ0eXAiOiJKV1MiLCJhbGciOiJSUzI1NiIsImprdSI6Imh0",
	        "rpt": "KV1MiLCJhbGciOiJSUzI1NiIsImprdSI6Imh0dHBzOi8vc2VlZC5nbHV1Lm9yZy9veGF1dGgvc2VhbS9yZXNvdXJjZS9yZXN0djEvb3hhd"
	    }   
	}
	
	Sample response:
	
	{
	    "status":"ok",
	    "data":{
	        "active": true,
	        "expires_at": 1256928856,
	        "issued_at": 1256923456,
	        "permissions":[
	            {
	                 "resource_set_id": "112210f47de98100",
	                 "scopes": [
	                     "http://photoz.example.com/dev/actions/view",
	                     "http://photoz.example.com/dev/actions/all"
	                 ],
	                 "expires_at" : "1256923456"
	            }
	        ]
	    }
	}


### Check status of ID Token

**Pattern**

	
	Request:
	{
	    "command":"id_token_status",
	    "params": {
	        "discovery_url":"`<discovery url>`",
	        "id_token": "`<id_token>`"
	    }   
	}
	
	Response:
	{
	    "status":"ok",
	    "data":{
	        "active": "`<whether id token is active (true|false)>`",
	        "expires_at": `<id token expires at (date)>`,
	        "issued_at": `<id token issued at (date)>`,
	        "claims": {
	            `<claim name>`:[`<claim values>`]
	        }
	    }
	}


**Sample**

	
	Sample request:
	{
	    "command":"id_token_status",
	    "params": {
	        "discovery_url":"https://seed.gluu.org/.well-known/openid-configuration",
	        "id_token": "eyJ0eXAiOiJKV1MiLCJhbGciOiJSUzI1NiIsImprdSI6Imh0"
	    }   
	}
	
	Sample response:
	
	{
	    "status":"ok",
	    "data":{
	        "active": true,
	        "expires_at": 1256928856,
	        "issued_at": 1256923456,
	        "claims": {
	            "oxValidationURI": [
	                "https://seed.gluu.org/oxauth/opiframe.seam"
	             ],
	            "exp": [
	                "1383836968"
	            ],
	            "sub": [
	                "mike"
	            ],
	            "at_hash": [
	                "fMdvIEy7RjdFy4Q-mGXOWw"
	            ],
	            "aud": [
	                "@!1111!0008!FF81!2D39"
	            ],
	            "iss": [
	                "https://seed.gluu.org"
	            ],
	            "oxOpenIDConnectVersion": [
	                "openidconnect-1.0"
	            ],
	            "iat": [
	                "1383833368"
	            ],
	            "oxInum": [
	                "@!1111!0000!D4E7"
	            ]
	        }
	    }
	}


### Check status of Access Token


**Pattern**

	
	Request:
	{
	    "command":"access_token_status",
	    "params": {
	        "discovery_url":"`<discovery url>`",
	        "id_token": "`<id_token>`"
	        "access_token": "`<access_token>`"
	    }   
	}
	
	Response:
	{
	    "status":"ok",
	    "data":{
	        "active": "`<whether access token is active (true|false)>`",
	        "expires_at": `<access token expires at (date)>`,
	        "issued_at": `<access token issued at (date)>`
	    }
	}


**Sample**

	
	Sample request:
	{
	    "command":"access_token_status",
	    "params": {     
	        "discovery_url":"https://seed.gluu.org/.well-known/openid-configuration",   
	        "id_token":"NiIsImprdSI6Imh0dHBzOi8vc2VlZC5nbHV1Lm9yZy9veGF1dGgvc2VhbS9yZXNvdXJjZS9yZ"
	        "access_token": "KV1MiLCJhbGciOiJSUzI1NiIsImprdSI6Imh0dHBzOi8vc2VlZC5nbHV1Lm9yZy9veGF1dGgvc2VhbS9yZXNvdXJjZS9yZXN0djEvb3hhd"
	    }   
	}
	
	Sample response:
	
	{
	    "status":"ok",
	    "data":{
	        "active": true,
	        "expires_at": 1256928856,
	        "issued_at": 1256923456
	    }
	}


### Register permission ticket

**Pattern**

	
	Request:
	{
	    "command":"register_ticket",
	    "params": {
	        "uma_discovery_url":"`<uma discovery url>`",
	        "pat": "`<pat>`",
	        "am_host": "`<Authorization Server host e.g. seed.gluu.org>`"
	        "rs_host": "`<Resource Server host>`",
	        "resource_set_id":"`<resource set id>`",
	        "scopes": [
	            `<scopes uris required by this permission>`
	        ],
	        "request_http_method":"`<http method>`",
	        "request_url":"`<request url>`"
	    }   
	}
	
	Response:
	{
	    "status":"`<status>`",
	    "data":{
	        "ticket": "`<ticket>`",
	    }
	}


**Sample**

	
	Sample request:
	{
	    "command":"register_ticket",
	    "params": {
	        "uma_discovery_url":"https://seed.gluu.org/.well-known/uma-configuration",
	        "pat": "eyJ0eXAiOiJKV1MiLCJhbGciOiJSUzI1NiIsImprdSI6Imh0",
	        "am_host": "seed.gluu.org"
	        "rs_host": "rs.gluu.org",
	        "resource_set_id":"1366810445313",
	        "scopes": [
	            "http://photoz.example.com/dev/scopes/view",
	            "http://photoz.example.com/dev/scopes/add"
	        ],
	        "request_http_method":"DELETE",
	        "request_url":"http://example.com/object/1234"
	        
	    }   
	}
	
	Sample response:
	{
	    "status":"ok",
	    "data":{
	        "ticket": "mcvmstkrkrdfskdjdasldf",
	    }
	}
	
	


### Discovery

**Pattern**

	
	Request:
	{
	    "command":"discovery",
	    "params": {
	        "discovery_url":"`<discovery url>`"
	    }
	}
	
	Response:
	{
	    "status":"`<command status>`",
	    "data":{
	        `<discovery data>`
	    }
	}


**Sample**

	
	Request:
	{
	    "command":"discovery",
	    "params": {
	        "discovery_url":"https://seed.gluu.org/.well-known/openid-configuration"
	    }
	}
	
	Response:
	{
	    "data": {
	        "issuer": "https://seed.gluu.org",
	        "authorization_endpoint": "https://seed.gluu.org/oxauth/seam/resource/restv1/oxauth/authorize",
	        "token_endpoint": "https://seed.gluu.org/oxauth/seam/resource/restv1/oxauth/token",
	        "userinfo_endpoint": "https://seed.gluu.org/oxauth/seam/resource/restv1/oxauth/userinfo",
	        "clientinfo_endpoint": "https://seed.gluu.org/oxauth/seam/resource/restv1/oxauth/clientinfo",
	        "check_session_iframe": "https://seed.gluu.org/oxauth/seam/resource/restv1/oxauth/check_session",
	        "end_session_endpoint": "https://seed.gluu.org/oxauth/seam/resource/restv1/oxauth/end_session",
	        "jwks_uri": "https://seed.gluu.org/oxauth/seam/resource/restv1/oxauth/jwks",
	        "registration_endpoint": "https://seed.gluu.org/oxauth/seam/resource/restv1/oxauth/register",
	        "validate_token_endpoint": "https://seed.gluu.org/oxauth/seam/resource/restv1/oxauth/validate",
	        "federation_metadata_endpoint": "https://seed.gluu.org/oxauth/seam/resource/restv1/oxauth/federationmetadata",
	        "federation_endpoint": "https://seed.gluu.org/oxauth/seam/resource/restv1/oxauth/federation",
	        "id_generation_endpoint": "https://seed.gluu.org/oxauth/seam/resource/restv1/id",
	        "scopes_supported": [
	            "openid",
	            "address",
	            "clientinfo",
	            "http://docs.kantarainitiative.org/uma/scopes/prot.json",
	            "profile",
	            "phone",
	            "http://docs.kantarainitiative.org/uma/scopes/authz.json",
	            "email"
	        ],
	        "response_types_supported": [
	            "code",
	            "code id_token",
	            "token",
	            "token id_token",
	            "code token",
	            "code token id_token",
	            "id_token"
	        ],
	        "grant_types_supported": [
	            "authorization_code",
	            "implicit",
	            "urn:ietf:params:oauth:grant-type:jwt-bearer"
	        ],
	        "subject_types_supported": [
	            "public",
	            "pairwise"
	        ],
	        ....`<SAVE SPACE: remove part of discovery response, see docs to take a look to full response>`................
	        "service_documentation": "http://ox.gluu.org/doku.php?id=oxauth:home",
	        "claims_locales_supported": ["en-US"],
	            "ui_locales_supported": ["en-US"],
	        "claims_parameter_supported": true,
	        "request_parameter_supported": true,
	        "request_uri_parameter_supported": true,
	        "require_request_uri_registration": false,
	        "op_policy_uri": "http://ox.gluu.org/doku.php?id=oxauth:policy",
	        "op_tos_uri": "http://ox.gluu.org/doku.php?id=oxauth:tos"
	    }
	
	}



