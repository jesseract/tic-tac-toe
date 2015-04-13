class HumanPlayer

  def get_user_input
    gets.chomp
  end

  def choose_square
    puts "Which square do you choose?"
    number = get_user_input
  end

  def display_board_status
    puts ""
    @board.display  
  end

end
