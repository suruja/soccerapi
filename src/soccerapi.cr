require "kemal"
require "./api_consumer"

consumer = ApiConsumer.new

get "/" do |env|
  env.response.content_type = "application/json"
  consumer.reset!
  consumer.to_json
end

Kemal.run
