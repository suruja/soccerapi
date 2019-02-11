require "kemal"
require "./api"

consumer = Api::Consumer.new

before_all do |env|
  puts "Setting response content type"
  env.response.content_type = "application/json"
  consumer.reset!
end

get "/" do |env|
  filterer = Api::Filterer.new(
    data: consumer.data.as(Api::Matchs),
    date: env.params.query.fetch("date", nil),
    team: env.params.query.fetch("team", nil),
  )
  renderer = Api::Renderer.new(
    data: filterer.filter,
  )
  renderer.render
end

Kemal.run
