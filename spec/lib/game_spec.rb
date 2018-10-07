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

    context 'define score no bonus' do
      context 'one Frame' do
        it "is scored from last Frame" do
          2.times { subject.play build(:pitch) }

          expect(subject.score).to eq 8
        end
      end

      context 'two Frames' do
        it "is scored from last Frame" do
          4.times { subject.play build(:pitch) }

          expect(subject.score).to eq 16
        end
      end
    end

    context 'define score with bonus' do
      context 'strike' do
        it 'is scored from last Frame' do
          subject.play build(:pitch_with_strike)
          2.times { subject.play build(:pitch) }

          expect(subject.score).to eq 26
        end
      end

      context '2 sequential strikes' do
        it 'is scored from last Frame' do
          2.times { subject.play build(:pitch_with_strike) }
          2.times { subject.play build(:pitch) }

          expect(subject.score).to eq 50
        end
      end

      context 'spare' do
        it 'is scored from last Frame' do
          subject.play build(:pitch)
          subject.play build(:pitch_to_spare)

          2.times { subject.play build(:pitch) }

          expect(subject.score).to eq 22
        end
      end

      context 'tenth Frame with strike' do
        it "wait two more Pitches to complete the score of the strike" do
          18.times { subject.play build(:pitch) }
          subject.play build(:pitch_with_strike)
          2.times { subject.play build(:pitch) }

          expect(subject.score).to eq 90
        end
      end

      context 'tenth Frame with spare' do
        it "wait one more Pitch to complete the scored" do
          18.times { subject.play build(:pitch) }
          subject.play build(:pitch)
          subject.play build(:pitch_to_spare)
          subject.play build(:pitch)

          expect(subject.score).to eq 86
        end
      end

      context 'all Frames with strike' do
        it "wait two more Pitch to complete the scored" do
          12.times { subject.play build(:pitch_with_strike) }

          expect(subject.score).to eq 300
        end
      end

    end
  end
end
