require 'pitch'
require 'game'
class ParserGames

  def initialize(file_path:)
    @file_path = file_path
    @games = {}
  end

  def parse
    File.readlines(file_path).each do |row|
      values = row.gsub(/\t|\n/, '')
      pitch = create_pitch values
      player = create_player values
      game = find_or_create_game player
    end
    games.values
  end

  private

  attr_reader :file_path, :games

  def create_pitch(values)
    pins = values.split(' ')[1]
    Pitch.new(pins_knocked_down: pins.to_i)
  end

  def create_player(values)
    values.split(' ')[0]
  end

  def find_or_create_game(player)
    games[player] = Game.new(player: player) unless games.key? player
    games[player]
  end
end
