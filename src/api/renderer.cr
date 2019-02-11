require "json"

class Api::Renderer
  property data : Api::Matchs

  def initialize(@data)
  end

  def render
    JSON.build do |json|
      json.array do
        data.each do |item|
          json.object do
            item.each do |key, val|
              json.field key, val
            end
          end
        end
      end
    end
  end
end
