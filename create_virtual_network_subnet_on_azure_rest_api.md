# Create Virtual Network & Subnet
Based on the last example, we have to keep the same authentication value and using the last Token creation, `Get token` and `authHeader` should be the same, we are going to change on `parameters` and `body` sections:
1.  Set Mandatory parameters
   ```powershell
    $virtualNetworkName = "vneticshoneyagent1_z1"
    $NetworkInterfaceName = "int1HONEYAGENT1_Z1"
    $subscriptionId="34e6b5b1-46e4-4f4e-bd46-d07e88a37274"
    $resourcegroupname="Honeypot_ICS"
    $baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
    $apiVersion = "?api-version=2024-05-01"
    $url = $baseUrl + "/providers/Microsoft.Network/virtualNetworks/" + $virtualNetworkName + $apiVersion
   ```
You should replace the following values : <br>
```
  $virtualNetworkName = vneticshoneyagent1_z1
  $NetworkInterfaceName = int1HONEYAGENT1_Z1
  $subscriptionId = 34e6b5b1-46e4-4f4e-bd46-d07e88a37274
  $resourcegroupname = Honeypot_ICS
  api-version = 2024-05-01
```

2.  The body section will be as following :
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
                    "id": "/subscriptions/34e6b5b1-46e4-4f4e-bd46-d07e88a37274/resourceGroups/Honeypot_ICS/providers/Microsoft.Network/virtualNetworks/vneticshoneyagent1_z1/subnets/default",
                    "properties": {
                        "provisioningState": "Succeeded",
                        "addressPrefix": "10.0.0.0/24",
                        "ipConfigurations": [
                            {
                                "id": "/subscriptions/34e6b5b1-46e4-4f4e-bd46-d07e88a37274/resourceGroups/Honeypot_ICS/providers/Microsoft.Network/networkInterfaces/int1HONEYAGENT1_Z1/ipConfigurations/IPCONFIG1"
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
