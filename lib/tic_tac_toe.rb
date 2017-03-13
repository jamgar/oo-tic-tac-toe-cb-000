class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(position)
    return position.to_i - 1
  end

  def move(position, player)
    return @board[position] = player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index) ? true : false
  end

  def turn_count()
    @board.count do |position|
      position == "X" || position == "O"
    end
  end

  def current_player()
    token = turn_count() % 2 == 0 ? "X" : "O"
  end

  def turn()
    next_turn = false
    until next_turn == true
      puts "Please enter 1-9:"
      answer = gets.strip
      index = input_to_index(answer)
      if valid_move?(index)
        token = current_player()
        move(index, token)
        display_board()
        next_turn = true
      else
        # Ask for input again
        puts "Opps, invalid entry, try again!"
      end
    end
  end

  def won?()
    winning_combo = []
    WIN_COMBINATIONS.each do |combination|
      if @board[combination[0]] == "X" && @board[combination[1]] == "X" && @board[combination[2]] == "X"
        combination.each do |position|
          winning_combo << position
        end
      end
      if @board[combination[0]] == "O" && @board[combination[1]] == "O" && @board[combination[2]] == "O"
        combination.each do |position|
          winning_combo << position
        end
      end
    end
    unless winning_combo.empty?
      return winning_combo
    end
  end

  def full?()
   !(@board.include?(" ") || @board.include?(""))
  end

  def draw?()
    (!won?() && full?())
  end

  def over?()
    (draw?() || won?())
  end

  def winner()
    combination = won?()
    if !combination.nil?
      return @board[combination[0]]
    end
    combination
  end

  def play()
    while !over?()
      turn()
    end
    if won?()
      puts "Congratulations #{winner()}!"
    else
      puts "Cat's Game!"
    end
  end

end
