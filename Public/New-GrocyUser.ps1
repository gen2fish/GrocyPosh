function New-GrocyUser {
  #Doesn't Work awaiting https://github.com/grocy/grocy/issues/126
  param (
    [Parameter(Mandatory = $true)]$UserName,
    $FirstName,
    $LastName,
    [Parameter(Mandatory = $true)]$Passwd
  )

  $Execute = Get-Date -UFormat "%Y-%m-%d %T"

  if(!$global:grocyGlobal){
    Connect-Grocy
  }

  $URI = $global:grocyGlobal.uri

  $params = @{
    body =  @{
      "username" = "$UserName"
      "first_name" = "$FirstName"
      "last_name" = "$LastName"
      "password" = "$Passwd"
    }
      uri = "$URI/api/users/create"
      headers = @{
      "accept" = "application/json"
      "Content-Type" = "application/json"
      "GROCY-API-KEY" = $global:grocyGlobal.APIKEY
      }
      method = "Post"
    }

    $params.body
    $result = Invoke-WebRequest @params -SkipCertificateCheck
    $result = $result.Content | ConvertFrom-Json

    $result

  }
