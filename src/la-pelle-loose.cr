require "../config/env"
require "kemal"
require "granite"
require "granite/adapter/pg"
require "pg"

Granite::Adapters << Granite::Adapter::Pg.new({ name: "pg", url: ENV["DATABASE_URL"] })

require "./routes/*"
require "./models/*"

static_headers do |response, filepath, filestat|
  response.headers.add("Access-Control-Allow-Origin", "*")
  response.headers.add("Content-Size", filestat.size.to_s)
end

Kemal.run
