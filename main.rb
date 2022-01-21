require_relative 'lib/parser'
require 'json'

file = Parser.new('spec/fixtures/game_test.log')

puts "> first_line method return:\n#{file.first_line}\n"
puts "> gamelog_json method return:\n#{JSON.pretty_generate(JSON.parse(file.gamelog_json))}\n"
