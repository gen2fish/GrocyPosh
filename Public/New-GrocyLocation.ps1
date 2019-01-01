function New-GrocyLocation {
    <#

    .SYNOPSIS
    Creates a New Grocy Location

    .DESCRIPTION
    Creates a New Grocy Location

    .PARAMETER Name
    Name of the Location to create. Required.

    .PARAMETER Description
    Description of the created location. Not required

    .EXAMPLE
    New-GrocyLocation Fridge

    New-GrocyLocation -Name Fridge -Description 'Fridge in the Kitchen'

    .NOTES
    Author: Christopher D Forkner
    Date: 31 Dec 2018

    #>
  [cmdletbinding()]
  Param(
    [Parameter(Mandatory = $true)][String]$Name,
    [String]$Description
    )

    if(!$global:grocyGlobal){
      Connect-Grocy
    }

    $URI = $global:grocyGlobal.uri

    $params = @{
      body =  @{
        "name" = $Name
        "description" = $Description
      } | ConvertTo-Json
        uri = "$URI/api/add-object/locations"
        headers = @{
        "Content-Type" = "application/json"
        "GROCY-API-KEY" = $global:grocyGlobal.APIKEY
        }
        method = "Post"
      }

    $result = Invoke-WebRequest @params -SkipCertificateCheck
    $result = $result.Content | ConvertFrom-Json

    if($result.success -eq 'True')
    {
      $location = Get-GrocyLocation $Name
      $location
    }else{
      $result
    }

  }
