function New-GrocyChoreDone {
    <#

    .SYNOPSIS
    Executes a Chore

    .DESCRIPTION
    Call the Grocy API to execute an instance of a Chore

    .PARAMETER Chore
    Name of a Chore

    Required.

    .EXAMPLE
    New-GrocyChoreDone -Chore Unload-Dishwasher

    New-GrocyChoreDone Unload-Dishwasher
    .NOTES
    Author: Christopher D Forkner
    Date: 12/30/2018

    #>

  [cmdletbinding()]
  Param(
    [Parameter(Mandatory = $true)][String]$Chore
    )

  $chores = Get-GrocyChore | Where-Object {$_.ChoreName -eq $Chore}

  try{
    $choreid = $chores.ChoreID
    $Execute = Get-Date -UFormat "%Y-%m-%d %T"

    if(!$global:grocyGlobal){
      Connect-Grocy
    }

    $URI = $global:grocyGlobal.uri

    $params = @{
      body =  @{
        "tracked_time" = $Execute
      }
        uri = "$URI/api/chores/track-chore-execution/$choreid"
        headers = @{
        "Content-Type" = "application/json"
        "GROCY-API-KEY" = $global:grocyGlobal.APIKEY
        }
        method = "Get"
      }

    $result = Invoke-WebRequest @params -SkipCertificateCheck
    $result = $result.Content | ConvertFrom-Json

    $result
  }
  catch
  {
    "Invalid Chore Name"
  }
  }
