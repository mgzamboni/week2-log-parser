require 'json'

# This function will receive the path to a game.log file and will return
# a json with filtered contents of the file.
class Parser
  attr_accessor :file_pathname

  def initialize(file_pathname)
    @file_pathname = file_pathname
  end

  def first_line
    File.foreach(file_pathname).first unless validate_file
  end

  def gamelog_json
    { File.basename(file_pathname) => { 'lines' => num_lines } }.to_json
  end

  private

  def validate_file
    raise 'file or directory not found' unless File.file?(file_pathname)
  end

  def num_lines
    File.foreach(file_pathname).inject(0) { |count| count + 1 } unless validate_file
  end
end
