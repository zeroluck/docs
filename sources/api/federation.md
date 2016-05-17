# Federation Data API
This API provides an interface for Federation Data REST web services.
This endpoint provides the ability to send JOIN to federation requests.
## Path
`/oxauth/federation`

### requestJoinGet

|Parameter|Data Type|
|---------|---------|
|federation_id|string|
|entity_type|string|
|display_name|string|
|op_id|string|
|domain|string|
redirect_uri|string|
|x509_url|string|
x509_pem|string|

