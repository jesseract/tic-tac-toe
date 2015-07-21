require './board.rb'

class ComputerPlayer

  def choose_square(board, game)
    if board.total_moves == 0
      return 5
    end

    #pick a good move if there are any good moves, otherwise just pick a move
    computer_is_x = (game.first_player == self)

    rated_choices = rate_choices(board, computer_is_x)
    rated_choices.each do |choice, is_good|
      if is_good
        return choice
      end
    end
    return rated_choices.keys[0]
  end

  def rate_choices(board, computer_is_x)
    #returns a hash of moves and whether they're good or bad. Keys are fixnums,
    # values are boolean
    # look at the numbers 0-8 and ask the board 'can I play there' return a hash
    rated_choices = {}
    for choice in 1..9
      if board.can_play_at?(choice)
        rated_choices[choice] = good_board?(board.board_with_move(choice), computer_is_x)
      end
    end
    return rated_choices
  end

  def good_board?(board, computer_is_x)
    #decide whether a board is good or bad for the computer_player
    if board.game_over?
      #If we have won or tied, that is good. If we have lost, that's bad
      result = board.result
      if result == :draw
        return true
      elsif result == :X
        return computer_is_x
      else
        return !computer_is_x
      end
    else
      # if game is not over, look at all the moves we could make to see if we or
      # the other player is forced
      rated_choices = rate_choices(board, computer_is_x)
      if board.is_x_turn? == computer_is_x
        #if it's computer's turn, the board is good if I have any good choices, otherwise we are forced which is bad
        return rated_choices.values.include?(true)
      else
        #opponent's turn, the board is bad if any choices are bad for computer_player, otherwise they are forced which is good
        return !rated_choices.values.include?(false)
      end
    end

  end

end
