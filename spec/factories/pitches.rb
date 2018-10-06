FactoryBot.define do
  factory :pitch, class: 'Pitch' do
    initialize_with { new(4) }
  end
end
