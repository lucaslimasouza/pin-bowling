require 'spec_helper'
require 'frame'
require 'pitch'

RSpec.describe Frame do
  subject { build(:frame)}

  describe '#add_pitch' do
    it 'add new pitch struct' do
      subject.add_pitch build(:pitch)
      pitches = subject.pitches

      expect(pitches.size).to eq 1
      expect(pitches.first).to be_an Pitch
    end
  end

  describe '#strike?' do
    it 'is when first Pitch has 10 pins knocked down' do
      subject.add_pitch build(:pitch_with_strike)

      expect(subject.strike?).to be_truthy
    end
  end

  describe '#spare?' do
    it 'is when two Pitches sum 10 pins knocked down' do
      subject.add_pitch build(:pitch)
      subject.add_pitch build(:pitch_to_spare)

      expect(subject.spare?).to be_truthy
    end
  end

  describe '#closed?' do
    it 'is when has two Pitches' do
      2.times { subject.add_pitch build(:pitch) }

      expect(subject.closed?). to be_truthy
    end

    it 'is when has score' do
      2.times { subject.add_pitch build(:pitch) }

      expect(subject.closed?). to be_truthy
      expect(subject.score).to eq 8
    end
  end

  describe '#last?' do
    it 'is when has id equal 10' do
      frame = build(:last_frame)

      expect(frame.last?).to be_truthy
    end
  end

  describe '#previous_frame' do
    it 'return a Frame with previous id' do
      first_frame = build(:frame)
      second_frame = build(:frame_two)
      second_frame.previous_frame = first_frame
      previous_frame = second_frame.previous_frame

      expect(previous_frame).to eq first_frame
      expect(previous_frame.id).to eq first_frame.id
    end
  end

  describe '#score_with_plus' do
    it 'set the score with bonus' do
      subject.add_pitch build(:pitch_with_strike)
      subject.score_with_plus(6)

      expect(subject.score).to eq 16
    end
  end
end
