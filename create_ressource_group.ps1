# Get token
$context = Get-AzContext
$userProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($userProfile)
$token = $profileClient.AcquireAccessToken($context.Subscription.TenantId)

# Set subscriptionId and resource group name
$subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
$resourcegroupname="Honeypot_ICS"
$baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
$apiVersion = "?api-version=2024-08-01"
$url = $baseUrl + $apiVersion

$authHeader = @{
    'Content-Type' = 'application/json' 
    'Authorization' = 'Bearer ' + $token.AccessToken 
    'host'="management.azure.com"
  }
  
$body='{
    "location": "eastus",
     "tags": {
        "tagname1": "Honeypot_1"
    }
 }'

 Invoke-RestMethod -Uri $url -Headers $authHeader -Method PUT -Body $body
  
