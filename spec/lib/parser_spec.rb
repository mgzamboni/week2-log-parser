require 'parser.rb'

describe 'Parser' do
  it 'reads the first line of the games.log file' do
    fl = Parser.new('spec/fixtures/game_test.log')
    expect(fl.get_first_line).to be_a(String)
  end

  it 'checks if the file exists' do
    fl = Parser.new('invalid_directory/invalid_file.txt')
    expect{fl.get_first_line}.to raise_error(RuntimeError, 'file or directory not found')
  end

  it 'checks if reading from valid file' do
    fl = Parser.new('spec/fixtures/game_test.log').get_first_line
    expect(fl).to eql("  0:00 ------------------------------------------------------------\n")
  end

  it 'counts the number of lines of a file' do
    fl = Parser.new('spec/fixtures/game_test.log').get_nlines
    expect(fl).to eql(10)
  end
end
