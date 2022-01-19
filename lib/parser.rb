require 'json'

class Parser
  attr_accessor :file_pathname

  def initialize(file_pathname)
    @file_pathname = file_pathname
  end

  def get_first_line
    first_line = File.foreach(file_pathname).first unless validate_file
  end

  private

  def validate_file
    raise 'file or directory not found' unless File.file?(file_pathname)
  end

  def get_nlines
    first_line = File.foreach(file_pathname).inject(0) {|count, line| count+1} unless validate_file
  end 

end
