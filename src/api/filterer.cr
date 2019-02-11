class Api::Filterer
  property data : Api::Matchs
  property date : String | Nil
  property team : String | Nil

  def initialize(@data, @date, @team)
  end

  def filter
    data.select do |item|
      keep = date ? (item["date"] == date) : true
      keep &= team ? ((item["home"] == team) || (item["visitor"] == team)) : true
      keep
    end
  end
end
