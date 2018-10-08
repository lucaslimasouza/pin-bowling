FactoryBot.define do
  factory :parser_games, class: 'ParserGames' do
    initialize_with { new(file_path: 'spec/data/bowling-game.txt') }
  end
end
