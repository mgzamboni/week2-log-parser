require_relative 'lib/parser.rb'
require "json"

file = Parser.new('spec/fixtures/game_test.log')

puts "> get_first_line method return:\n#{file.get_first_line}\n"
puts "> get_nlines_json method return:\n#{JSON.pretty_generate(JSON.parse(file.get_gamelog_json))}\n"
