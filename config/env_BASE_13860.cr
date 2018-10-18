require "dotenv"

begin
  Dotenv.load!
rescue
  Kemal::LogHandler.new.write("Cannot load without `.env` file.\n")
  exit 1
end
