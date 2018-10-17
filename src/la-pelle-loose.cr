require "kemal"

module LaPelleLoose
  VERSION = "0.1.0"
end

Granite::Adapters << Granite::Adapter::Mysql.new({name: "mysql", url: "YOUR_DATABASE_URL"})

static_headers do |response, filepath, filestat|
  if filepath =~ /\.html$/
    response.headers.add("Access-Control-Allow-Origin", "*")
  end
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
