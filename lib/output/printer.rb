class Printer
  def initialize(games:)
    @games = games
  end

  def print
    frames_id
    games.each do |game|
      player game
      pinfalls game
      score game.frames
    end
  end

  private

  attr_reader :games

  def frames_id
    row = 'Frames    |'
    10.times { |i| row += "    #{i + 1}    |" }
    puts row
  end

  def player(game)
    puts game.player + '      |'
  end

  def pinfalls(game)
    frames = game.frames
    row = 'Pinfalls  |'
    frames.each { |frame| row += "  #{frame.print}  |" }
    last_frame = frames.last
    row += game.print_bonus if last_frame.strike? || last_frame.spare?
    puts row
  end

  def score(frames)
    row = 'Score     |'
    frames.each { |frame| row += "   #{frame.score}    |" }
    puts row
  end
end
