## SCIM 1.1

### SCIM 1.1 Specifications

You can see the detailed SCIM 1.1 specification documents [here](http://www.simplecloud.info/specs/draft-scim-api-01.html).

### SCIM 1.1 Endpoints

- [User Endpoint](#user-endpoint)
- [Group Endpoint](#group-endpoint)
- [Bulk Operation Endpoint](#bulk-operation-endpoint)


## User Endpoint

### /seam/resource/restv1/Users
- - -
##### getResourceSet
**GET** `/host/seam/resource/restv1/Users{rsid}`

Returns a resource set on the basis of provided id as path parameter. The resource MUST be already registered with the mentioned id.


###### URL
    http://gluu.org/host/seam/resource/restv1/Users{rsid}

##### Request
###### Parameters
- Following are the details about parameters:
    <table border="1">
        <tr>
            <th>Parameter</th>
            <th>Location</th>    
	    <th>Required</th>
            <th>Description</th>
            <th>Data Type</th>
        </tr>
        <tr>
            <th>rsid</th>
	    <td>path</td>            
	    <td>TRUE</td>
            <td>Resource set description ID</td>
            <td>string</td>
        </tr>
	<tr>
            <th>Authorization</th>
	    <td>header</td>            
	    <td>FALSE</td>
            <td></td>
            <td>string</td>
        </tr>
    </table>


##### Response
**Content Type:**  application/json, application/xml

###### Success
-	<table border="1">
	    <tr>
			<th>Status Code</th>
			<th>Reason</th>
			<th>Description</th>
	    </tr>
	    <tr>
			<th>200</th>
			<th>Successful Operation</th>
			<th>Resource returned successfully</th>
	    </tr>
	</table>

###### Errors
-	<table border="1">
	    <tr>
			<th>Status Code</th>
			<th>Reason</th>
			<th>Description</th>
	    </tr>
		<tr>
		    <th>400</th>
		    <td>BAD REQUEST</td>
		    <td>Request is unparsable, syntactically incorrect, or violates schema</td>
		</tr>
		<tr>
		    <th>401</th>
		    <td>UNAUTHORIZED</td>
		    <td>Authorization header is invalid or missing</td>
		</tr>
		<tr>
		    <th>403</th>
		    <td>FORBIDDEN</td>
		    <td>Operation is not permitted based on the supplied authorization</td>
		</tr>
		<tr>
		    <th>404</th>
		    <td>NOT FOUND</td>
		    <td>Specified resource (e.g., Group) does not exist</td>
		</tr>
	</table>

- - -

## Group Endpoint


## Bulk Operation Endpoint


