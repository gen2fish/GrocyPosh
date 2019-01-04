function New-GrocyChore {
  <#

  .SYNOPSIS
  Creates a New Grocy Chore

  .DESCRIPTION
  Creates a New Grocy Chore via Powershell wrapper of REST Api

  .PARAMETER Name
  Name of the Location to create. Required.

  .PARAMETER Description
  Description of the created location. Not required. Can be hastable or string.

  .PARAMETER Type
  Is the Chore a Manual Chore or a Dynamically Regular Chore.
  Dyamic
  Manual

  .PARAMETER Days
  If a Dynamic Chore, how many days are between iterations of the Chore. Default is 1

  .EXAMPLE
  New-GrocyChore -Name Unload-Dishwasher -Description @{'Assigned'='Dad'} -Type Dynamic -Days 1

  .NOTES
  Author: Christopher D Forkner
  Date: 31 Dec 2018

  #>
[cmdletbinding()]
Param(
  [Parameter(Mandatory = $true)]
  [String]$Name,

  $Description,

  [Parameter(Mandatory = $true)]
  [ValidateSet("Dynamic","Manual")]
  [String]$Type,

  [Int]$Days = 1

  )

  if(!$global:grocyGlobal){
    Connect-Grocy
  }
  if($Type -match "Dynamic")
  {
    $period = "dynamic-regular"
  }else
  {
    $period = "manually"
  }
  $URI = $global:grocyGlobal.uri

  if($Description -is [System.Collections.Hashtable])
  {
    $k = $Description.Keys
    $v = $Description.Values

    $desc = ""
    $count = 0
    foreach($i in $k)
    {
      $desc = $desc + $k[$count] + '=' + $v[$count] + "`n"
    }
    $Description = $desc
  }

  $params = @{
    body =  @{
      "name" = $Name
      "description" = $Description
      "period_type" = $period
      "period_days" = $Days
    } | ConvertTo-Json
      uri = "$URI/api/add-object/chores"
      headers = @{
      "Content-Type" = "application/json"
      "GROCY-API-KEY" = $global:grocyGlobal.APIKEY
      }
      method = "Post"
    }

  $result = Invoke-WebRequest @params -SkipCertificateCheck

  if($result.StatusCode -eq '200')
  {
    $newchore = Get-GrocyChore -Name $Name
    $newchore
  }else{
    $result
  }
}
