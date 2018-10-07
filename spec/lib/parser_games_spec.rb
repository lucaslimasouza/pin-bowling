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

    end
  end


end
