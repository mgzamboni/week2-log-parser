require "parser.rb"

describe "Parser" do
    it "reads the first line of the games.log file" do
        fl = Parser.new("logs/games.log")
        expect(fl.get_first_line).to be_a(String)
    end

    it "checks if the file exists" do
        fl = Parser.new("")
        expect{fl.get_first_line}.to raise_error(RuntimeError, 'file or directory not found')

    end
end
