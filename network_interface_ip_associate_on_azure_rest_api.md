# Associate Public IP Address to Network Interface on AZURE using REST API   

Followed the last authentication creation from the [running repository](azure_account_auth_rest_api.md), keep the similar `token` and `authHeader` values.<br><br>
1.  Set Mandatory parameters :
   ```powershell
      $baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
      $apiVersion = "?api-version=2024-05-01"
      $url = $baseUrl + "/providers/Microsoft.Network/networkInterfaces/" + $NetworkInterfaceName + $apiVersion
   ```

You should replace the following values : <br>
  ```
    $virtualNetworkName = "vneticshoneyagent1_z1"
    $NetworkInterfaceName = "int1HONEYAGENT1_Z1"
    $subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
    $resourcegroupname="Honeypot_ICS"
    $PublicIp="ip1HONEYAGENT1_Z1"
  ```

2.  On this phase, we are going to update Network Interface by adding IP address name `ip1HONEYAGENT1_Z1` to this network interface `int1HONEYAGENT1_Z1`: 
  ```
  	"publicIPAddress": {
		  "id": "/subscriptions/12e6b5b1-87o4-4f4e-ac46-d12f87a32099/resourceGroups/Honeypot_ICS/providers/Microsoft.Network/publicIPAddresses/ip1HONEYAGENT1_Z1"
	  },
  ```

3.  The body section will be as following :<br>
      For more information about AZURE API options for IP Address creation : [Azure Help](https://learn.microsoft.com/en-us/rest/api/virtualnetwork/public-ip-addresses/create-or-update?view=rest-virtualnetwork-2024-05-01&tabs=HTTP)
      ```powershell
        $body='{
        	"location": "centralus",
        	"type": "Microsoft.Network/networkInterfaces",
            "properties": {
        		"ipConfigurations": [
        			{
        				"name": "ipconfig1",
        				"properties": {
        					"subnet": {
        						"id": "/subscriptions/12e6b5b1-87o4-4f4e-ac46-d12f87a32099/resourceGroups/Honeypot_ICS/providers/Microsoft.Network/virtualNetworks/vneticshoneyagent1_z1/subnets/default"
        					},
        					"publicIPAddress": {
        						"id": "/subscriptions/12e6b5b1-87o4-4f4e-ac46-d12f87a32099/resourceGroups/Honeypot_ICS/providers/Microsoft.Network/publicIPAddresses/ip1HONEYAGENT1_Z1"
        					},
        					"primary": true,
        					"privateIPAddressVersion": "IPv4"
        				}
        			}
        		],
                "dnsSettings": {
                    "dnsServers": [],
                    "appliedDnsServers": []
                },
                "enableAcceleratedNetworking": true,
                "vnetEncryptionSupported": false,
                "enableIPForwarding": false,
                "disableTcpStateTracking": false,
                "hostedWorkloads": [],
                "tapConfigurations": [],
                "nicType": "Standard",
                "allowPort25Out": false,
                "defaultOutboundConnectivityEnabled": false,
                "auxiliaryMode": "None",
                "auxiliarySku": "None"
            }
        }'
     ```

   4.   Call Invoke-RestMethod using PUT request:
     ```powershell
      Invoke-RestMethod -Uri $url -Headers $authHeader -Method PUT -Body $body
     ```
  #### You can download full Poweshell script [associate_ip_to_interface.ps1](associate_ip_to_interface.ps1) 
  You should replace the following values : <br>
  ```
  -    $virtualNetworkName.ps1
  -    $subscriptionId
  -    $NetworkInterfaceName
  -    $resourcegroupname
  -    $PublicIp
  ```
