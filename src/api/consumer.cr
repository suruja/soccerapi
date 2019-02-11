require "crystagiri"

class Api::Consumer
  property document : Crystagiri::HTML
  property data : Api::Matchs
  property memoized_date : String

  def initialize
    @document = Crystagiri::HTML.from_url Api::SOURCE_URL
    @data = [] of Api::Match
    @memoized_date = Time.now.to_s(Api::DATE_FORMAT)
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
    @document = Crystagiri::HTML.from_url Api::SOURCE_URL
    @data = [] of Api::Match
    parse
  end

  def reset!
    current_date = Time.now.to_s(Api::DATE_FORMAT)
    if current_date != @memoized_date
      @memoized_date = current_date
      reset
    end
  end

  def render(date : String | Nil = nil)
    result = date ? data.select { |item| item[:date] == date } : data
    Api::Renderer.new(result).render
  end
end
