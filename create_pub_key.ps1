# Get token
$context = Get-AzContext
$userProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($userProfile)
$token = $profileClient.AcquireAccessToken($context.Subscription.TenantId)

# Set Mandatory parameter
$SshPubKeyName = "ICSHoneySshPublicKey1"
$subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
$resourcegroupname="Honeypot_ICS"
$baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
$apiVersion = "?api-version=2024-07-01"
$url = $baseUrl + "/providers/Microsoft.Compute/sshPublicKeys/" + $SshPubKeyName + $apiVersion

$authHeader = @{
    'Content-Type' = 'application/json' 
    'Authorization' = 'Bearer ' + $token.AccessToken 
    'host'="management.azure.com"
  }
  
$body='{
	"location": "centralus",
	"properties": {
        "publicKey": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCS0aUbl+LW31IASEinkd9Z+WeNO7udJA551HDF7tpA/rdxDcrAkWOgJJ35cCF3hbjTmr03rB/kgOUbWMvctArTlcRfXZfXKZNLd/KVKWAHEnyUJWDs66MSqHqJQDb7dVheQV0SForVCkhY+z7ZHTPmwKMbLWc/5qe0N8VNX4pkXPrIOyqVKW4HwmWuRiaqq1m3XvnjCR/jFJGH83f6f7tq5AsnTpB+i2nWFvdqOdvsGVjGZCN2XXItGWgTjF3LnqFO4EcoROrywOxZ+3ZD5nYBi/zjWTNdIwA6Q/KWM7TDUF8tsAz9NRRKQtoOgFN6VGXHuZkuwoFaTcfszRK2EnJSRmVXHcuUqmLvHJyDXmEKjOr67vArMty9AEVgXDKWvILupkmX1Z9mqKtp4SA4edXLq/kznrI6VR4fBD24Ta4YCIiebYX8oMUM/pH5chxTjaXsNYUVD4VTf44l7boKi6mUesEKCHF6zvFjrO0wgyTMYK4ojrzg/5m3Ywks5K/rafRkV+eyD25RJHAfq1AsdxEUmL8MMyRxrPA5r/juGD8tsjiLBhuWFz0C6FL4QnC7SvjC5ppoUYtF8/ocNA5ZThnfoOrru8QYtqHv6+88uOZvB9y0/XvOeo2a12f+sACPFCb7qE+VQj+UAQ4kQD2CGRvvsDadbdP1yRFolLLL2gXZuQ== HoneyICSAgent1"
    }
}'

Invoke-RestMethod -Uri $url -Headers $authHeader -Method PUT -Body $body
