function Get-GrocyLocation {
    <#

    .SYNOPSIS
    Displays Location Information

    .DESCRIPTION
    Displays the information about a Grocy Location

    .PARAMETER Name
    Name of the Location to grab the details of.  Not required. If missing will display all locations.

    .EXAMPLE
    Get-GrocyLocation Fridge

    Get-GrocyLocation

    .NOTES
    Author: Christopher D Forkner
    Date: 31 Dec 2018

    #>
  [cmdletbinding()]
  Param(
    [String]$Name
    )

    if(!$global:grocyGlobal){
      Connect-Grocy
    }

    $URI = $global:grocyGlobal.uri

    $params = @{
      body =  @{} | ConvertTo-Json
        uri = "$URI/api/get-objects/locations"
        headers = @{
        "Content-Type" = "application/json"
        "GROCY-API-KEY" = $global:grocyGlobal.APIKEY
        }
        method = "Get"
      }

    $result = Invoke-WebRequest @params -SkipCertificateCheck
    $result = $result.Content | ConvertFrom-Json

    $location = foreach($i in $result){
      New-Object psobject -Property @{
        ID = $i.id
        Name = $i.name
        Description = $i.description
        Created = $i.row_created_timestamp
      }
    }

    if($Name)
    {
      $location | Where-Object {$_.Name -eq $Name}
    }
    else {
      $location
    }
  }
