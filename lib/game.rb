require 'frame'
class Game
  attr_reader :player, :frames, :score

  def initialize(player:, frame_klass: 'Frame')
    @player = player
    @frame_klass = frame_klass
    @frames = []
    @score = 0
  end

  def play(pitch)
    frame = current_frame
    frame.add_pitch pitch
    frames.push frame
    update_score
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

  def update_score
    @score += frames.last.score if frames.last.score
  end

  def current_frame
    last_frame = frames.last
    return frame_klass.new(id: frame_id) if last_frame.nil?

    is_last_frame_closed = last_frame.strike? || last_frame.spare? || last_frame.closed?

    return frame_klass.new(id: frame_id) if is_last_frame_closed

    last_frame
  end
end
