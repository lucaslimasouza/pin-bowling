require 'spec_helper'
require 'game'

RSpec.describe Game do
  subject { build(:game)}

  describe '#player' do
    it 'has the name of player' do
      expect(subject.player).to eq 'User Name'
    end
  end
end
