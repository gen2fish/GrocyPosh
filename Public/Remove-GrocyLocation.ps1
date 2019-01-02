function Remove-GrocyLocation {
    <#

    .SYNOPSIS
    Removes a Grocy Location.

    .DESCRIPTION
    Removes a Grocy Location.

    .PARAMETER Name
    Name of the Location to Remove. Required.

    .EXAMPLE
    Remove-GrocyLocation Fridge

    .NOTES
    Author: Christopher D Forkner
    Date: 31 Dec 2018

    #>
  [cmdletbinding()]
  Param(
    [Parameter(Mandatory = $true)][String]$Name
    )

    if(!$global:grocyGlobal){
      Connect-Grocy
    }

    $URI = $global:grocyGlobal.uri

    $location = Get-GrocyLocation -Name $Name

    if($location)
    {
      $id = $location.ID

      $params = @{
        body =  @{}
          uri = "$URI/api/delete-object/locations/$id"
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
          Write-Output 'Location Deleted Successfully'
        }
      } else {
        Write-Host 'Removal Cancelled'
      }


    }else{
      Write-Output 'No location found with that Name'
    }
  }
