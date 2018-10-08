require 'frame'

module FramesManager
  def current_frame(frames)
    last_frame = frames.last
    return get_new_frame if last_frame.nil?
    return last_frame if last_frame.last?
    return new_frame_with_previous(last_frame) if is_frame_closed?(last_frame)

    last_frame
  end

  def add_pitch_to_frame(frame, pitch)
    return if frame.last? && (frame.strike? || frame.spare?)

    frame.add_pitch pitch
  end

  private

  def get_new_frame
    Frame.new(id: frame_id)
  end

  def frame_id
    return 1 if frames.empty?

    frames.size + 1
  end

  def is_frame_closed?(frame)
    frame.strike? || frame.spare? || frame.closed?
  end

  def new_frame_with_previous(previous_frame)
    new_frame = get_new_frame
    new_frame.previous_frame = previous_frame
    new_frame
  end
end
