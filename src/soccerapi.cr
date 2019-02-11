require "kemal"
require "./api_consumer"

consumer = ApiConsumer.new

before_all do |env|
  puts "Setting response content type"
  env.response.content_type = "application/json"
  consumer.reset!
end

get "/" do
  consumer.render
end

get "/:date" do |env|
  consumer.render(env.params.url["date"])
end

Kemal.run
