Pitch = Struct.new(:pins_knocked_down)
class Pitch
  PINS_KNOCKED_DOWN_TO_STRIKE = 10

  attr_reader :pins_knocked_down

  def initialize(pins_knocked_down:)
    @pins_knocked_down = pins_knocked_down
  end

  def did_strike?
    pins_knocked_down == PINS_KNOCKED_DOWN_TO_STRIKE
  end

end
