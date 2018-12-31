function Get-SlacktoGrocy($from) {

# UF08S5DS5:christopher.d.forkner
# UF0PFK8UT:breann.forkner
# UF20NFLR5:christopherforknerii
# UF291TANS:caiden.forkner
# UF2R6QDL0:bfeugate

  switch ($from)
  {
    'UF08S5DS5' { $APIKEY = 'nWFXh38FtcN0rrADfkz2mM4RCxLBxzEyIozKIr3JurmOsvVNNi' }
  }

  $grocy = @{
    "uri" = "https://grocy.fish.local"
    "apikey" = $APIKEY
  }

  $grocy
}
