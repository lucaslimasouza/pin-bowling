class Frame
  TOTAL_PITCHES_TO_STRKE = 1
  TOTAL_PITCHES_TO_SPARE = 2
  LAST_ID = 10

  attr_reader :pitches, :score, :id, :score
  attr_accessor :previous_frame

  def initialize(id:)
    @id = id
    @pitches = []
  end

  def add_pitch(pitch)
    pitches.push pitch
    update_score
  end

  def strike?
    pitches.size == TOTAL_PITCHES_TO_STRKE and pitches.first.did_strike?
  end

  def spare?
    total_pins_knocked_down == 10 and pitches.size == TOTAL_PITCHES_TO_SPARE
  end

  def closed?
     has_two_pitches? && has_score?
  end

  def last?
    @id == LAST_ID
  end

  def score_with_plus(bonus)
    if has_previous_frame?
      @score = total_pins_knocked_down + bonus + previous_frame.score
      return
    end
    @score = total_pins_knocked_down + bonus
  end

  def print
    return " |  #{pitches.first.print}" if strike?
    return "#{pitches.first.print} | /" if spare?
    pitches.first.print + " | " + pitches.last.print
  end

  private

  def update_score
    need_update = has_two_pitches? && !has_score? && !strike? && !spare?

    if need_update && has_previous_frame?
      @score = previous_frame.score + total_pins_knocked_down
      return
    end

    if need_update
      @score = total_pins_knocked_down
    end
  end

  def has_score?
    !@score.nil?
  end

  def has_two_pitches?
    pitches.size == 2
  end

  def total_pins_knocked_down
    pitches.sum(&:pins_knocked_down)
  end

  def has_previous_frame?
    !previous_frame.nil?
  end
end
