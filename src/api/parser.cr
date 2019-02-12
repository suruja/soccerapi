require "crystagiri"

class Api::Parser
  property document : Crystagiri::HTML
  property data : Api::Matchs

  def initialize
    @document = Crystagiri::HTML.from_url Api::SOURCE_URL
    @data = [] of Api::Match
  end

  def parse
    document.css("table.cd1") do |day|
      str_date = ""
      day_doc = Crystagiri::HTML.new(day.node.to_s)
      day_doc.css(".ch3") { |t| str_date = extract_date(t.content) }
      date = parse_date(str_date)
      day_doc.css("tr.cl2") do |match|
        match_doc = Crystagiri::HTML.new(match.node.to_s)
        mdata = [] of String
        match_doc.css("td") { |t| mdata.push(t.content.strip) }
        match_doc.css("th") { |t| mdata.push(t.content.strip) }
        data.push({
          date:    date.to_s("%Y-%m-%d"),
          home:    mdata[0],
          visitor: mdata[1],
        }.merge(extract_score(mdata[2])))
      end
    end
  end

  private def extract_score(score) : NamedTuple(score: String | Nil, home_score: UInt8 | Nil, visitor_score: UInt8 | Nil)
    if score.match(/^[0-9]+\-[0-9]+$/)
      home_score, visitor_score = score.split("-").map { |i| i.to_u8 }
      {score: score, home_score: home_score, visitor_score: visitor_score}
    else
      {score: nil, home_score: nil, visitor_score: nil}
    end
  end

  private def extract_date(str)
    str.strip[-10, 10]
  end

  private def parse_date(str)
    Time.parse(
      str,
      "%d/%m/%Y",
      Time::Location.load("Europe/Paris")
    )
  end
end
