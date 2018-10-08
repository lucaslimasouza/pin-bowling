require 'spec_helper'
require 'pitch'

RSpec.describe Pitch do
  subject { build(:pitch) }

  describe '#pins_knocked_down' do
    it 'has pins knocked down value' do
      expect(subject.pins_knocked_down).to eq 4
    end
  end

  describe '#did_strike?' do
    it 'is truthy when 10 pins was knocked down' do
      pitch = build(:pitch_with_strike)
      expect(pitch.did_strike?).to be_truthy
    end
  end
end
