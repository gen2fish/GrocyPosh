function Get-GrocyUser {
    <#

    .SYNOPSIS
    Gets the Users in your Grocy Instance

    .DESCRIPTION
    Call the Grocy API to list all available Users

    .PARAMETER ID
    Find a user with the matching ID

    If undefined it will return all Users

    .EXAMPLE
    Get-GrocyUser -ID 1

    .EXAMPLE
    Get-GrocyUser

    .NOTES
    Author: Christopher D Forkner
    Date: 12/30/2018

    #>

  param (
    $ID
  )

  $URI = 'https://grocy.fish.local'

    $params = @{
      body =  @{}
        uri = "$URI/api/users/get"
        headers = @{
        "Content-Type" = "application/json"
        "GROCY-API-KEY" = "nWFXh38FtcN0rrADfkz2mM4RCxLBxzEyIozKIr3JurmOsvVNNi"
        }
        method = "Get"
      }

    $result = Invoke-WebRequest @params -SkipCertificateCheck
    $result = $result.Content | ConvertFrom-Json

    if($ID){
      $result | ? {$_.id -eq $ID}
    }
    if(!$ID){
      $result
    }


  }
