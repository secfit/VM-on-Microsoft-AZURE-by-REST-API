# Get token
$context = Get-AzContext
$userProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($userProfile)
$token = $profileClient.AcquireAccessToken($context.Subscription.TenantId)

# Set Mandatory parameter
$virtualNetworkName = "vneticshoneyagent1_z1"
$NetworkInterfaceName = "int1HONEYAGENT1_Z1"
$subscriptionId="34e6b5b1-46e4-4f4e-bd46-d07e88a37274"
$resourcegroupname="Honeypot_ICS"
$baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
$apiVersion = "?api-version=2024-05-01"
$url = $baseUrl + "/providers/Microsoft.Network/virtualNetworks/" + $virtualNetworkName + $apiVersion


$authHeader = @{
    'Content-Type' = 'application/json' 
    'Authorization' = 'Bearer ' + $token.AccessToken 
    'host'="management.azure.com"
  }
  
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


Invoke-RestMethod -Uri $url -Headers $authHeader -Method PUT -Body $body
