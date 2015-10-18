## API Document

### /host/seam/resource/restv1/resource_set

#### Overview


#### `/host/seam/resource/restv1/resource_set{rsid}`

##### deleteResourceSet

**DELETE** `/host/seam/resource/restv1/resource_set{rsid}`

Deletes a previously registered resource set description using the DELETE method, thereby removing it from the authorization server's protection regime.

###### URL
    http://gluu.org/host/seam/resource/restv1/resource_set{rsid}
###### Parameters
- Following table is explaining information about parameters for DELETE operation:
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

###### Response

**Content type**: Application/json, Application/xml

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
		    <td>Specified resource (e.g., User) does not exist</td>
		</tr>
	</table>


