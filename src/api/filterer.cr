require "./filter"

class Api::Filterer
  property data : Api::Matchs
  property date : String?
  property before : String?
  property after : String?
  property team : String?
  property home : String?
  property visitor : String?

  def initialize(@data, @date, @team, @before, @after, @home, @visitor)
  end

  def filter : Api::Matchs
    data.select do |item|
      Api::Filter.new(date).eval { |v| item["date"] == v } &&
        Api::Filter.new(before).eval { |v| item["date"] <= v } &&
        Api::Filter.new(after).eval { |v| item["date"] >= v } &&
        Api::Filter.new(team).eval { |v| (item["home"] == v) || (item["visitor"] == v) } &&
        Api::Filter.new(home).eval { |v| item["home"] == v } &&
        Api::Filter.new(visitor).eval { |v| item["visitor"] == v }
    end
  end
end
