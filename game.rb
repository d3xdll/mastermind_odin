class Game
  attr_accessor :guess
  def initialize
    puts "Welcome to our game\n Make your decisons"
    puts "Do you want to guess: Y/N?"
    @new_player = Player.new(gets.chomp == 'Y')
    @new_player.guess == true ? @new_code=Code.new("Random") : @new_code=Code.new("Input")
    gameplay
  end

  def gameplay
    loop do
      new_array = Game.ask_guess
      check_guess(new_array, @new_code.game_code)
      if check_array?(@answer)
        print "You've won"
        break
      end
    end
    print "Sorry about your loss"
  end

  def self.ask_guess
    @guess = []
    puts "Your guess is:"
    4.times do
      @guess.push(gets.chomp.to_i)
    end
    @guess
  end

  def check_guess(array, player_code)
    @answer = []
    array.each_with_index do |n, index|
      if n == player_code[index]
        @answer.push("cow")
      elsif player_code.any?(n)
        @answer.push("bull")
      else
        if n>player_code[index]
          @answer.push("higher")
        elsif n<player_code[index]
          @answer.push("lower")
        end
      end
    end
    p @answer
    @answer
  end

  def check_array?(array)
    array.all?("cow")
  end

end

class Player
  attr_accessor :guess, :name

  def initialize(guess)
    puts "Enter your name"
    @name = gets.chomp
    puts "Hello, #{@name}"
    @guess = guess
  end
end

class Opponent
  def initialize
    @name=gets.chomp
    puts "Hello, #{@name}"
  end
end

class Code
  @@valid_code = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  attr_accessor :game_code

  def initialize(method)
    case method
    when "Input"
      @game_code = input_code
    when "Random"
      @game_code = random_code
    end
  end

  def input_code
    puts "Enter 4 digits for your code"
    @code = []
    4.times do
      @code.push(gets.chomp.to_i)
    end
    @code
  end

  def random_code
    @@valid_code.sample(4)
  end
end

Game.new