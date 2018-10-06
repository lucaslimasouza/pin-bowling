class Frame

  attr_reader :pitches

  def initialize(id:)
    @id = id
    @pitches = []
  end

  def add_pitch(pitch)
    pitches.push pitch
  end

end
