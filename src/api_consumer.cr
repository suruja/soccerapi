require "crystagiri"
require "json"

class ApiConsumer
  SOURCE_URL  = "http://www.maxifoot.fr/calendrier-ligue1-2018-2019.htm"
  DATE_FORMAT = "%y%m%d"

  property document : Crystagiri::HTML
  property data : Array(NamedTuple(date: String, home: String, visitor: String, score: String | Nil))
  property memoized_date : String

  def initialize
    @document = Crystagiri::HTML.from_url SOURCE_URL
    @data = [] of NamedTuple(date: String, home: String, visitor: String, score: String | Nil)
    @memoized_date = Time.now.to_s(DATE_FORMAT)
    parse
  end

  def parse
    document.css("table.cd1") do |day|
      str_date = ""
      day_doc = Crystagiri::HTML.new(day.node.to_s)
      day_doc.css(".ch3") { |t| str_date = t.content.strip[-10, 10] }
      date = Time.parse(str_date, "%d/%m/%Y", Time::Location.load("Europe/Paris"))
      day_doc.css("tr.cl2") do |match|
        match_doc = Crystagiri::HTML.new(match.node.to_s)
        mdata = [] of String
        match_doc.css("td") { |t| mdata.push(t.content.strip) }
        match_doc.css("th") { |t| mdata.push(t.content.strip) }
        data.push({
          date:    date.to_s("%Y-%m-%d"),
          home:    mdata[0],
          visitor: mdata[1],
          score:   (mdata[2] == "-" ? nil : mdata[2]),
        })
      end
    end
  end

  def reset
    @document = Crystagiri::HTML.from_url SOURCE_URL
    @data = [] of NamedTuple(date: String, home: String, visitor: String, score: String | Nil)
    parse
  end

  def reset!
    current_date = Time.now.to_s(DATE_FORMAT)
    if current_date != @memoized_date
      @memoized_date = current_date
      reset
    end
  end

  def to_json
    JSON.build do |json|
      json.array do
        data.each do |item|
          json.object do
            item.each do |key, val|
              json.field key, val
            end
          end
        end
      end
    end
  end
end
