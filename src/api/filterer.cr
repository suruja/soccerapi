class Api::Filterer
  property data : Api::Matchs
  property date : String | Nil
  property before : String | Nil
  property after : String | Nil
  property team : String | Nil
  property home : String | Nil
  property visitor : String | Nil

  def initialize(@data, @date, @team, @before, @after, @home, @visitor)
  end

  def filter : Api::Matchs
    data.select do |item|
      keep = date ? (item["date"] == date) : true
      keep &= before ? (item["date"] <= before.as(String)) : true
      keep &= after ? (item["date"] >= after.as(String)) : true
      keep &= team ? ((item["home"] == team) || (item["visitor"] == team)) : true
      keep &= home ? (item["home"] == team) : true
      keep &= visitor ? (item["visitor"] == team) : true
      keep
    end
  end
end
