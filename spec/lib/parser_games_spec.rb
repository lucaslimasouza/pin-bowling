require 'spec_helper'
require 'parser_games'
require 'game'

RSpec.describe ParserGames do
  subject { build(:parser_games)}

  describe '#parse' do
    context 'load all bowling game from txt file' do
      it 'define an array of Games' do
        games = subject.parse

        expect(games).to be_an Array
        expect(games.first).to be_an Game
      end

      it 'define 2 Games' do
        games = subject.parse

        expect(games.length).to eq 2
      end

      it 'define a Frame in the last Game' do
        games = subject.parse

        expect(games.last.frames.length).to eq 1
      end

      it 'define Pitches to each Game' do
        games = subject.parse

        expect(games.first.frames.first.pitches.length).to eq 1
        expect(games.last.frames.first.pitches.length).to eq 2
      end

    end
  end


end
