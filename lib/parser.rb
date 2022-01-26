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
    { File.basename(file_pathname) => { 'lines' => count_lines, 'players' => filter_players } }.to_json
  end

  private

  def count_lines
    File.foreach(file_pathname).count
  end

  def filter_players
    players_arr = []
    File.foreach(file_pathname) do |log_line|
      kill_data(log_line, players_arr) if log_type(log_line, 'Kill')
      infochange_data(log_line, players_arr) if log_type(log_line, 'ClientUserinfoChanged')
    end
    players_arr
  end

  def log_type(log_line, log_type)
    log_line.split(' ')[1] == "#{log_type}:"
  end

  def infochange_data(log_line, players_arr)
    players_arr << log_line.split('\\', 3)[1] unless players_arr.include? log_line.split('\\', 3)[1]
  end

  def kill_data(log_line, players_arr)
    filter_killer(log_line.split(':', 4)[3].split(' '), players_arr)
    filter_killed(log_line.split(':', 4)[3].split(' '), players_arr)
  end

  def filter_killer(log_line, players_arr)
    player_killer = log_line[0..word_index(log_line, 'killed') - 1].join(' ')
    players_arr << player_killer if (!players_arr.include? player_killer) && (player_killer != '<world>')
  end

  def filter_killed(log_line, players_arr)
    player_killed = log_line[word_index(log_line, 'killed') + 1..word_index(log_line, 'by') - 1].join(' ')
    players_arr << player_killed unless players_arr.include? player_killed
  end

  def word_index(log_line, word)
    log_line.index word
  end
end
