require "kemal"
require "granite"
require "granite/adapter/pg"
require "pg"

Granite::Adapters << Granite::Adapter::Pg.new({ name: "pg", url: ENV["DATABASE_URL"] })

module LaPelleLoose
  VERSION = "0.2.0"
end

require "./routes/*"
require "./models/*"

static_headers do |response, filepath, filestat|
  response.headers.add("Access-Control-Allow-Origin", "*")
  response.headers.add("Content-Size", filestat.size.to_s)
end

error 404 do
  { error: :not_found }.to_json
end

get "/" do
  { data: 5 }.to_json
end

get "/cat" do
  { data: "Avion" }.to_json
end

Kemal.run
