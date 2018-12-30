function Connect-Grocy {
    <#

    .SYNOPSIS
    Sets global variables to connect to a grocy instance with API key.

    .DESCRIPTION
    Sets global variables to connect to a grocy instance with API key.

    .PARAMETER URI
    HTTP or HTTPS Destination of Grocy Instance.

    http://grocy.demo.info

    If undefined, it will prompt for entry

    .PARAMETER APIKEY
    The API Key of the User you wish to connect with

    If undefined, it will prompt for entry

    .EXAMPLE
    Connect-Grocy -URI https://grocy.fish.local -APIKEY iunerviunv87h2h23i283982j3u4928334r

    .EXAMPLE
    Connect-Grocy

    .NOTES
    Author: Christopher D Forkner
    Date: 12/30/2018

    #>

  param (
    $URI,
    $APIKEY
  )

  if(!$URI){
    $URI = Read-Host -Prompt 'Input your server name'
  }
  if(!$APIKEY){
    $APIKEY = Read-Host -Prompt 'Input your Grocy API key'
  }

  $global:grocyGlobal = @{
    "uri" = $URI
    "apikey" = $APIKEY
  }
}
