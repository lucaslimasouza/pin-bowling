FactoryBot.define do
  factory :game, class: 'Game' do
    initialize_with { new(player: 'User Name', bonus_manager: build(:bonus_manager)) }
  end
end
