function New-GrocyConfig {
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory = $true)][String]$API,
    [String]$SlackID
  )

  if($IsLinux -or $IsMacOS){
    $grocypath = '~/'
    $grocyfile = $grocypath + "grocy-slack-config.cfg"
  }
  if($IsWindows){
    $grocypath = $env:LOCALAPPDATA
    $grocyfile = $grocypath + "\grocy-slack-config.cfg"
  }

  if(!(Test-Path $grocyfile -PathType Leaf))
  {
    New-Item -Path $grocypath -Name "grocy-slack-config.cfg" -ItemType "file"
  }

  if($global:PoshBotContext.CallingUserInfo.Id)
  {
    $slack = $global:PoshBotContext.CallingUserInfo.Id
  }
  if($SlackID)
  {
    $slack = $SlackID
  }
  if(!$SlackID -and !$global:PoshBotContext.CallingUserInfo.Id)
  {
    Write-Output "No Slack ID Found or Provided"
    return
  }


  $exists = Get-GrocyConfig($slack)
  if($exists)
  {
    Write-Error "That API Key is already Registered"
    return
  }

  $line = $slack + ":" + $API + "`n"
  Add-Content $grocyfile $line

}
