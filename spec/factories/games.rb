FactoryBot.define do
  factory :game, class: 'Game' do
    initialize_with { new(player: 'User Name') }
  end
end
