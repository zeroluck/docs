## SCIM 2.0

### SCIM 2.0 Specifications

You can see the detailed SCIM 2.0 specification documents here:

[System for Cross-domain Identity Management: Core Schema](https://tools.ietf.org/html/rfc7643)

[System for Cross-domain Identity Management: Protocol](https://tools.ietf.org/html/rfc7644)

### SCIM 2.0 Endpoints

- [User Endpoint](#user-endpoint)
- [Group Endpoint](#group-endpoint)
- [Bulk Operation Endpoint](#bulk-operation-endpoint)

### SCIM 2.0 Definitions
- [Definitions](#definitions)

- - -

## User Endpoint

### `<domain root>/identity/seam/resource/restv1/scim/v2/Users`

### GET

<a id="searchUsers">Search Users</a>

Returns a list of users (https://tools.ietf.org/html/rfc7644#section-3.4.2.2).

#### Security

* UMA (default)
* OAuth2 Access Token (Test Mode)

#### Request

**Content-Type:** `application/scim+json`, `application/json`

##### Parameters

<table border="1">
    <tr>
        <th>Name</th>
        <th>Located in</th>
        <th>Required</th>
        <th>Description</th>
        <th>Default</th>
        <th>Schema</th>
    </tr>
    <tr>
        <th>Authorization</th>
        <td>header</td>
        <td>yes (default)</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>access_token</th>
        <td>query</td>
        <td>yes (if "Test Mode" is enabled)</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>filter</th>
        <td>query</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>startIndex</th>
        <td>query</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>count</th>
        <td>query</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>sortBy</th>
        <td>query</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>sortOrder</th>
        <td>query</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>attributes</th>
        <td>query</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string array</td>
    </tr>
</table>

#### Response

**Content-Type:** `application/scim+json`, `application/json`

| Status Code | Reason      | Response Model |
|-------------|-------------|----------------|
| 200    | successful operation | <a href="#/definitions/ListResponse">ListResponse</a>|

### POST

<a id="createUser">Create User</a>

Creates a user (https://tools.ietf.org/html/rfc7644#section-3.3).

#### Security

* UMA (default)
* OAuth2 Access Token (Test Mode)

#### Request

**Content-Type:** `application/scim+json`, `application/json`

##### Parameters

<table border="1">
    <tr>
        <th>Name</th>
        <th>Located in</th>
        <th>Required</th>
        <th>Description</th>
        <th>Default</th>
        <th>Schema</th>
    </tr>
    <tr>
        <th>Authorization</th>
        <td>header</td>
        <td>yes (default)</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>access_token</th>
        <td>query</td>
        <td>yes (if "Test Mode" is enabled)</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>body</th>
        <td>body</td>
        <td>yes</td>
        <td>User</td>
        <td> - </td>
        <td><a href="#/definitions/User">User</a></td>
    </tr>
    <tr>
        <th>attributes</th>
        <td>query</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string array</td>
    </tr>
</table>

#### Response

**Content-Type:** `application/scim+json`, `application/json`

| Status Code | Reason      | Response Model |
|-------------|-------------|----------------|
| 201    | successful operation | <a href="#/definitions/User">User</a>|

### `<domain root>/identity/seam/resource/restv1/scim/v2/Users/{id}`

### GET

<a id="getUserById">Find user by id</a>

Returns a user by id as path parameter (https://tools.ietf.org/html/rfc7644#section-3.4.1).

#### Security

* UMA (default)
* OAuth2 Access Token (Test Mode)

#### Request

##### Parameters

<table border="1">
    <tr>
        <th>Name</th>
        <th>Located in</th>
        <th>Required</th>
        <th>Description</th>
        <th>Default</th>
        <th>Schema</th>
    </tr>
    <tr>
        <th>Authorization</th>
        <td>header</td>
        <td>yes (default)</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>access_token</th>
        <td>query</td>
        <td>yes (if "Test Mode" is enabled)</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>id</th>
        <td>path</td>
        <td>yes</td>
        <td>LDAP 'inum' of user</td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>attributes</th>
        <td>query</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string array</td>
    </tr>
</table>

#### Response

**Content-Type:** `application/scim+json`, `application/scim`

| Status Code | Reason      | Response Model |
|-------------|-------------|----------------|
| 200    | successful operation | <a href="#/definitions/User">User</a>|

### PUT

<a id="updateUser">Update User</a>

Updates a user (https://tools.ietf.org/html/rfc7644#section-3.5.1).

#### Security

* UMA (default)
* OAuth2 Access Token (Test Mode)

#### Request

**Content-Type:** `application/scim+json`, `application/json`

##### Parameters

<table border="1">
    <tr>
        <th>Name</th>
        <th>Located in</th>
        <th>Required</th>
        <th>Description</th>
        <th>Default</th>
        <th>Schema</th>
    </tr>
    <tr>
        <th>Authorization</th>
        <td>header</td>
        <td>yes (default)</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>access_token</th>
        <td>query</td>
        <td>yes (if "Test Mode" is enabled)</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>id</th>
        <td>path</td>
        <td>yes</td>
        <td>LDAP 'inum' of user</td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>body</th>
        <td>body</td>
        <td>yes</td>
        <td>User</td>
        <td> - </td>
        <td><a href="#/definitions/User">User</a></td>
    </tr>
    <tr>
        <th>attributes</th>
        <td>query</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string array</td>
    </tr>
</table>

#### Response

**Content-Type:** `application/scim+json`, `application/json`

| Status Code | Reason      | Response Model |
|-------------|-------------|----------------|
| 200    | successful operation | <a href="#/definitions/User">User</a>|

### DELETE

<a id="deleteUser">Delete User</a>

Deletes a user (https://tools.ietf.org/html/rfc7644#section-3.6).

#### Security

* UMA (default)
* OAuth2 Access Token (Test Mode)

#### Request

##### Parameters

<table border="1">
    <tr>
        <th>Name</th>
        <th>Located in</th>
        <th>Required</th>
        <th>Description</th>
        <th>Default</th>
        <th>Schema</th>
    </tr>
    <tr>
        <th>Authorization</th>
        <td>header</td>
        <td>yes (default)</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>access_token</th>
        <td>query</td>
        <td>yes (if "Test Mode" is enabled)</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>id</th>
        <td>path</td>
        <td>yes</td>
        <td>LDAP 'inum' of user</td>
        <td> - </td>
        <td>string</td>
    </tr>
</table>

#### Response

**Content-Type:** `application/scim+json`, `application/json`

| Status Code | Reason      | Response Model |
|-------------|-------------|----------------|
| default     | successful operation |  -    |

### `<domain root>/identity/seam/resource/restv1/scim/v2/Users/Search`

### POST

<a id="listUsers">Search Users</a>

Returns a list of users (https://tools.ietf.org/html/rfc7644#section-3.4).

#### Security

* UMA (default)
* OAuth2 Access Token (Test Mode)

#### Request

**Content-Type:** `application/scim+json`, `application/json`

##### Parameters

<table border="1">
    <tr>
        <th>Name</th>
        <th>Located in</th>
        <th>Required</th>
        <th>Description</th>
        <th>Default</th>
        <th>Schema</th>
    </tr>
    <tr>
        <th>Authorization</th>
        <td>header</td>
        <td>yes (default)</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>access_token</th>
        <td>query</td>
        <td>yes (if "Test Mode" is enabled)</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>body</th>
        <td>body</td>
        <td>yes</td>
        <td></td>
        <td> - </td>
        <td><a href="#/definitions/ScimPersonSearch">ScimPersonSearch</td>
    </tr>
</table>

#### Response

**Content-Type:** `application/scim+json`, `application/json`

| Status Code | Reason      | Response Model |
|-------------|-------------|----------------|
| 200    | successful operation | <a href="#/definitions/ListResponse">ListResponse</a>|

- - -

## Group Endpoint

### `<domain root>/identity/seam/resource/restv1/scim/v2/Groups`

### GET

<a id="searchGroups">Search Groups</a>

Returns a list of groups (https://tools.ietf.org/html/rfc7644#section-3.4.2.2).

#### Security

* UMA (default)
* OAuth2 Access Token (Test Mode)

#### Request

**Content-Type:** `application/scim+json`, `application/json`

##### Parameters

<table border="1">
    <tr>
        <th>Name</th>
        <th>Located in</th>
        <th>Required</th>
        <th>Description</th>
        <th>Default</th>
        <th>Schema</th>
    </tr>
    <tr>
        <th>Authorization</th>
        <td>header</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string </td>
    </tr>
    <tr>
        <th>filter</th>
        <td>query</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string </td>
    </tr>
    <tr>
        <th>sortBy</th>
        <td>query</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string </td>
    </tr>
    <tr>
        <th>sortOrder</th>
        <td>query</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string </td>
    </tr>
</table>

#### Response

**Content-Type:** `application/scim+json`, `application/json`


| Status Code | Reason      | Response Model |
|-------------|-------------|----------------|
| 200    | successful operation | <a href="#/definitions/ListResponse">ListResponse</a>|

### POST

<a id="createGroup">Create Group</a>

Create Group
(https://tools.ietf.org/html/draft-ietf-scim-api-19#section-3.3).

#### Security

* Authorization

#### Request

**Content-Type:** `application/scim+json`, `application/json`

##### Parameters

<table border="1">
    <tr>
        <th>Name</th>
        <th>Located in</th>
        <th>Required</th>
        <th>Description</th>
        <th>Default</th>
        <th>Schema</th>
    </tr>
    <tr>
        <th>Authorization</th>
        <td>header</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string </td>
    </tr>
    <tr>
        <th>body</th>
        <td>body</td>
        <td>no</td>
        <td>Group</td>
        <td> - </td>
        <td><a href="#/definitions/Group">Group</a></td>
    </tr>
</table>

#### Response

**Content-Type:** `application/scim+json`, `application/json`

| Status Code | Reason      | Response Model |
|-------------|-------------|----------------|
| 200    | successful operation | <a href="#/definitions/Group">Group</a>|

## /v2/Groups/{id}

### GET

<a id="getGroupById">Find Group by id</a>

Returns a Group on the basis of the provided id as path parameter
(https://tools.ietf.org/html/draft-ietf-scim-api-19#section-3.4.2.1).

#### Security

* Authorization

#### Request

##### Parameters

<table border="1">
    <tr>
        <th>Name</th>
        <th>Located in</th>
        <th>Required</th>
        <th>Description</th>
        <th>Default</th>
        <th>Schema</th>
    </tr>
    <tr>
        <th>Authorization</th>
        <td>header</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string </td>
    </tr>
    <tr>
        <th>id</th>
        <td>path</td>
        <td>yes</td>
        <td></td>
        <td> - </td>
        <td>string </td>
    </tr>
</table>

#### Response

**Content-Type:** `application/scim+json`, `application/json`

| Status Code | Reason      | Response Model |
|-------------|-------------|----------------|
| 200    | successful operation | <a href="#/definitions/Group">Group</a>|

### PUT

<a id="updateGroup">Update Group</a>

Update Group
(https://tools.ietf.org/html/draft-ietf-scim-api-19#section-3.3).

#### Security

* Authorization

#### Request

**Content-Type:** `application/scim+json`, `application/json`

##### Parameters

<table border="1">
    <tr>
        <th>Name</th>
        <th>Located in</th>
        <th>Required</th>
        <th>Description</th>
        <th>Default</th>
        <th>Schema</th>
    </tr>
    <tr>
        <th>Authorization</th>
        <td>header</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string </td>
    </tr>
    <tr>
        <th>id</th>
        <td>path</td>
        <td>yes</td>
        <td></td>
        <td> - </td>
        <td>string </td>
    </tr>
    <tr>
        <th>body</th>
        <td>body</td>
        <td>no</td>
        <td>Group</td>
        <td> - </td>
        <td><a href="#/definitions/Group">Group</a></td>
    </tr>
</table>

#### Response

**Content-Type:** `application/scim+json`, `application/json`

| Status Code | Reason      | Response Model |
|-------------|-------------|----------------|
| 200    | successful operation | <a href="#/definitions/Group">Group</a>|

### DELETE

<a id="deleteGroup">Delete Group</a>

Delete Group
(https://tools.ietf.org/html/draft-ietf-scim-api-19#section-3.3).

#### Security

* Authorization

#### Request

##### Parameters

<table border="1">
    <tr>
        <th>Name</th>
        <th>Located in</th>
        <th>Required</th>
        <th>Description</th>
        <th>Default</th>
        <th>Schema</th>
    </tr>
    <tr>
        <th>Authorization</th>
        <td>header</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string </td>
    </tr>
    <tr>
        <th>id</th>
        <td>path</td>
        <td>yes</td>
        <td></td>
        <td> - </td>
        <td>string </td>
    </tr>
</table>

#### Response

**Content-Type:** `application/scim+json`, `application/json`

| Status Code | Reason      | Response Model |
|-------------|-------------|----------------|
| default    | successful operation |  - |

- - -

## Bulk Operation Endpoint

## /v2/Bulk

### POST

<a id="bulkOperation">Bulk Operation</a>

SCIM Bulk Operation (https://tools.ietf.org/html/draft-ietf-scim-api-19#section-3.7)

#### Security

* Authorization

#### Request

**Content-Type:** `application/json`, `application/xml`

##### Parameters

<table border="1">
    <tr>
        <th>Name</th>
        <th>Located in</th>
        <th>Required</th>
        <th>Description</th>
        <th>Default</th>
        <th>Schema</th>
    </tr>
    <tr>
        <th>Authorization</th>
        <td>header</td>
        <td>no</td>
        <td></td>
        <td> - </td>
        <td>string</td>
    </tr>
    <tr>
        <th>body</th>
        <td>body</td>
        <td>no</td>
        <td>BulkRequest</td>
        <td> - </td>
        <td><a href="#/definitions/BulkRequest">BulkRequest</a></td>
    </tr>
</table>

#### Response

**Content-Type:** `application/json`, `application/xml`

| Status Code | Reason      | Response Model |
|-------------|-------------|----------------|
| 200    | successful operation | <a href="#/definitions/BulkResponse">BulkResponse</a>|

- - -

## Definitions

## <a name="/definitions/Address">Address</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>operation</td>
        <td>string</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>primary</td>
        <td>boolean</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>formatted</td>
        <td>string</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>streetAddress</td>
        <td>string</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>locality</td>
        <td>string</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>region</td>
        <td>string</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>postalCode</td>
        <td>string</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>country</td>
        <td>string</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>type</td>
        <td><a href="#/definitions/Type">Type</a></td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>$ref</td>
        <td>string</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/BulkOperation">BulkOperation</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>bulkId</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>version</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>method</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>path</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>location</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>data</td>
        <td> object </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>status</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>response</td>
        <td> object </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/BulkRequest">BulkRequest</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>schemas</td>
        <td> array[string] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>failOnErrors</td>
        <td> integer (int32) </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>operations</td>
        <td> array[<a href="#/definitions/BulkOperation">BulkOperation</a>] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/BulkResponse">BulkResponse</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>schemas</td>
        <td> array[string] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>operations</td>
        <td> array[<a href="#/definitions/BulkOperation">BulkOperation</a>] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/Email">Email</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>operation</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>value</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>display</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>primary</td>
        <td> boolean </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>type</td>
        <td> <a href="#/definitions/Type">Type</a> </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>$ref</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/Entitlement">Entitlement</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>operation</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
   </tr>
    <tr>
        <td>value</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>display</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>primary</td>
        <td> boolean </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>type</td>
        <td> <a href="#/definitions/Type">Type</a> </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>$ref</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/Group">Group</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>id</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>externalId</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>meta</td>
        <td> <a href="#/definitions/Meta">Meta</a> </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>schemas</td>
        <td> array[string] </td>
        <td>required</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>displayName</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>members</td>
        <td> array[<a href="#/definitions/MemberRef">MemberRef</a>] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/GroupRef">GroupRef</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>value</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>display</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>type</td>
        <td> <a href="#/definitions/Type">Type</a> </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>$ref</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/Im">Im</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>operation</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>value</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>display</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>primary</td>
        <td> boolean </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>type</td>
        <td> <a href="#/definitions/Type">Type</a> </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>$ref</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/ListResponse">ListResponse</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>totalResults</td>
        <td>integer (int32)</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>startIndex</td>
        <td>integer (int32)</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>itemsPerPage</td>
        <td>integer (int32)</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>schemas</td>
        <td>array[string]</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>resources</td>
        <td>array[<a href="#/definitions/Resource">Resource</a>]</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/MemberRef">MemberRef</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>operation</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>value</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>display</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>type</td>
        <td> <a href="#/definitions/Type">Type</a> </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>$ref</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/Meta">Meta</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>created</td>
        <td> string (date-time) </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>lastModified</td>
        <td> string (date-time) </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>location</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>version</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>attributes</td>
        <td> array[string] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>resourceType</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/Name">Name</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>formatted</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>familyName</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>givenName</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>middleName</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>honorificPrefix</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>honorificSuffix</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/PhoneNumber">PhoneNumber</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>operation</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>value</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>display</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>primary</td>
        <td> boolean </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>type</td>
        <td> <a href="#/definitions/Type">Type</a> </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>$ref</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/Photo">Photo</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>operation</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>value</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>display</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>primary</td>
        <td> boolean </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>type</td>
        <td> <a href="#/definitions/Type">Type</a> </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>$ref</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/Resource">Resource</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>id</td>
        <td>string</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>externalId</td>
        <td>string</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>meta</td>
        <td><a href="#/definitions/Meta">Meta</a></td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>schemas</td>
        <td>array[string]</td>
        <td>required</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/Role">Role</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>operation</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>value</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>display</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>primary</td>
        <td> boolean </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>type</td>
        <td> <a href="#/definitions/Type">Type</a> </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>$ref</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/Type">Type</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
</table>

## <a name="/definitions/User">User</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>id</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>externalId</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>meta</td>
        <td> <a href="#/definitions/Meta">Meta</a> </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>schemas</td>
        <td> array[string] </td>
        <td>required</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>userName</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>name</td>
        <td> <a href="#/definitions/Name">Name</a> </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>displayName</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>nickName</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>profileUrl</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>title</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>userType</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>preferredLanguage</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>locale</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>timezone</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>active</td>
        <td> boolean </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>password</td>
        <td> string </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>emails</td>
        <td> array[<a href="#/definitions/Email">Email</a>] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>phoneNumbers</td>
        <td> array[<a href="#/definitions/PhoneNumber">PhoneNumber</a>] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>ims</td>
        <td> array[<a href="#/definitions/Im">Im</a>] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>photos</td>
        <td> array[<a href="#/definitions/Photo">Photo</a>] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>addresses</td>
        <td> array[<a href="#/definitions/Address">Address</a>] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>groups</td>
        <td> array[<a href="#/definitions/GroupRef">GroupRef</a>] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>entitlements</td>
        <td> array[<a href="#/definitions/Entitlement">Entitlement</a>] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>roles</td>
        <td> array[<a href="#/definitions/Role">Role</a>] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>x509Certificates</td>
        <td> array[<a href="#/definitions/X509Certificate">X509Certificate</a>] </td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/X509Certificate">X509Certificate</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>operation</td>
        <td>string</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>value</td>
        <td>string</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>display</td>
        <td>string</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>primary</td>
        <td>boolean</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>type</td>
        <td><a href="#/definitions/Type">Type</a></td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
    <tr>
        <td>$ref</td>
        <td>string</td>
        <td>optional</td>
        <td>-</td>
        <td></td>
    </tr>
</table>

## <a name="/definitions/ScimPersonSearch">ScimPersonSearch</a>

<table border="1">
    <tr>
        <th>name</th>
        <th>type</th>
        <th>required</th>
        <th>description</th>
        <th>example</th>
    </tr>
    <tr>
        <td>attribute</td>
        <td> string </td>
        <td>required</td>
        <td>User Attribute Name</td>
        <td>Username</td>
    </tr>
    <tr>
        <td>value</td>
        <td> string </td>
        <td>required</td>
        <td>User Attribute Value</td>
        <td>Mike</td>
    </tr>
</table>
