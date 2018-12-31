function Get-GrocyChoreID {


    $Execute = Get-Date -UFormat "%Y-%m-%d %T"
    $URI = 'https://grocy.fish.local'


  $params = @{
    body =  @{}
      uri = "$URI/api/chores/get-current"
      headers = @{
      "Content-Type" = "application/json"
      "GROCY-API-KEY" = "nWFXh38FtcN0rrADfkz2mM4RCxLBxzEyIozKIr3JurmOsvVNNi"
      }
      method = "Get"
    }


  $result = Invoke-WebRequest @params -SkipCertificateCheck
  $result = $result.Content | ConvertFrom-Json

  $result

  }
