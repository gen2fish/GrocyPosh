function Remove-GrocyChore {
  <#

  .SYNOPSIS
  Removes a Grocy Chore

  .DESCRIPTION
  Removes a Grocy Chore.

  .PARAMETER Name
  Name of the Chore to Remove. Required.

  .EXAMPLE
  Remove-GrocyChore Unload-Dishwasher

  .NOTES
  Author: Christopher D Forkner
  Date: 1 Jan 2019

  #>
[cmdletbinding()]
Param(
  [Parameter(Mandatory = $true)][String]$Name
  )

  if(!$global:grocyGlobal){
    Connect-Grocy
  }

  $URI = $global:grocyGlobal.uri

  $chore = Get-GrocyChore -Name $Name

  if($chore)
  {
    $id = $chore.ID

    $params = @{
      body =  @{}
        uri = "$URI/api/delete-object/chores/$id"
        headers = @{
        "Content-Type" = "application/json"
        "GROCY-API-KEY" = $global:grocyGlobal.APIKEY
        }
        method = "Get"
      }

    $message  = 'This action is not reversible. Any items in the location will have to be moved.'
    $question = 'Are you sure you want to proceed?'

    $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
    $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

    $decision = $Host.UI.PromptForChoice($message, $question, $choices, 1)
    if ($decision -eq 0) {
      $result = Invoke-WebRequest @params -SkipCertificateCheck

      if($result.StatusCode -eq '200'){
        Write-Output 'Chore Deleted Successfully'
      }
    } else {
      Write-Host 'Removal Cancelled'
    }


  }else{
    Write-Output 'No Chore found with that Name'
  }
}
