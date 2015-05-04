class Board
  attr_reader :win_case

  def initialize(squares = [nil, nil, nil, nil, nil, nil, nil, nil, nil])
    @squares = squares
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

  def total_moves
    count = 0
    @squares.each do |m|
      if m != nil
        count = count + 1
      end
    end
    return count
  end

  def is_x_turn?
    return total_moves.even?
  end

  def game_over?
    return result != nil
  end

  #return :X if x won, :O if o won, :draw if it's a draw and nil if the game isn't over
  def result
    @win_case = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]

    if is_x_turn?
      letter = :O
    else
      letter = :X
    end

    win_case.each do |w|
      count = 0
      w.each do |l|
        if @squares[l] == letter
          count = count + 1
        end
      end

      if count == 3
        return letter
      end
    end

    if total_moves != @squares.count
      return nil
    else
      return :draw
    end
  end

  def can_play_at?(choice)
    @squares[choice - 1] == nil
  end

  def board_with_move(choice)
    if !can_play_at?(choice)
      return nil
    end

    if is_x_turn?
      letter = :X
    else
      letter = :O
    end

    squares = @squares.dup
    squares[choice - 1] = letter

    return Board.new(squares)
  end
end
