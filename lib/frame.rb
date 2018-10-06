class Frame
  TOTAL_PITCHES_TO_STRKE = 1
  TOTAL_PITCHES_TO_SPARE = 2
  LAST_ID = 10

  attr_reader :pitches, :score, :id
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
    pitches.sum(&:pins_knocked_down) == 10 and pitches.size == TOTAL_PITCHES_TO_SPARE
  end

  def closed?
     has_two_pitches? && has_score?
  end

  def last?
    @id = LAST_ID
  end

  private

  def update_score
    need_update = has_two_pitches? && !has_score? && !strike? && !spare?
    @score = pitches.sum(&:pins_knocked_down) if need_update
  end

  def has_score?
    !@score.nil?
  end

  def has_two_pitches?
    pitches.size == 2
  end
end
