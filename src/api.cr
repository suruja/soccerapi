require "./core_ext"
require "./api/parser"
require "./api/renderer"
require "./api/filterer"
require "./api/consumer"

module Api
  SOURCE_URL  = "http://www.maxifoot.fr/calendrier-ligue1-2018-2019.htm"
  DATE_FORMAT = "%y%m%d"
  TIME_ZONE   = "Europe/Paris"
  alias Score = NamedTuple(
    score: String?,
    home_score: UInt8?,
    visitor_score: UInt8?,
  )
  alias Match = NamedTuple(
    date: String,
    home: String,
    visitor: String,
    score: String?,
    home_score: UInt8?,
    visitor_score: UInt8?,
  )
  alias Matchs = Array(Match)
end
