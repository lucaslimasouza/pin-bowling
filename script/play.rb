#!/usr/bin/env ruby

Dir['./lib/*.rb'].each { |file| require file }
Dir['./lib/output/*.rb'].each { |file| require file }

file_path = ARGV[0]

if file_path
  parser_games = ParserGames.new(file_path: file_path)
  games = parser_games.parse
  pr = Printer.new(games: games)
  pr.print
  exit
end

puts 'Please input the dir of file. Ex: data/bowling-game.txt'
