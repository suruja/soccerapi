require "crystagiri"
require "./extractors/date"
require "./extractors/score"
require "./extractors/team"

class Api::Parser
  property document : Crystagiri::HTML
  property data : Api::Matchs

  def initialize
    @document = Crystagiri::HTML.from_url Api::SOURCE_URL
    @data = [] of Api::Match
  end

  def parse
    document.css("table.cd1") do |day|
      ddoc = Crystagiri::HTML.new(day.node.to_s)
      ddate = ddoc.css(".ch3") { }.first.content
      ddoc.css("tr.cl2") do |match|
        mdoc = Crystagiri::HTML.new(match.node.to_s)
        mdata = (mdoc.css("td") { } + mdoc.css("th") { }).map { |t| t.content }
        mscore = Api::Extractors::Score.new(mdata[2]).extract
        data.push({
          date:    Api::Extractors::Date.new(ddate).extract.to_s("%Y-%m-%d"),
          home:    Api::Extractors::Team.new(mdata[0]).extract,
          visitor: Api::Extractors::Team.new(mdata[1]).extract,
        }.merge(mscore))
      end
    end
  end
end
