require_relative 'pitch'
require_relative 'game'
require_relative 'managers/bonus_manager'

class ParserGames
  def initialize(file_path:)
    @file_path = file_path
    @games = {}
  end

  def parse
    begin
      File.readlines(file_path).each do |row|
        define_game row
      end
    rescue Errno::ENOENT => e
      puts "Error on parse games => #{e}"
    end
    games.values
  end

  private

  attr_reader :file_path, :games

  def define_game(row)
    values = row.gsub(/\t|\n/, '')
    pitch = create_pitch values
    player = create_player values
    game = find_or_create_game player
    return if game.ends?

    game.play pitch
  end

  def create_pitch(values)
    pins = values.split(' ')[1]
    Pitch.new(pins_knocked_down: pins.to_i)
  end

  def create_player(values)
    values.split(' ')[0]
  end

  def bonus_manager
    BonusManager.new
  end

  def find_or_create_game(player)
    unless games.key? player
      games[player] = Game.new(player: player, bonus_manager: bonus_manager)
    end
    games[player]
  end
end
