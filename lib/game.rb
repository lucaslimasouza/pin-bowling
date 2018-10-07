require 'frame'
class Game
  attr_reader :player, :frames

  def initialize(player:, frame_klass: 'Frame')
    @player = player
    @frames = []
    @frame_klass = frame_klass
  end

  def play(pitch)
    frame = frame_klass.new(id: frame_id)
    frame.add_pitch pitch
    frames.push frame
  end

  private

  def frame_klass
    @frame_klass.constantize
  end

  def frame_id
    size = frames.size
    return 1 if size == 0
    size + 1
  end
end
