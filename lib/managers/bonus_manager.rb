module BonusManager
  def add_to_queue(queue, frame)
    queue.push frame if (frame.strike? || frame.spare?) && !queue.include?(frame)
  end

  def add_current_pitch(pitches, pitch)
    pitches.push pitch
  end

  def check_bonus(queue, pitch, last_pitches)
    return if queue.empty?

    total_last_pitches = last_pitches + [pitch]
    if can_run_rules(queue, total_last_pitches)
      frame = find_frame(frames, queue.first)
      set_bonus_to_frame(frame, bonus(total_last_pitches))
      clean_data(queue, last_pitches, total_last_pitches, frame)
    end
  end

  private

  def can_run_rules(queue, total_last_pitches)
    can_run_strike_rule(queue, total_last_pitches) || can_run_spare_rule(queue, total_last_pitches)
  end

  def can_run_strike_rule(queue, total_last_pitches)
    queue.first.strike? && total_last_pitches.size == 2
  end

  def can_run_spare_rule(queue, total_last_pitches)
    queue.first.spare? && total_last_pitches.size == 1
  end

  def set_bonus_to_frame(frame, bonus)
    frame.score_with_plus bonus
  end

  def find_frame(frames, frame)
    frames.select { |f| f.id == frame.id }.first
  end

  def bonus(total_last_pitches)
    total_last_pitches.sum(&:pins_knocked_down)
  end

  def clean_data(queue, last_pitches, total_last_pitches, frame)
    queue.shift
    last_pitches.pop
    last_pitches.concat total_last_pitches if frame.last?
  end
end
