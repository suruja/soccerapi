require "json"
require "../core_ext"

class Api::Renderer
  property data : Api::Matchs

  def initialize(@data)
  end

  def render : String
    JSON.build do |json|
      json.array do
        data.each do |item|
          json.object do
            item.each do |key, val|
              json.field key.to_s.lowercamelcase, val
            end
          end
        end
      end
    end
  end
end
