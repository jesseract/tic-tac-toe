require './board.rb'

class ComputerPlayer

  def choose_square(board, game)
    #if you can win, win
    square = square_that_lets_player_win(board, game, game.computer_player)
    puts "can win? #{square}"
    if square != nil
      return square
    end

    #if you can prevent yourself from losing, do that
    square = square_that_lets_player_win(board, game, game.human_player)
    puts "can lose? #{square}"
    if square != nil
      return square
    end

    #if human_player can fork, stop them
    square = square_that_lets_player_fork(board, game, game.human_player)
    puts "can prevent fork? #{square}"
    if square != nil
      return square
    end

    #play center if not occupied
    if board.can_play_at?(5)
      return 5
    end

    #play corner if not occupied
    square = open_corner_square(board)
    puts "can play corner? #{square}"
    if square != nil
      return square
    end

    #play in a random open space
    return random_open_square(board)
  end

  def square_that_lets_player_win(board, game, player)
    moves = game.moves_for_player(player)

    board.win_case.each do |line|
      line = line.dup
      moves.each do |m|
        line.delete(m)
      end

      if line.length == 1 && board.can_play_at?(line[0])
        return line[0]
      end
    end

    return nil
  end

  def square_that_lets_player_fork(board, game, player)
    moves = game.moves_for_player(player)
    #prevent a fork, which is when a player has two win cases, each with one occupied square, that intersect at an unoccupied square

    #take all win cases and narrow them down to those that have two blanks and one mark by the player
    lines = board.win_case.select do |line|
      marks = 0
      blanks = 0
      for square in line
        if moves.include?(square)
          marks = marks + 1
        elsif board.can_play_at?(square)
          blanks = blanks + 1
        end
      end
      marks == 1 && blanks == 2
    end

    #consider every combination of two win cases
    #outer loop looks at the entire contents of lines excluding the last one
    for first_index in 0...(lines.length - 1)
      first_line = lines[first_index]
      #inner loop takes every line after the first and considers it against each other line
      for second_index in (first_index + 1)...(lines.length)
        second_line = lines[second_index]
        intersection = first_line & second_line
        #sees if they intersect, looks to see if the intersection is blank, if blank, returns that square
        if intersection.length == 1 && board.can_play_at?(intersection[0])
          return intersection[0]
        end
      end
    end
    #if there is no fork, return nil
    return nil
  end

  def open_corner_square(board)
    corners = [1, 3, 7, 9]
    corners.each do |square|
      if board.can_play_at?(square)
        return square
      end
    end
    return nil
  end

  def random_open_square(board)
    square = rand(1..9)
    until board.can_play_at?(square)
      #randomly chooses a number, asks if space is open and either picks that open space or chooses another randomly
      square = rand(1..9)
    end
    return square
  end

    # if board.total_moves == 0
    #   return 5
    # end

    # #pick a good move if there are any good moves, otherwise just pick a move
    # computer_is_x = (game.first_player == self)
    #
    # rated_choices = rate_choices(board, computer_is_x)
    # rated_choices.each do |choice, is_good|
    #   if is_good
    #     return choice
    #   end
    # end
    # return rated_choices.keys[0]


  # def rate_choices(board, computer_is_x)
  #   #returns a hash of moves and whether they're good or bad. Keys are fixnums,
  #   # values are boolean
  #   # look at the numbers 0-8 and ask the board 'can I play there' return a hash
  #   rated_choices = {}
  #   for choice in 1..9
  #     if board.can_play_at?(choice)
  #       rated_choices[choice] = good_board?(board.board_with_move(choice), computer_is_x)
  #     end
  #   end
  #   return rated_choices
  # end
  #
  # def good_board?(board, computer_is_x)
  #   #decide whether a board is good or bad for the computer_player
  #   if board.game_over?
  #     #If we have won or tied, that is good. If we have lost, that's bad
  #     result = board.result
  #     if result == :draw
  #       return true
  #     elsif result == :X
  #       return computer_is_x
  #     else
  #       return !computer_is_x
  #     end
  #   else
  #     # if game is not over, look at all the moves we could make to see if we or
  #     # the other player is forced
  #     rated_choices = rate_choices(board, computer_is_x)
  #     if board.is_x_turn? == computer_is_x
  #       #if it's computer's turn, the board is good if I have any good choices, otherwise we are forced which is bad
  #       return rated_choices.values.include?(true)
  #     else
  #       #opponent's turn, the board is bad if any choices are bad for computer_player, otherwise they are forced which is good
  #       return !rated_choices.values.include?(false)
  #     end
  #   end
  #
  # end
end
