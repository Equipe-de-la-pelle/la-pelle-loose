require "dotenv"

begin
  source = ENV["KEMAL_ENV"] == "test" ? ".env.test" : ".env"
  Dotenv.load!(source)
rescue
  exit 1
end
