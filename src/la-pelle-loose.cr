require "../config/env"
require "kemal"
require "granite"
require "granite/adapter/pg"
require "pg"
require "json"

Granite::Adapters << Granite::Adapter::Pg.new({ name: "pg", url: ENV["DATABASE_URL"] })
Granite.settings.logger = Logger.new(STDOUT) if ENV["KEMAL_ENV"] == nil

require "./macros/*"
require "./routes/*"
require "./models/*"
require "./services/*"

before_all do |env|
  env.response.content_type = "application/json"
  env.response.headers.add("Access-Control-Allow-Origin", "*")
  env.response.headers.add("Access-Control-Allow-Headers", "Content-Type")
  env.response.headers.add("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
  # env.response.headers.add("Content-Size", filestat.size.to_s)
end

options "/*" do
end

Kemal.run
