require 'json'

class Parser
  attr_accessor :file_pathname

  def initialize(file_pathname)
    @file_pathname = file_pathname
  end

  def first_line
    File.foreach(file_pathname).first unless validate_file
  end

  def gamelog_json
    { File.basename(file_pathname) => { 'lines' => gamelog_data[0], 'players' => gamelog_data[1] } }.to_json unless validate_file
  end

  private

  def validate_file
    raise 'file or directory not found' unless File.file?(file_pathname)
  end

  def gamelog_data
    players_arr = []
    count = 0
    File.foreach(file_pathname) do |line|
      filter_player_names(line.split(' '), players_arr)
      count += 1
    end
    [count, players_arr]
  end

  def kill_data(log_line, players_arr)
    killed_index = log_line.index 'killed'
    by_index = log_line.index 'by'
    player_killer = log_line[5..killed_index - 1].join(' ')
    player_killed = log_line[killed_index + 1..by_index - 1].join(' ')
    unless players_arr.include? player_killer
      players_arr << player_killer unless player_killer == '<world>'
    end
    players_arr << player_killed unless players_arr.include? player_killed
  end

  def filter_player_names(log_line, players_arr)
    case log_line[1]
    when 'Kill:'
      kill_data(log_line, players_arr)

    when 'ClientUserinfoChanged:'
      user_name = log_line[3].split('\\')[1]
      players_arr << user_name unless players_arr.include? user_name
    end
    players_arr
  end
end
