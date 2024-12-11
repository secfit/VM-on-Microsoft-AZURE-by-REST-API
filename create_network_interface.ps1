# Get token
$context = Get-AzContext
$userProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($userProfile)
$token = $profileClient.AcquireAccessToken($context.Subscription.TenantId)

# Set Mandatory parameter
$virtualNetworkName = "vneticshoneyagent1_z1"
$NetworkInterfaceName = "int1HONEYAGENT1_Z1"
$subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
$resourcegroupname="Honeypot_ICS"
$PublicIp="ip1HONEYAGENT1_Z1"
$baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
$apiVersion = "?api-version=2024-05-01"
$url = $baseUrl + "/providers/Microsoft.Network/networkInterfaces/" + $NetworkInterfaceName + $apiVersion


$authHeader = @{
    'Content-Type' = 'application/json' 
    'Authorization' = 'Bearer ' + $token.AccessToken 
    'host'="management.azure.com"
  }
  
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
					"primary": true,
					"privateIPAddressVersion": "IPv4"
				}
			}
		],
        "dnsSettings": {
            "dnsServers": [],
            "appliedDnsServers": []
        },
		"ddosSettings": {
            "protectionMode": "Disabled"
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

Invoke-RestMethod -Uri $url -Headers $authHeader -Method PUT -Body $body
