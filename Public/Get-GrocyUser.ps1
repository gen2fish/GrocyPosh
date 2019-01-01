function Get-GrocyUser {
    <#

    .SYNOPSIS
    Gets the Users in your Grocy Instance

    .DESCRIPTION
    Call the Grocy API to list all available Users

    .PARAMETER Username
    Find a user with the matching Username

    If undefined it will return all Users

    .EXAMPLE
    Get-GrocyUser admin

    .EXAMPLE
    Get-GrocyUser

    .NOTES
    Author: Christopher D Forkner
    Date: 12/30/2018

    #>
  [cmdletbinding()]
  param (
    $Username
  )

  if(!$global:grocyGlobal){
    Connect-Grocy
  }

  $URI = $global:grocyGlobal.uri

    $params = @{
      body =  @{}
        uri = "$URI/api/users/get"
        headers = @{
        "Content-Type" = "application/json"
        "GROCY-API-KEY" = $global:grocyGlobal.APIKEY
        }
        method = "Get"
      }

    $result = Invoke-WebRequest @params -SkipCertificateCheck
    $result = $result.Content | ConvertFrom-Json

    if($Username){
      $users = $result | Where-Object {$_.username -eq $Username}
    }
    if(!$Username){
      $users = $result
    }

    $User = foreach($i in $users){
      New-Object psobject -Property @{
        ID = $i.id
        Username = $i.username
        FirstName = $i.first_name
        LastName = $i.last_name
        Created = $i.row_created_timestamp
      }
    }

    $User
  }
