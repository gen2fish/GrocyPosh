function Get-SlacktoGrocy($from) {
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


# UF08S5DS5:christopher.d.forkner
# UF0MS1N8L:trello2
# UF0PFK8UT:breann.forkner
# UF0STBZ6E:workast
# UF10HM7NE:powerschool
# UF20NFLR5:christopherforknerii
# UF291TANS:caiden.forkner
# UF2R6QDL0:bfeugate
# UF3KR1PBL:house-bot
# USLACKBOT:slackbot
