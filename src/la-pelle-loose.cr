require "../config/env"
require "kemal"
require "granite"
require "granite/adapter/pg"
require "pg"

Granite::Adapters << Granite::Adapter::Pg.new({ name: "pg", url: ENV["DATABASE_URL"] })

require "./routes/*"
require "./models/*"
require "./services/*"

static_headers do |response, filepath, filestat|
  response.headers.add("Access-Control-Allow-Origin", "*")
  response.headers.add("Content-Size", filestat.size.to_s)
end

before_all do |env|
  env.response.content_type = "application/json"
  env.response.headers.add("Access-Control-Allow-Origin", "*")
  # env.response.headers.add("Content-Size", filestat.size.to_s)
end

Kemal.run
