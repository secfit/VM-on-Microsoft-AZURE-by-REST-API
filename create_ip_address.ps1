# Get token
$context = Get-AzContext
$userProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($userProfile)
$token = $profileClient.AcquireAccessToken($context.Subscription.TenantId)

# Set Mandatory parameter
$NetworkInterfaceName = "int1HONEYAGENT1_Z1"
$subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
$resourcegroupname="Honeypot_ICS"
$PublicIp="ip1HONEYAGENT1_Z1"
$baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
$apiVersion = "?api-version=2024-05-01"
$url = $baseUrl + "/providers/Microsoft.Network/publicIPAddresses/" + $PublicIp + $apiVersion

$authHeader = @{
    'Content-Type' = 'application/json' 
    'Authorization' = 'Bearer ' + $token.AccessToken 
    'host'="management.azure.com"
  }
   
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

Invoke-RestMethod -Uri $url -Headers $authHeader -Method PUT -Body $body
