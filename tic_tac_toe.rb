require './game.rb'
require './human_player.rb'
require './computer_player.rb'

if __FILE__ == $0
  human_goes_first = rand(1..2) == 1
  game = Game.new(HumanPlayer.new, ComputerPlayer.new, human_goes_first)
  game.play
end
