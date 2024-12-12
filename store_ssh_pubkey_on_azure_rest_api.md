# Store SSH PublicKey
Followed the last authentication creation from the [running repository](azure_account_auth_rest_api.md), keep the similar `token` and `authHeader` values.<br><br>

1.  Set Mandatory parameters : 

  ```powershell
    $baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
    $apiVersion = "?api-version=2024-07-01"
    $url = $baseUrl + "/providers/Microsoft.Compute/sshPublicKeys/" + $SshPubKeyName + $apiVersion
   ```

You should replace the following values : <br>

  ```
    $SshPubKeyName = "ICSHoneySshPublicKey1"
    $subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
    $resourcegroupname="Honeypot_ICS"
  ```

Destination URL should be  : <br>
`https://management.azure.com/subscriptions/12e6b5b1-87o4-4f4e-ac46-d12f87a32099/resourceGroups/Honeypot_ICS/providers/Microsoft.Compute/sshPublicKeys/ICSHoneySshPublicKey1?api-version=2024-07-01`<br>

2.  Generate SSH PublicKey using this [online tool](https://8gwifi.org/sshfunctions.jsp), or you can generate by using this command `ssh-keygen -t rsa -b 4096 -C "HoneyICSAgent1"` <br>
    Example : <br>
    #### PublicKey
      ```shell
      -----BEGIN PUBLIC KEY-----
    AAAAB3NzaC1yc2EAAAADAQABAAACAQCS0aUbl+LW31IASEinkd9Z+WeNO7udJA551HDF7tpA/rdxDcrAkWOgJJ35cCF3hbjTmr03rB/kgOUbWMvctArTlcRfXZfXKZNLd/KVKWAHEnyUJWDs66MSqHqJQDb7dVheQV0SForVCkhY+z7ZHTPmwKMbLWc/5qe0N8VNX4pkXPrIOyqVKW4HwmWuRiaqq1m3XvnjCR/jFJGH83f6f7tq5AsnTpB+i2nWFvdqOdvsGVjGZCN2XXItGWgTjF3LnqFO4EcoROrywOxZ+3ZD5nYBi/zjWTNdIwA6Q/KWM7TDUF8tsAz9NRRKQtoOgFN6VGXHuZkuwoFaTcfszRK2EnJSRmVXHcuUqmLvHJyDXmEKjOr67vArMty9AEVgXDKWvILupkmX1Z9mqKtp4SA4edXLq/kznrI6VR4fBD24Ta4YCIiebYX8oMUM/pH5chxTjaXsNYUVD4VTf44l7boKi6mUesEKCHF6zvFjrO0wgyTMYK4ojrzg/5m3Ywks5K/rafRkV+eyD25RJHAfq1AsdxEUmL8MMyRxrPA5r/juGD8tsjiLBhuWFz0C6FL4QnC7SvjC5ppoUYtF8/ocNA5ZThnfoOrru8QYtqHv6+88uOZvB9y0/XvOeo2a12f+sACPFCb7qE+VQj+UAQ4kQD2CGRvvsDadbdP1yRFolLLL2gXZuQ==
    -----END PUBLIC KEY-----
  ```

    #### PrivateKey
      ```shell
        -----BEGIN RSA PRIVATE KEY-----
    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
    -----END RSA PRIVATE KEY-----
  ```
  <b>[Very important note] : Do NOT use the last PrivateKey / PublicKey, it was just for education purpose !!!</b>
   
3.  The body section will be as following :<br>
      For more information about AZURE API options for IP Address creation : [Azure Help](https://learn.microsoft.com/en-us/rest/api/compute/ssh-public-keys?view=rest-compute-2024-07-01)
      ```powershell
        $body='{
        	"location": "centralus",
        	"properties": {
                "publicKey": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCS0aUbl+LW31IASEinkd9Z+WeNO7udJA551HDF7tpA/rdxDcrAkWOgJJ35cCF3hbjTmr03rB/kgOUbWMvctArTlcRfXZfXKZNLd/KVKWAHEnyUJWDs66MSqHqJQDb7dVheQV0SForVCkhY+z7ZHTPmwKMbLWc/5qe0N8VNX4pkXPrIOyqVKW4HwmWuRiaqq1m3XvnjCR/jFJGH83f6f7tq5AsnTpB+i2nWFvdqOdvsGVjGZCN2XXItGWgTjF3LnqFO4EcoROrywOxZ+3ZD5nYBi/zjWTNdIwA6Q/KWM7TDUF8tsAz9NRRKQtoOgFN6VGXHuZkuwoFaTcfszRK2EnJSRmVXHcuUqmLvHJyDXmEKjOr67vArMty9AEVgXDKWvILupkmX1Z9mqKtp4SA4edXLq/kznrI6VR4fBD24Ta4YCIiebYX8oMUM/pH5chxTjaXsNYUVD4VTf44l7boKi6mUesEKCHF6zvFjrO0wgyTMYK4ojrzg/5m3Ywks5K/rafRkV+eyD25RJHAfq1AsdxEUmL8MMyRxrPA5r/juGD8tsjiLBhuWFz0C6FL4QnC7SvjC5ppoUYtF8/ocNA5ZThnfoOrru8QYtqHv6+88uOZvB9y0/XvOeo2a12f+sACPFCb7qE+VQj+UAQ4kQD2CGRvvsDadbdP1yRFolLLL2gXZuQ== HoneyICSAgent1"
            }
        }'
     ```
4.   Call Invoke-RestMethod using PUT request:
     ```powershell
      Invoke-RestMethod -Uri $url -Headers $authHeader -Method PUT -Body $body
     ```

     #### You can download full Poweshell script [create_pub_key.ps1](create_pub_key.ps1) 
      You should replace the following values : <br>
      ```
      -    $subscriptionId
      -    $SshPubKeyName
      -    $resourcegroupname
      ```
5.  Check Network Interface on AZURE Portal
  Open [AZURE Portal](portal.azure.com)<br>
  Navigate to <b>home</b> > <b>Network interface</b> > <b>int1HONEYAGENT1_Z1</b> 
  ![network_interface_azure_portal](images/ssh_publickey_azure_portal.PNG)
