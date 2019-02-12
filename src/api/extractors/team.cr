class Api::Extractors::Team
  property data : String

  def initialize(@data)
    @data = @data.strip
  end

  def extract : String
    data
  end
end
