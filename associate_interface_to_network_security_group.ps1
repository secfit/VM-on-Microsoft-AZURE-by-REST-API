#1- Get Network Security Group Name

	# Set Mandatory parameter
	$subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
	$resourcegroupname="Honeypot_ICS"
	$baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
	$apiVersion = "?api-version=2024-05-01"
	$url = $baseUrl + "/providers/Microsoft.Network/networkSecurityGroups/" + $apiVersion

	$nsg_Value = (Invoke-RestMethod -Uri $url -Headers $authHeader -Method GET).value.name
	
#2- Associate selected network security group $nsg_Value by update network interface and add 
	    "networkSecurityGroup": {
      "id": "/subscriptions/{12e6b5b1-87o4-4f4e-ac46-d12f87a32099}/resourceGroups/{Honeypot_ICS}/providers/Microsoft.Network/networkSecurityGroups/HoneyAgent1-nsg"
    }
	
	# Set Mandatory parameter
	$virtualNetworkName = "vneticshoneyagent1_z1"
	$NetworkInterfaceName = "int1HONEYAGENT1_Z1"
	$subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
	$resourcegroupname="Honeypot_ICS"
	$PublicIp="ip1HONEYAGENT1_Z1"
	$baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
	$apiVersion = "?api-version=2024-05-01"
	$url = $baseUrl + "/providers/Microsoft.Network/networkInterfaces/" + $NetworkInterfaceName + $apiVersion

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
		"auxiliarySku": "None",
		"networkSecurityGroup": {
			"id": "/subscriptions/12e6b5b1-87o4-4f4e-ac46-d12f87a32099/resourceGroups/Honeypot_ICS/providers/Microsoft.Network/networkSecurityGroups/HoneyAgent1-nsg"
		}
	}
}'
Invoke-RestMethod -Uri $url -Headers $authHeader -Method PUT -Body $body
