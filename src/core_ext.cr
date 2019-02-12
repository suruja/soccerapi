class String
  def lowercamelcase
    result = camelcase
    result[0].downcase + result[1..-1]
  end
end
