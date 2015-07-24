require 'minitest/autorun'
require 'minitest/pride'
require './tic_tac_toe'

class TicTacToeTest < Minitest::Test

  def self.test_order
    :alpha
  end

  def test_00_computer_player_class_exists
    assert ComputerPlayer
  end

  def test_01_human_player_class_exists
    assert HumanPlayer
  end

  def test_03_empty_board_can_display_itself
    board = Board.new
  end

  def empty_board
    %Q{    |   |
  1 | 2 | 3
 ---|---|---
  4 | 5 | 6
 ---|---|---
  7 | 8 | 9
    |   |
}
  end

  def test_04_computer_plays_center_on_blank_board
    board = Board.new
    assert_equal ComputerPlayer.new.choose_square(board), 5
  end

  def test_05_x_can_win
    board = Board.new
    board = board.board_with_move(5)
    board = board.board_with_move(2)
    board = board.board_with_move(1)
    board = board.board_with_move(4)
    board = board.board_with_move(9)
    # board.display_board
    assert_equal :X, board.result
  end

  def test_06_o_can_win
    board = Board.new
    board = board.board_with_move(2)
    board = board.board_with_move(5)
    board = board.board_with_move(4)
    board = board.board_with_move(1)
    board = board.board_with_move(7)
    board = board.board_with_move(9)
    assert_equal :O, board.result
  end

  def test_07_computer_will_prevent_fork
    board = Board.new
    board = board.board_with_move(7)
    board = board.board_with_move(5)
    board = board.board_with_move(2)
    assert_equal 1, ComputerPlayer.new.choose_square(board)
  end

  def test_08_computer_will_play_corner_if_forked_on_edge
    board = Board.new
    board = board.board_with_move(5)
    board = board.board_with_move(1)
    board = board.board_with_move(9)
    assert_equal 3, ComputerPlayer.new.choose_square(board)
  end

  def test_09_computer_will_play_edge_if_forked_on_corner
    board = Board.new
    board = board.board_with_move(1)
    board = board.board_with_move(5)
    board = board.board_with_move(9)
    assert_equal 2, ComputerPlayer.new.choose_square(board)
  end


  def test_10_game_can_be_a_draw
    board = Board.new
    board = board.board_with_move(1)
    board = board.board_with_move(5)
    board = board.board_with_move(2)
    board = board.board_with_move(3)
    board = board.board_with_move(7)
    board = board.board_with_move(4)
    board = board.board_with_move(6)
    board = board.board_with_move(8)
    board = board.board_with_move(9)
    # board.display_board
    assert_equal :draw, board.result
  end

  def test_11_computer_plays_first_open_corner
    board = Board.new
    board = board.board_with_move(5)
    board = board.board_with_move(1)
    assert_equal 3, ComputerPlayer.new.choose_square(board)
  end

  def test_12_computer_player_makes_winning_move
    board = Board.new
    board = board.board_with_move(5)
    board = board.board_with_move(4)
    board = board.board_with_move(1)
    board = board.board_with_move(2)
    assert_equal 9, ComputerPlayer.new.choose_square(board)
  end

  def test_13_computer_player_blocks_losing_move
    board = Board.new
    board = board.board_with_move(5)
    board = board.board_with_move(1)
    board = board.board_with_move(4)
    assert_equal 6, ComputerPlayer.new.choose_square(board)
  end

end
