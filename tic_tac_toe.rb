require './board.rb'
require './human_player.rb'
require './computer_player.rb'

if __FILE__ == $0
  game= Board.new(HumanPlayer.new, ComputerPlayer.new)
  game.play
end
