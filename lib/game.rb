require_relative 'managers/frames_manager'
require_relative 'managers/bonus_manager'

class Game
  include FramesManager

  attr_reader :player, :frames, :score

  def initialize(player:, bonus_manager: BonusManager.new)
    @player = player
    @frames = []
    @score = 0
    @bonus = bonus_manager
  end

  def play(pitch)
    frame = current_frame frames

    bonus.check_bonus pitch
    bonus.update_pitches pitch
    add_pitch_to_frame(frame, pitch)
    bonus.add_to_queue frame
    update_frames frame
    update_score
  end

  def print_bonus
    bonus.print
  end

  def ends?
    return false if frames.empty?

    frames.last.last? && score && bonus.empty?
  end

  private

  attr_reader :bonus

  def update_score
    @score = frames.last.score if frames.last.score
  end

  def update_frames(frame)
    unless frames.include? frame
      frames.push frame
      bonus.add_frame frame
    end
  end
end
