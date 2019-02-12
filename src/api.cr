require "./api/parser"
require "./api/renderer"
require "./api/filterer"
require "./api/consumer"

module Api
  SOURCE_URL  = "http://www.maxifoot.fr/calendrier-ligue1-2018-2019.htm"
  DATE_FORMAT = "%y%m%d"
  alias Score = NamedTuple(
    score: String | Nil,
    home_score: UInt8 | Nil,
    visitor_score: UInt8 | Nil,
  )
  alias Match = NamedTuple(
    date: String,
    home: String,
    visitor: String,
    score: String | Nil,
    home_score: UInt8 | Nil,
    visitor_score: UInt8 | Nil,
  )
  alias Matchs = Array(Match)
end
