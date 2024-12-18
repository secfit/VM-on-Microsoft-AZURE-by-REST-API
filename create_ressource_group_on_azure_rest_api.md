# Create RessourceGroup on AZURE using REST API
After successfully authentication to Microsoft AZURE via Powershell, we should get Subscription ID and use it to create Resource Group: 

1.  Open [Azure Portal](https://portal.azure.com/)
2.  Navigate to <b>Dashboard</b> > <b>Subscription</b>
3.  Get Subscription ID, the format should be like this '<b>12e6b5b1-87o4-4f4e-ac46-d12f87a32099</b>'<br>
    <b>Note</b>: 12e6b5b1-87o4-4f4e-ac46-d12f87a32099 is just for demonstration purpose.
  ![SubscriptionID](images/SubscriptionID.png)

4.  Store Subscription ID into the variable such as: `$subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"`
5.  Generate Resource Group Name as example: `$resourcegroupname="Honeypot_ICS"`
6.  Use the last API Version: `2024-08-01` for URL call.<br>
7.  Use the following to generate token
   ```powershell
  # Get token
  $context = Get-AzContext
  $userProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
  $profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($userProfile)
  $token = $profileClient.AcquireAccessToken($context.Subscription.TenantId)
   ```
8.  Set subscriptionID and resource group name, and identify Request URL<br>
    Note : for Azure Resource Manager provider APIs we use https://management.azure.com/<br>
    The final USRL should be like this :<br> `https://management.azure.com/subscriptions/12e6b5b1-87o4-4f4e-ac46-d12f87a32099/resourceGroups/Honeypot_ICS?api-version=2024-08-01`
   ```powershell
    $subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
    $resourcegroupname="Honeypot_ICS"
    $baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
    $apiVersion = "?api-version=2024-08-01"
    $url = $baseUrl + $apiVersion
   ```
9.  Basically, we are getting information from Azure to create the `$authHeader`
    ```powershell
    $authHeader = @{
        'Content-Type' = 'application/json' 
        'Authorization' = 'Bearer ' + $token.AccessToken 
        'host'="management.azure.com"
     }
    ```
10.  PowerShell can working with JSON, which is great since the POST and PUT calls require JSON input. On this example, the location will be "US East" `eastus` and tag is `Honeypot_1`:
     ```powershell
        $body='{
            "location": "eastus",
             "tags": {
                "tagname1": "Honeypot_1"
            }
         }'
     ```
11.  Once the URL has been defined, we can use the `Invoke-RestMethod` in PowerShell to make the call. We will pass in the method type, `PUT` in this call, the URL, and the authentication header.
     ```powershell
         Invoke-RestMethod -Uri $url -Headers $authHeader -Method PUT -Body $body
     ```
<br><br>
#### You can download full Poweshell script [create_ressource_group.ps1](create_ressource_group.ps1) 
You should replace the following values : <br>
```
-    $subscriptionId
-    $resourcegroupname
-    location
-    tagname1
```

11.  Check Ressource Group on AZURE Portal
    Open [AZURE Portal](portal.azure.com)<br>
    Navigate to <b>home</b> > <b>Ressource group</b> > <b>Honeypot_ICS</b> 
    ![Ip_address_capture_portal](images/ressource_group_capture_portal.PNG)
