function New-GrocyUser {
    <#

    .SYNOPSIS
    Creates a new user in Grocy

    .DESCRIPTION
    Uses Grocy API to create a new user in a specified Grocy Instance

    .PARAMETER Username
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
    [Parameter(Mandatory = $true)]$Username,
    $FirstName,
    $LastName,
    [Parameter(Mandatory = $true)]$Passwd
  )

  if(!$global:grocyGlobal){
    Connect-Grocy
  }

  $URI = $global:grocyGlobal.uri

  $params = @{
    body =  @{
      "username" = $Username
      "first_name" = $FirstName
      "last_name" = $LastName
      "password" = $Passwd
    } | ConvertTo-Json -Depth 5
      uri = "$URI/api/users/create"
      headers = @{
        "accept" = "application/json"
        "Content-Type" = "application/json"
        "GROCY-API-KEY" = $global:grocyGlobal.APIKEY
      }
      method = "Post"
  }

  $params.body
  $result = Invoke-WebRequest @params -SkipCertificateCheck
  $result = $result.Content | ConvertFrom-Json

  $result

  }
