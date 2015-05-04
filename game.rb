require "./human_player.rb"
require "./computer_player.rb"
require "./board.rb"

class Game
  attr_reader :human_player, :computer_player, :x_moves, :o_moves, :first_player

  def initialize(human_player, computer_player)
    @human_player = human_player
    @computer_player = computer_player
    @board = Board.new
    @x_moves = []
    @o_moves = []
  end

  def welcome
    puts "Welcome, players!\nIt's time to play Tic Tac Toe.\n"
  end

  def play
    self.welcome

    @first_player = self.choose_player
    if @first_player == @human_player
      @second_player = @computer_player
    else
      @second_player = @human_player
    end

    until @board.game_over?
      @board.display_board
      self.take_turn
    end
    @board.display_board

    result = @board.result
    if result == :draw
      puts "It's a draw!"
      puts @x_moves
    else
      puts "Congratulations, #{result}! A winner is you!"
      puts @x_moves
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
    while true
      choice = current_player.choose_square(@board, self)
      board = @board.board_with_move(choice)
      if board == nil
        puts "That's not a legal move! Choose again!"
      else
        if @board.is_x_turn?
          @x_moves << choice
        else
          @o_moves << choice
        end
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
