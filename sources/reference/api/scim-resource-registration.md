## API Document

### /host/seam/resource/restv1/resource_set

#### Overview


#### `/host/seam/resource/restv1/resource_set{rsid}`

##### deleteResourceSet

**DELETE** `/host/seam/resource/restv1/resource_set{rsid}`

Deletes a previously registered resource set description on the basis of provided id as parameter (Id tells the system which resource set is desired to be deleted).

###### URL
    http://gluu.org/host/seam/resource/restv1/resource_set{rsid}

##### Request
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


- - -
##### getResourceSet
**GET** `/host/seam/resource/restv1/resource_set{rsid}`

Returns a resource set on the basis of provided id as path parameter. The resource MUST be already registered with the mentioned id.


###### URL
    http://gluu.org/host/seam/resource/restv1/resource_set{rsid}

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
##### updateResourceSet
**PUT** `/host/seam/resource/restv1/resource_set{rsid}`

Updates a previously registered resource set description on the basis of given id using the PUT method. 

###### URL
    http://gluu.org/host/seam/resource/restv1/resource_set{rsid}

##### Request
###### Parameters
- Below is the information about parameters:

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
	<tr>
            <th>body</th>
	    <td>body</td>            
	    <td>FALSE</td>
            <td>Resource set (e.g. User)</td>
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
		    <td>Specified resource (e.g., User) does not exist</td>
		</tr>
	</table>

