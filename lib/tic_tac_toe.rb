require 'pry'
class TicTacToe

  @@all = []
  WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  # ternary: [condition that returns true or false] ? [something] : [something else]
  # if condition
    # something
  # else
    # something else
  def play
    turn until over? # do the turn method until over condition/method is met
    won? ? congratulate : draw
    #if the game is over and someone won congratulate them else draw --- which puts the cats game message
  end

  def turn
    puts "Enter the space you'd like to play on:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      # make a move, using the in3dex we just got,
      # and the current_player method to figure out whether it's X or O
      move(index, current_player)
    else
      puts "Invalid move, try again you buffoon it's tic tac toe it's not that hard"
      # this is recursion. Calling a method inside its own definition is allowed.
      # If you use recursion, ensure you have a "base case", a conditional that stops it from repeating
      # Otherwise, you get an infinite loop
      turn
    end
    display_board
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(string)
    string.to_i - 1
  end

  def move(index, token)
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] != " "
  end

  def valid_move?(index)
    !position_taken?(index) && index >= 0 && index <= 8
  end

  def turn_count
    @board.select{|position| position != " "}.size
    # filter out the portion of the array that's blank
    # count how long the filtered array is
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def won?
    # go through each potential win condition
    # check to see if all the spaces that are in that win condition have the same symbol
      # grab the first space in the win condition and make sure it's not empty
      # check to see if the second and third spaces in the win condition are the same as the first
    # return that win condition if the conditions are met
    #WIN_COMBINATIONS.find do |combination|
      # combination looks like [0, 1, 2]
      #combination_matches?(combination)
      WIN_COMBINATIONS.find {|combination| combination_matches?(combination)} #see private method combination_matches? below -- notice how argument passed in is also argument pass for array iterator find
    end
  

  def full?
    turn_count > 8
    #if more than 8 turns the board is full
    #remember that turn_count is a method we have defined 
  end

  def draw?
    # returns true if the board is full and nobody has won
    full? && !won?
    #both methods previously defined 
    #notice the use of not here
  end

  def over?
    draw? || won?
    #not referring to private method here
    #could also use full? here ---actually would produce incorrect result 
    #instructor could not figure out logic behind why full would not work 
    #full checking if all positions are played and won checking if someone has winning combo
    #reason -- within rspec the over? method is specifically expecting to receive the draw? method
    #chaining methods
  end

  def winner
    # if won?
    #   # [0, 4, 8]
    #   winning_combination = won?
    #   # 0
    #   first_index_in_winning_combination = won?.first
    #   # "X"
    #   player_in_winning_combination = @board[first_index_in_winning_combination]
    # end
      # whole code can be written as:
      @board[won?.first] if won?
      #accessing a specific value above 
  end

  # until the game is over
  #   take turns
  # end
  # if the game was won
  #   congratulate the winner
  # else if the game was a draw
  #   tell the players it ended in a draw
  # end

  private

  def congratulate
    puts "Congratulations #{winner}!"
  end

  def draw
    puts "Cat's Game!"
  end

  def combination_matches?(combination)
    position_taken?(combination[0]) && @board[combination[0]] == @board[combination[1]] && @board[combination[0]] == @board[combination[2]]
  end

end

game = TicTacToe.new
board = ["X", "X", " ", "X", " ", " ", " ", "O", "O"]
game.instance_variable_set(:@board, board) #take note of what this does it is setting the @board variable to the board variable above 
#binding.pry
#could chain methods like TicTacToe.new.play