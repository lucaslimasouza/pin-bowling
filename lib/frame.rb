class Frame
  PINS_KNOCKED_DOWN_TO_STRIKE = 10

  attr_reader :pitches

  def initialize(id:)
    @id = id
    @pitches = []
  end

  def add_pitch(pitch)
    pitches.push pitch
  end

  def strike?
    pitches.size == 1 and pitches.first.pins_knocked_down == PINS_KNOCKED_DOWN_TO_STRIKE
  end

end
