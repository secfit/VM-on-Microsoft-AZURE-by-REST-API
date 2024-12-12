# Change SSH property on VM Linux
In order to connect to the last installed Ubuntu server via SSH Key defined by encryption type `ssh-rsa`, we need to allow SSHD service accpting this algorithm by add `PubkeyAcceptedAlgorithms +ssh-rsa` option to SSHD config file `/etc/ssh/sshd_config`.<br><br>
The following steps should allow executing commands `echo \"PubkeyAcceptedAlgorithms +ssh-rsa\" >> /etc/ssh/sshd_config; systemctl restart ssh` into Ubuntu Virtual Machine:<br><br>

Followed the last authentication creation from the [running repository](azure_account_auth_rest_api.md), keep the similar `token` and `authHeader` values.<br><br>
1.  Set Mandatory parameters : 

  ```powershell
      $baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
      $apiVersion = "?api-version=2024-07-01"
      $url = $baseUrl + "/providers/Microsoft.Compute/virtualMachines/" + $VMname + "/runCommand" + $apiVersion
   ```

You should replace the following values : <br>
```
  $VMname = "IcsHoneyAgent1"
  $subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
  $resourcegroupname="Honeypot_ICS"
```

Destination URL should be  : <br>
`https://management.azure.com/subscriptions/12e6b5b1-87o4-4f4e-ac46-d12f87a32099/resourceGroups/Honeypot_ICS/providers/Microsoft.Compute/virtualMachines/IcsHoneyAgent1?api-version=2024-07-01`<br>

2.  The body section will be as following :<br>
      For more information about AZURE API options for running command : [Azure Help](https://learn.microsoft.com/en-us/rest/api/virtualnetwork/network-interfaces/create-or-update?view=rest-virtualnetwork-2024-05-01&tabs=HTTP)
      ```powershell
        $body = '{
          "commandId": "RunShellScript",
          "script": [
            "echo \"PubkeyAcceptedAlgorithms +ssh-rsa\" >> /etc/ssh/sshd_config; systemctl restart ssh"
          ]
        }'
     ```

  #### You can download full Poweshell script [run_cmd_linux.ps1](run_cmd_linux.ps1) 
  You should replace the following values : <br>
  ```
  -    $subscriptionId
  -    $VMname
  -    $resourcegroupname
  ```
