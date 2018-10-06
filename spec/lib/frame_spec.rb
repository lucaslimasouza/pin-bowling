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

end
