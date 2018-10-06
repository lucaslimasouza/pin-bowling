require 'spec_helper'
require 'pitch'

RSpec.describe Pitch do
  subject { build(:pitch)}

  describe '#pins_knocked_down' do
    it 'has pins knocked down value' do
      expect(subject.pins_knocked_down).to eq 4
    end
  end

end
