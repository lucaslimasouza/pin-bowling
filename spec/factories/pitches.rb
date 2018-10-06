FactoryBot.define do
  factory :pitch, class: 'Pitch' do
    initialize_with { new(pins_knocked_down: 4) }
  end

  factory :pitch_with_strike, class: 'Pitch' do
    initialize_with { new(pins_knocked_down: 10) }
  end

  factory :pitch_to_spare, class: 'Pitch' do
    initialize_with { new(pins_knocked_down: 6) }
  end
end
