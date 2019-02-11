require "crystagiri"
require "json"

class SoccerApi
  SOURCE_URL = "http://www.maxifoot.fr/calendrier-ligue1-2018-2019.htm"

  def self.fetch
    doc = Crystagiri::HTML.from_url SOURCE_URL
    JSON.build do |json|
      json.array do
        doc.css("table.cd1") do |day|
          str_date = ""
          day_doc = Crystagiri::HTML.new(day.node.to_s)
          day_doc.css(".ch3") { |t| str_date = t.content.strip[-10, 10] }
          date = Time.parse(str_date, "%d/%m/%Y", Time::Location.load("Europe/Paris"))
          day_doc.css("tr.cl2") do |match|
            match_doc = Crystagiri::HTML.new(match.node.to_s)
            data = [] of String
            match_doc.css("td") { |t| data.push(t.content.strip) }
            match_doc.css("th") { |t| data.push(t.content.strip) }
            json.object do
              json.field "date", date.to_s("%Y-%m-%d")
              json.field "home", data[0]
              json.field "visitor", data[1]
              json.field "score", (data[2] == "-" ? nil : data[2])
            end
          end
        end
      end
    end
  end
end
