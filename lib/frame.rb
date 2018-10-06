class Frame
  TOTAL_PITCHES_TO_STRKE = 1
  TOTAL_PITCHES_TO_SPARE = 2

  attr_reader :pitches

  def initialize(id:)
    @id = id
    @pitches = []
  end

  def add_pitch(pitch)
    pitches.push pitch
  end

  def strike?
    pitches.size == TOTAL_PITCHES_TO_STRKE and pitches.first.did_strike?
  end

  def spare?
    pitches.sum(&:pins_knocked_down) == 10 and pitches.size == TOTAL_PITCHES_TO_SPARE
  end

  def closed?
    pitches.size == 2
  end


end
