require "./renderer"
require "./parser"

class Api::Consumer
  property memoized_date : String
  property parser : Api::Parser

  def initialize
    @parser = Api::Parser.new
    parser.parse
    @memoized_date = Time.now.to_s(Api::DATE_FORMAT)
  end

  def reset
    puts "Fetching #{Api::SOURCE_URL}..."
    initialize
  end

  delegate data, to: @parser

  def reset!
    current_date = Time.now.to_s(Api::DATE_FORMAT)
    if current_date != @memoized_date
      @memoized_date = current_date
      reset
    end
  end
end
