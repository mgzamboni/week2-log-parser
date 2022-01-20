require_relative 'lib/parser.rb'

fl = Parser.new('logs/games.log')

puts fl.get_first_line
puts fl.get_nlines_json
