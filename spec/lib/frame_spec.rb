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
  end
end
