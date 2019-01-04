function Get-GrocyConfig($slack) {
  if($IsLinux -or $IsMacOS){
    $grocypath = '~/grocy-slack-config.cfg'
  }
  if($IsWindows){
    $grocypath = $env:LOCALAPPDATA + "\grocy-slack-config.cfg"
  }

  if(!(Test-Path $grocypath -PathType Leaf))
  {
    return
  }


  foreach($line in Get-Content $grocypath)
  {
    $line = $line.Split(':')
    if($line[0] -match $slack){
      $line[1]
      return
    }
  }
}
