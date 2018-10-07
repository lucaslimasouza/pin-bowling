require 'frame'
class Game
  attr_reader :player, :frames, :score

  def initialize(player:, frame_klass: 'Frame')
    @player = player
    @frame_klass = frame_klass
    @frames = []
    @score = 0
    @queue_frame_bonus = []
    @last_pitches = []
  end

  def play(pitch)
    frame = current_frame

    remove_from_queue_frame pitch

    add_last_pitch pitch

    frame.add_pitch pitch
    frames.push frame unless frames.include? frame

    add_to_queue_frame frame
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
    @score = frames.last.score if frames.last.score
  end

  def add_to_queue_frame(frame)
    @queue_frame_bonus.push frame if frame.strike? || frame.spare?
  end

  def add_last_pitch(pitch)
    @last_pitches.push pitch unless @queue_frame_bonus.empty?
  end

  def remove_from_queue_frame(pitch)
    return if @queue_frame_bonus.size == 0
    total_last_pitches = @last_pitches + [pitch]

    if can_run_strike_rule(total_last_pitches)
      set_bonus_to_frame(total_last_pitches)
      return
    end

    if can_run_spare_rule(total_last_pitches)
      set_bonus_to_frame total_last_pitches
    end

  end

  def can_run_strike_rule(total_last_pitches)
    @queue_frame_bonus.first.strike? && total_last_pitches.size == 2
  end

  def can_run_spare_rule(total_last_pitches)
    @queue_frame_bonus.first.spare? && total_last_pitches.size == 1
  end

  def set_bonus_to_frame(total_last_pitches)
    bonus = total_last_pitches.sum(&:pins_knocked_down)
    frame_with_bonus = frames[frames.index(@queue_frame_bonus.first)]
    frame_with_bonus.score_with_plus bonus
    @queue_frame_bonus.shift
    @last_pitches.pop
  end

  def current_frame
    last_frame = frames.last
    return frame_klass.new(id: frame_id) if last_frame.nil?

    is_last_frame_closed = last_frame.strike? || last_frame.spare? || last_frame.closed?

    if is_last_frame_closed
      new_frame = frame_klass.new(id: frame_id)
      new_frame.previous_frame = last_frame
      return new_frame
    end

    last_frame
  end
end
