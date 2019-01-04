function Get-GrocyChore {
    <#

    .SYNOPSIS
    Gets the Chores in your Grocy Instance

    .DESCRIPTION
    Call the Grocy API to list all available ChoreIDs then call each ID found for the Name and description of the Chore

    .PARAMETER Name
    Find a single chore with the name

    If undefined it will return all Chores

    .EXAMPLE
    Get-GrocyChore -Name Unload-Dishwasher

    .EXAMPLE
    Get-GrocyChore

    .NOTES
    Author: Christopher D Forkner
    Date: 12/30/2018

    #>
  param (
    $Name
  )

  if(!$global:grocyGlobal){
    Connect-Grocy
  }

  $URI = $global:grocyGlobal.uri

  $chores = Get-GrocyChoreID

  function callChores($choreid){
    $params = @{
      body =  @{}
        uri = "$URI/api/chores/get-chore-details/$choreid"
        headers = @{
        "Content-Type" = "application/json"
        "GROCY-API-KEY" = $global:grocyGlobal.APIKEY
        }
        method = "Get"
      }



    # web request + result ftw
    $result = Invoke-WebRequest @params -SkipCertificateCheck
    $result = $result.Content | ConvertFrom-Json

    $Chore = New-Object psobject -Property @{
      LastDoneBy = $result.last_done_by.first_name
      LastDone = $result.last_tracked
      ChoreName = $result.chore.name
      ID = $result.chore.id
    }
    $p = $result.chore.description.Split("`n")

    foreach($i in $p)
    {
      if($i -like '*=*')
      {
        $s = $i.split("=")
        $Chore | Add-Member -NotePropertyName $s[0] -NotePropertyValue $s[1]
      }
    }

    $Chore

    }

    if($Name){
      $allchores = foreach ($i in $chores) {
        callChores($i.chore_id) | Where-Object {$_.ChoreName -eq $Name}
      }
      $allchores
    }

    if (!$Name){
      $allchores = foreach ($i in $chores) {
        callChores($i.chore_id)
      }
      $allchores
      }
  }
