require "./human_player.rb"
require "./computer_player.rb"

class Board

  def initialize(human_player, computer_player)
    @human_player = human_player
    @computer_player = computer_player
    @choices = []
    @squares = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
  end

  def display_board
    puts "   |   |   "
    puts " " + (1..3).map{|i| @squares[i-1] || i}.join(" | ")
    puts "---|---|---"
    puts " " + (4..6).map{|i| @squares[i-1] || i}.join(" | ")
    puts "---|---|---"
    puts " " + (7..9).map{|i| @squares[i-1] || i}.join(" | ")
    puts "   |   |   "
  end

  def welcome
    puts "Welcome, players!\nIt's time to play Tic Tac Toe.\n"
  end

  def play
    self.welcome
    @first_player = self.choose_player
    @current_player = @first_player
    until @game_over == true
      self.display_board
      self.take_turn
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

  def take_turn
    choice = @current_player.choose_square
    if @squares[choice - 1] == nil
      if @current_player == @first_player
        letter = "X"
      else
        letter = "O"
      end
    end
    @squares[choice - 1] = letter

    if @current_player == @human_player
      @current_player = @computer_player
    else
      @current_player = @human_player
    end
  end

  def declare_winner

  end

end
