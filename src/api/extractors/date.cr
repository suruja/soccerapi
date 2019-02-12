class Api::Extractors::Date
  property data : String

  def initialize(@data)
    @data = @data.strip[-10, 10]
  end

  def extract : Time
    Time.parse(
      data,
      "%d/%m/%Y",
      Time::Location.load(Api::TIME_ZONE)
    )
  end
end
