require "./soccer_api"
require "kemal"

get "/" do |env|
  env.response.content_type = "application/json"
  SoccerApi.fetch
end

Kemal.run
