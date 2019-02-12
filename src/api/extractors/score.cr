class Api::Extractors::Score
  property data : String
  property score : String?
  property home_score : UInt8?
  property visitor_score : UInt8?

  def initialize(@data)
    @data = @data.strip
    @score = nil
    @home_score = nil
    @visitor_score = nil
  end

  def extract : Api::Score
    if data.match(/^[0-9]+\-[0-9]+$/)
      @score = data
      @home_score, @visitor_score = data.split("-").map { |i| i.to_u8 }
    end
    render
  end

  def render : Api::Score
    {
      score:         data,
      home_score:    home_score,
      visitor_score: visitor_score,
    }
  end
end
