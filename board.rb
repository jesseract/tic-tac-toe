require "./human_player.rb"
require "./computer_player.rb"

class Board

  def initialize(human_player, computer_player)
    @human_player = human_player
    @computer_player = computer_player
  end

  # def display_header
  #   puts "    1   2   3"
  # end
  #
  # def display_footer
  #   puts "    ---------"
  # end

  def display_board
    puts "   |   |   "
    puts " " + (1..3).map{|i| @board || i}.join(" | ")
    puts "---|---|---"
    puts " " + (4..6).map{|i| @board || i}.join(" | ")
    puts "---|---|---"
    puts " " + (7..9).map{|i| @board || i}.join(" | ")
    puts "   |   |   "
  end

  def welcome
    puts "Welcome, players!\nIt's time to play Tic Tac Toe.\n"
  end

  def play
  self.welcome
  self.display_board
  self.choose_player
  self.choose_square
  until @game_over == true
    self.place_letter
  end
end


  def choose_player
    coin_toss = rand(1..2)
    if coin_toss == 1
      puts "Human player goes first!"
      @human_player
    else
      puts "Computer goes first!"
      @computer_player
    end
  end

  def choose_square
    @human_player.choose_square
    @computer_player.choose_square
  end

  def place_letter

  end

  def declare_winner

  end




end
