# GrocyPosh

Powershell wrapper for the Grocy API. Made for use with PoshBot for my family Slack. Works with Powershell Core.

To maintain a persistent connection; you must maintain the variable `$global:grocyGlobal` with your server and API key.


```powershell
    $global:grocyGlobal = @{
      uri = 'http(s)://Hostname-or-IP-address' # Port is necessary if you are not using default 80/443
      apikey = '' # Your API Key for Grocy.
```

If you are using this in with PoshBot, then you'll need to Generate your API in Grocy, then link it with your Slack account with the function;

```text
New-GrocyConfig '<your grocy apikey here>'
```

This will create a pair with your Slack ID and your Grocy

## Grocy

Grocy -  https://github.com/grocy/grocy

## PoshBot

PoshBot - https://github.com/poshbotio/PoshBot
