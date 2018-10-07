module BonusManager

  def add_to_queue(queue,frame)
    queue.push frame if frame.strike? || frame.spare?
  end

  def add_current_pitch(pitches, pitch)
    pitches.push pitch
  end

  def remove_from_queue(queue, pitch)
    return if queue.empty?
    total_last_pitches = last_pitches + [pitch]
    can_run_rules = can_run_strike_rule(queue, total_last_pitches) || can_run_spare_rule(queue, total_last_pitches)
    set_bonus_to_frame(queue, total_last_pitches) if can_run_rules
  end

  private

  def can_run_strike_rule(queue, total_last_pitches)
    queue.first.strike? && total_last_pitches.size == 2
  end

  def can_run_spare_rule(queue, total_last_pitches)
    queue.first.spare? && total_last_pitches.size == 1
  end

  def set_bonus_to_frame(queue, total_last_pitches)
    bonus = total_last_pitches.sum(&:pins_knocked_down)
    frame_with_bonus = frames[frames.index(queue.first)]
    frame_with_bonus.score_with_plus bonus
    queue.shift
    last_pitches.pop
  end

end
