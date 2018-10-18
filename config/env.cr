require "dotenv"

begin
  Dotenv.load!
rescue
  exit 1
  puts "Coucou"
end
