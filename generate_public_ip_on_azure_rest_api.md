# Generate Public IP address on AZURE using REST API   

Followed the last authentication creation from the [running repository](azure_account_auth_rest_api.md), keep the similar `token` and `authHeader` values.<br><br>
1.  Set Mandatory parameters : 

  ```powershell
    $baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
    $apiVersion = "?api-version=2024-05-01"
    $url = $baseUrl + "/providers/Microsoft.Network/publicIPAddresses/" + $PublicIp + $apiVersion
   ```
You should replace the following values : <br>
```
  $NetworkInterfaceName = "int1HONEYAGENT1_Z1"
  $subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
  $resourcegroupname="Honeypot_ICS"
  $PublicIp="ip1HONEYAGENT1_Z1"
```

Destination URL should be  : <br>
`https://management.azure.com/subscriptions/12e6b5b1-87o4-4f4e-ac46-d12f87a32099/resourceGroups/Honeypot_ICS/providers/Microsoft.Network/publicIPAddresses/ip1HONEYAGENT1_Z1?api-version=2024-05-01`<br>


2.  The body section will be as following :<br>
      For more information about AZURE API options for IP Address creation : [Azure Help](https://learn.microsoft.com/en-us/rest/api/virtualnetwork/public-ip-addresses/create-or-update?view=rest-virtualnetwork-2024-05-01&tabs=HTTP)
      ```powershell
        $body='{
            "sku": {
                "name": "Standard",
                "tier": "Regional"
            },
            "location": "centralus",
            "zones": [
                "1"
            ],
            "properties": {
                "publicIPAddressVersion": "IPv4",
                "publicIPAllocationMethod": "Static",
                "idleTimeoutInMinutes": 4,
                "ipConfiguration": {
                    "id": "/subscriptions/12e6b5b1-87o4-4f4e-ac46-d12f87a32099/resourceGroups/Honeypot_ICS/providers/Microsoft.Network/networkInterfaces/int1HONEYAGENT1_Z1/ipConfigurations/ipconfig1"
                }
            }
        }'
     ```

3.   Call Invoke-RestMethod using PUT request:
     ```powershell
      Invoke-RestMethod -Uri $url -Headers $authHeader -Method PUT -Body $body
     ```

#### You can download full Poweshell script [create_ip_address.ps1](create_ip_address.ps1) 
You should replace the following values : <br>
```
-    $subscriptionId
-    $NetworkInterfaceName
-    $resourcegroupname
-    $PublicIp
```

4.  Retreive Public IP value :<br>
    note : we are using `Invoke-RestMethod` with `GET` method. 
     ```powershell
      $NetworkInterfaceName = "int1HONEYAGENT1_Z1"
      $subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
      $resourcegroupname="Honeypot_ICS"
      $PublicIp="ip1HONEYAGENT1_Z1"
      $baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
      $apiVersion = "?api-version=2024-05-01"
      $url = $baseUrl + "/providers/Microsoft.Network/publicIPAddresses/" + $PublicIp + $apiVersion
      $nsg_Value = (Invoke-RestMethod -Uri $url -Headers $authHeader -Method GET).value.name

     $authHeader = @{
      'Content-Type' = 'application/json' 
      'Authorization' = 'Bearer ' + $token.AccessToken 
      'host'="management.azure.com"
    }
    
    Invoke-RestMethod -Uri $url -Headers $authHeader -Method GET
     ```
     
     The result should be as following:
    ![Connect-AzAccount-pop-up](images/ip_address_details.JPG)

   
   To filter for specific result of ipAddress value, we store ipAddress in `$_IP_res` variable by filtering for `.properties.ipAddress` value: 
  ```powershell
      $_IP_res=(Invoke-RestMethod -Uri $url -Headers $authHeader -Method GET).properties.ipAddress
  ```
![Connect-AzAccount-pop-up](images/ip_address_uniq.JPG)


