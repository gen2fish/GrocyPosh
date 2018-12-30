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

    .NOTES
    Author: Christopher D Forkner
    Date: 12/30/2018

    #>

  param (
    Parameter(Mandatory = $true)]$Chore
  )
  $chores = Get-GrocyChore | ? {$_.ChoreName -eq $Chore}

  try{
    $choreid = $chores.ChoreID
    $Execute = Get-Date -UFormat "%Y-%m-%d %T"
    $URI = 'https://grocy.fish.local'


    $params = @{
      body =  @{
        "tracked_time" = $Execute
      }
        uri = "$URI/api/chores/track-chore-execution/$choreid"
        headers = @{
        "Content-Type" = "application/json"
        "GROCY-API-KEY" = "nWFXh38FtcN0rrADfkz2mM4RCxLBxzEyIozKIr3JurmOsvVNNi"
        }
        method = "Get"
      }

    $result = Invoke-WebRequest @params
    $result = $result.Content | ConvertFrom-Json

    $result
  }
  catch
  {
    "Invalid Chore Name"
  }
  }
