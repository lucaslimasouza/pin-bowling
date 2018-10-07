require 'spec_helper'
require 'game'
require 'pitch'

RSpec.describe Game do
  subject { build(:game)}

  describe '#player' do
    it 'has the name of player' do
      expect(subject.player).to eq 'User Name'
    end
  end

  describe '#play' do
    it "adds an new Frame" do
      pitch = build(:pitch)
      subject.play pitch

      expect(subject.frames.size).to eq 1
      expect(subject.frames.first.id).to eq 1
    end

    it "adds a Pitch in new Frame" do
      pitch = build(:pitch)
      subject.play pitch
      added_pitch = subject.frames.first.pitches.first

      expect(added_pitch).to eq pitch
    end
  end
end
