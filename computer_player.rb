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

    #check for ways we can be forked
    forking_squares = squares_that_let_player_fork(board, game, game.human_player)
    puts "forking squares: #{forking_squares}"
    if forking_squares.length == 1
      #if human_player can fork, stop them
      puts "can prevent fork: #{square}"
      return forking_squares[0]
    elsif forking_squares.length > 1
      #if we detect two possible forks on edges, play a random open corner
      if (forking_squares & edges).length != 0
        #play corner if not occupied
        square = open_corner_square(board)
        puts "can prevent double fork at corner? #{square}"
        if square != nil
          return square
        end
      end

      #if we detect two possible forks on corners, play a random open edge
      if (forking_squares & corners).length != 0
        #play edge if not occupied
        square = open_edge_square(board)
        puts "can prevent double fork at edge? #{square}"
        if square != nil
          return square
        end
      end
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

  def squares_that_let_player_fork(board, game, player)
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
    forking_squares = []
    for first_index in 0...(lines.length - 1)
      first_line = lines[first_index]
      #inner loop takes every line after the first and considers it against each other line
      for second_index in (first_index + 1)...(lines.length)
        second_line = lines[second_index]
        intersection = first_line & second_line
        #sees if they intersect, looks to see if the intersection is blank, if blank, returns that square
        if intersection.length == 1 && board.can_play_at?(intersection[0])
          forking_squares << intersection[0]
        end
      end
    end

    return forking_squares.uniq
  end

  def open_corner_square(board)
    open_square_among_squares(board, corners)
  end

  def open_edge_square(board)
    open_square_among_squares(board, edges)
  end

  def open_square_among_squares(board, squares)
    squares.each do |square|
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

  def corners
    return [1, 3, 7, 9]
  end

  def edges
    return [2, 4, 6, 8]
  end

end
