class BonusManager
  attr_reader :frames

  def initialize
    @queue_of_frames = []
    @last_pitches = []
    @frames = []
  end

  def check_bonus(pitch)
    return if queue_of_frames.empty?

    @current_pitch = pitch

    if can_run_rules
      frame = find_frame
      set_bonus_to_frame frame
      clean_data frame
    end
  end

  def update_pitches(pitch)
    last_pitches.push pitch unless queue_of_frames.empty?
  end

  def add_to_queue(frame)
    queue_of_frames.push frame if (frame.strike? || frame.spare?) && !queue_of_frames.include?(frame)
  end

  def empty?
    queue_of_frames.empty?
  end

  def add_frame(frame)
    frames.push frame
  end

  def print
    row = ''
    last_pitches.each { |pitch| row += "#{pitch.print}\t|" }
    row
  end

  private

  attr_reader :last_pitches, :queue_of_frames, :current_pitch

  def pitches_to_bonus
    last_pitches + [current_pitch]
  end

  def can_run_rules
    can_run_strike_rule || can_run_spare_rule
  end

  def can_run_strike_rule
    queue_of_frames.first.strike? && pitches_to_bonus.size == 2
  end

  def can_run_spare_rule
    queue_of_frames.first.spare? && pitches_to_bonus.size == 1
  end

  def set_bonus_to_frame(frame)
    frame.score_with_plus bonus
  end

  def find_frame
    frame = queue_of_frames.first
    frames.select { |f| f.id == frame.id }.first
  end

  def bonus
    pitches_to_bonus.sum(&:pins_knocked_down)
  end

  def clean_data(frame)
    total_last_pitches = pitches_to_bonus
    queue_of_frames.shift
    last_pitches.pop
    last_pitches.concat total_last_pitches if frame.last?
  end
end
