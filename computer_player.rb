
class ComputerPlayer

  def choose_square(board, game)
    if board.can_play_at?(5)
      pick = 5
    elsif user_close_to_winning?(board, game)
      @spot
    elsif board.can_play_at?(1) || board.can_play_at?(3) || board.can_play_at?(7) || board.can_play_at?(9)
  else
      pick = rand(1..9)
      until board.can_play_at?(pick)
        pick = rand(1..9)
      end
    end
    puts "Computer chose #{pick}!"
    return pick
  end

  def user_close_to_winning?(board, game)
    close = false
    if game.first_player == game.human_player
      moves = game.x_moves
    else
      moves = game.o_moves
    end
    board.win_case.each do |line|
      @m_array = []
      count = 0
      moves.each do |m|
        if line.include?(m)
          count += 1
          @m_array << m
        end
        if count == 2
          close = true
          @line = line
        end
      end
    end
    find_spot(@line, @m_array[0], @m_array[1]) if close
    close
  end

  def find_spot(line, m1, m2)
    @spot = line.reject{ |spot| spot = m1 || spot = m2}
  end


end
