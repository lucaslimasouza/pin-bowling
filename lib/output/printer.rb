class Printer
  def initialize(games:)
    @games = games
  end

  def print
    frames_id
    games.each do |game|
      player game
      pinfalls game.frames
      score game.frames
    end
  end

  private
  attr_reader :games

  def frames_id
    row = "Frames    |"
    10.times { |i| row += "    #{i + 1}    |" }
    puts row
  end

  def player(game)
    puts game.player + "      |"
  end

  def pinfalls(frames)
    row = "Pinfalls  |"
    frames.each { |frame| row+= "  #{frame.print}  |"}
    puts row
  end

  def score(frames)
    row = "Score     |"
    frames.each { |frame| row+= "   #{frame.score}    |"}
    puts row
  end
end
