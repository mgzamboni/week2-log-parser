require_relative "lib/parser.rb"

fl = Parser.new("logs/games.log").get_first_line
puts fl
