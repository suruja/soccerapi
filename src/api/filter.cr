class Api::Filter
  property value : String?

  def initialize(@value)
  end

  def eval(&block) : Bool
    return true unless value
    yield(value.as(String)).as(Bool)
  end
end
