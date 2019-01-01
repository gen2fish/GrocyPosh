function Connect-Grocy {
    <#

    .SYNOPSIS
    Sets global variables to connect to a grocy instance with API key.

    .DESCRIPTION
    Sets global variables to connect to a grocy instance with API key. Also includes integration with Poshbot to map Slack Users to Grocy Users

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

  if(!$global:grocyGlobal){
    $global:grocyGlobal = @{
      uri = ''
      apikey = ''
    }
  }


  if(!$global:grocyGlobal.uri){
    $URI = Read-Host -Prompt 'Input your server name'
    $global:grocyGlobal.uri = $URI
  }
  if(!$global:grocyGlobal.apikey)
  {
    if($global:PoshBotContext.CallingUserInfo.Id)
    {
      $global:grocyGlobal = Get-SlacktoGrocy($global:PoshBotContext.CallingUserInfo.Id)
    }
    else
    {
      $APIKEY = Read-Host -Prompt 'Input your Grocy API key'
    }
    $global:grocyGlobal.apikey = $APIKEY
  }

}
