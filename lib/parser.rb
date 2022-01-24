require 'json'

class Parser
  attr_accessor :file_pathname

  def initialize(file_pathname)
    raise 'file or directory not found' unless File.file?(file_pathname)

    @file_pathname = file_pathname
  end

  def first_line
    File.foreach(file_pathname).first
  end

  def gamelog_json
    players_arr = []
    count = 0
    File.foreach(file_pathname) do |line|
      kill_data(line.split(' '), players_arr)
      infochange_data(line.split(' '), players_arr)
      count += 1
    end
    { File.basename(file_pathname) => { 'lines' => count, 'players' => players_arr } }.to_json
  end

  private

  def kill_data(log_line, players_arr)
    unless log_line[1] != 'Kill:'
      killed_index = log_line.index 'killed'
      by_index = log_line.index 'by'
      player_killer = log_line[5..killed_index - 1].join(' ')
      player_killed = log_line[killed_index + 1..by_index - 1].join(' ')
      unless players_arr.include? player_killer
        players_arr << player_killer unless player_killer == '<world>'
      end
      players_arr << player_killed unless players_arr.include? player_killed
    end
  end

  def infochange_data(log_line, players_arr)
    unless log_line[1] != 'ClientUserinfoChanged:'
      players_arr << log_line[3].split('\\')[1] unless players_arr.include? log_line[3].split('\\')[1]
    end
  end
end
