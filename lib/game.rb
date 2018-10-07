require_relative 'managers/frames_manager'
require_relative 'managers/bonus_manager'

class Game

  include FramesManager
  include BonusManager

  attr_reader :player, :frames, :score

  def initialize(player:)
    @player = player
    @frames = []
    @score = 0
    @queue_frame_bonus = []
    @last_pitches = []
  end

  def play(pitch)
    frame = current_frame frames

    remove_from_queue(queue_frame_bonus, pitch)
    update_last_pitches pitch
    frame.add_pitch pitch
    update_frames frame
    add_to_queue(queue_frame_bonus, frame)
    update_score
  end

  private

  attr_reader :queue_frame_bonus, :last_pitches

  def update_score
    @score = frames.last.score if frames.last.score
  end

  def update_last_pitches(pitch)
    add_current_pitch(last_pitches, pitch) unless queue_frame_bonus.empty?
  end

  def update_frames(frame)
    frames.push frame unless frames.include? frame
  end
end
