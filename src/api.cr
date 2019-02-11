require "./api/consumer"
require "./api/renderer"
require "./api/filterer"

module Api
  SOURCE_URL  = "http://www.maxifoot.fr/calendrier-ligue1-2018-2019.htm"
  DATE_FORMAT = "%y%m%d"
  alias Match = NamedTuple(
    date: String,
    home: String,
    visitor: String,
    score: String | Nil,
  )
  alias Matchs = Array(Match)
end
