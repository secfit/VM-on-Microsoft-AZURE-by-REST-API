# Get token
$context = Get-AzContext
$userProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($userProfile)
$token = $profileClient.AcquireAccessToken($context.Subscription.TenantId)

# Set Mandatory parameter
$VMname = "IcsHoneyAgent1"
$subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
$resourcegroupname="Honeypot_ICS"
$baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
$apiVersion = "?api-version=2024-07-01"
$url = $baseUrl + "/providers/Microsoft.Compute/virtualMachines/" + $VMname + "/runCommand" + $apiVersion

$authHeader = @{
    'Content-Type' = 'application/json' 
    'Authorization' = 'Bearer ' + $token.AccessToken 
    'host'="management.azure.com"
  }

$body = '{
  "commandId": "RunShellScript",
  "script": [
    "echo \"PubkeyAcceptedAlgorithms +ssh-rsa\" >> /etc/ssh/sshd_config; systemctl restart ssh"
  ]
}'

$response = Invoke-RestMethod -Uri $url -Headers $authHeader -Method POST -Body $body
