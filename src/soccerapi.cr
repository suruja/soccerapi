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
    before: env.params.query.fetch("before", nil),
    after: env.params.query.fetch("after", nil),
    team: env.params.query.fetch("team", nil),
    home: env.params.query.fetch("home", nil),
    visitor: env.params.query.fetch("visitor", nil),
  )
  renderer = Api::Renderer.new(
    data: filterer.filter,
  )
  renderer.render
end

Kemal.run
