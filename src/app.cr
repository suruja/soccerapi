require "kemal"
require "./api"

get "/" do |env|
  env.response.content_type = "application/json"
  Api.fetch
end

Kemal.run
