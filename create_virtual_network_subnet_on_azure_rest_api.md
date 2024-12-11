# Create Virtual Network & Subnet
Based on the last example, we have to keep the same authentication value and using the last Token creation, `Get token` and `authHeader` should be the same, we are going to change on `parameters` and `body` sections:
1.  Set Mandatory parameters
   ```powershell
    $baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
    $apiVersion = "?api-version=2024-05-01"
    $url = $baseUrl + "/providers/Microsoft.Network/virtualNetworks/" + $virtualNetworkName + $apiVersion
   ```
Destination URL should be  : <br>
`https://management.azure.com/subscriptions/12e6b5b1-87o4-4f4e-ac46-d12f87a32099/resourceGroups/Honeypot_ICS/providers/Microsoft.Network/virtualNetworks/vneticshoneyagent1_z1?api-version=2024-05-01`<br><br>
You should replace the following values : <br>
```
  $virtualNetworkName = vneticshoneyagent1_z1
  $NetworkInterfaceName = int1HONEYAGENT1_Z1
  $subscriptionId = 12e6b5b1-87o4-4f4e-ac46-d12f87a32099
  $resourcegroupname = Honeypot_ICS
  api-version = 2024-05-01
```

2.  The body section will be as following :<br>
      For more information about AZURE API options for Virtual Network creation : [Azure Help](https://learn.microsoft.com/en-us/rest/api/virtualnetwork/virtual-networks/create-or-update?view=rest-virtualnetwork-2024-05-01&tabs=HTTP)
   ```powershell
      $body='{
        "type": "microsoft.network/virtualnetworks",
        "location": "centralus",
        "properties": {
            "provisioningState": "Succeeded",
            "addressSpace": {
                "addressPrefixes": [
                    "10.0.0.0/16"
                ]
            },
            "privateEndpointVNetPolicies": "Disabled",
            "subnets": [
                {
                    "name": "default",
                    "id": "/subscriptions/12e6b5b1-87o4-4f4e-ac46-d12f87a32099/resourceGroups/Honeypot_ICS/providers/Microsoft.Network/virtualNetworks/vneticshoneyagent1_z1/subnets/default",
                    "properties": {
                        "provisioningState": "Succeeded",
                        "addressPrefix": "10.0.0.0/24",
                        "ipConfigurations": [
                            {
                                "id": "/subscriptions/12e6b5b1-87o4-4f4e-ac46-d12f87a32099/resourceGroups/Honeypot_ICS/providers/Microsoft.Network/networkInterfaces/int1HONEYAGENT1_Z1/ipConfigurations/IPCONFIG1"
                            }
                        ],
                        "delegations": [],
                        "privateEndpointNetworkPolicies": "Disabled",
                        "privateLinkServiceNetworkPolicies": "Enabled"
                    },
                    "type": "Microsoft.Network/virtualNetworks/subnets"
                }
            ],
            "virtualNetworkPeerings": [],
            "enableDdosProtection": false
        },
    }'
   ```
3.   Call Invoke-RestMethod using PUT request:
   ```powershell
      Invoke-RestMethod -Uri $url -Headers $authHeader -Method PUT -Body $body
   ```

#### You can download full Poweshell script [create_virtual_network.ps1](create_virtual_network.ps1) 
You should replace the following values : <br>
```
-    $subscriptionId
-    $virtualNetworkName
-    $NetworkInterfaceName
-    $resourcegroupname
```
