require "crystagiri"

result = [] of NamedTuple(date: String, domicile: String, visiteur: String, score: String | Nil)
doc = Crystagiri::HTML.from_url "http://www.maxifoot.fr/calendrier-ligue1-2018-2019.htm"

doc.css("table.cd1") { |day|
  str_date = ""
  day_doc = Crystagiri::HTML.new(day.node.to_s)
  day_doc.css(".ch3") { |t| str_date = t.content.strip[-10, 10] }
  date = Time.parse(str_date, "%d/%m/%Y", Time::Location.load("Europe/Paris")).to_s("%Y-%m-%d")
  day_doc.css("tr.cl2") { |match|
    match_doc = Crystagiri::HTML.new(match.node.to_s)
    data = [] of String
    match_doc.css("td") { |t| data.push(t.content.strip) }
    match_doc.css("th") { |t| data.push(t.content.strip) }
    result.push({
      date:     date,
      domicile: data[0],
      visiteur: data[1],
      score:    (data[2] == "-" ? nil : data[2]),
    })
  }
}

puts result
