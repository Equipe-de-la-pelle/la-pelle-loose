require "../config/env"
require "kemal"
require "granite"
require "granite/adapter/pg"
require "pg"

Granite::Adapters << Granite::Adapter::Pg.new({ name: "pg", url: ENV["DATABASE_URL"] })

require "./routes/*"
require "./models/*"
require "./services/*"


before_all do |env|
  env.response.content_type = "application/json"
  env.response.headers.add("Access-Control-Allow-Origin", "*")
  env.response.headers.add("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE")
  # env.response.headers.add("Content-Size", filestat.size.to_s)
end

Kemal.run
