FactoryBot.define do
  factory :frame, class: 'Frame' do
    initialize_with { new(id: 1) }
  end

  factory :last_frame, class: 'Frame' do
    initialize_with { new(id: 10) }
  end
end
