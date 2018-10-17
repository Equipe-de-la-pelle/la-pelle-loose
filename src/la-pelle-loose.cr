require "kemal"

module LaPelleLoose
  VERSION = "0.1.0"
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
