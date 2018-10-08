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
    row = "Frames\t|"
    10.times { |i| row += "\t#{i + 1}\t|" }
    puts row
  end

  def player(game)
    puts game.player + "\t|"
  end

  def pinfalls(game)
    frames = game.frames
    row = 'Pinfalls|'
    frames.each { |frame| row += "\t#{frame.print}\t|" }
    last_frame = frames.last
    row += game.print_bonus if last_frame.strike? || last_frame.spare?
    puts row
  end

  def score(frames)
    row = "Score\t|"
    frames.each { |frame| row += "\t#{frame.score}\t|" }
    puts row
  end
end
