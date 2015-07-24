require "./human_player.rb"
require "./computer_player.rb"
require "./board.rb"

class Game
  attr_reader :human_player, :computer_player, :first_player

  def initialize(human_player, computer_player, human_goes_first)
    @human_player = human_player
    @computer_player = computer_player

    if human_goes_first
      @first_player = @human_player
      @second_player = @computer_player
    else
      @first_player = @computer_player
      @second_player = @human_player
    end

    @board = Board.new
  end

  def welcome
    puts "Welcome, players!\nIt's time to play Tic Tac Toe.\n"

    if @first_player == @human_player
      puts "Human player goes first!"
    else
      puts "Computer goes first!"
    end
  end

  def play
    self.welcome

    until @board.game_over?
      @board.display_board
      self.take_turn
    end
    @board.display_board

    result = @board.result
    if result == :draw
      puts "It's a draw!"
    else
      if current_player == @computer_player
        winner = "Human"
      else
        winner = "Computer"
      end

      puts "Congratulations, #{result}! #{winner} wins!"
    end
  end

  def take_turn
    while true
      choice = current_player.choose_square(@board)
      board = @board.board_with_move(choice)
      if board == nil
        puts "That's not a legal move! Choose again!"
      else
        @board = board
        break
      end
    end
  end

  def current_player
    if @board.is_x_turn?
      return @first_player
    else
      return @second_player
    end
  end

end
