class Game
  attr_reader :fragment
  attr_reader :dictionary

  def initialize(dictionary, *players)
    @players = players
    @fragment = ''
    @dictionary = dictionary
    @current_player = @players.first
  end

  def play_round
    until round_over?
      next_player!
      take_turn(@current_player)
    end
    conclude_round
  end

  def play_game
    until game_over?
      play_round
      display_status
    end
    conclude_game
  end

  def display_status
    puts
    @players.each do |player|
      puts "#{player.name}: #{player.loss_record}"
    end
    puts
  end

  def conclude_round
    puts "ROUND OVER!\n#{@current_player.name} lost"
    @current_player.increment_letter
    @fragment = ""
    player_delete
  end

  def conclude_game
    puts "GAME OVER!\n#{@current_player.name} won"
  end

  def round_over?
    @dictionary.include?(@fragment)
  end

  def player_delete
    if @current_player.loss_record == 'GHOST'
      @players.delete(@current_player)
      @current_player = @players.first
    end
  end

  def next_player!
    if @players.index(@current_player) == @players.length - 1
      @current_player = @players.first
    else
      @current_player = @players[@players.index(@current_player) + 1]
    end
  end

  def game_over?
    @players.length == 1
  end

  def take_turn(player)
    while true
      puts "The fragment is #{@fragment}" unless @fragment.empty?
      current_guess = player.guess
      if valid_play?(@fragment + current_guess)
        @fragment << current_guess
        break
      else
        player.alert_invalid_guess
      end
    end
  end

  def valid_play?(string)
    @dictionary.any? do |word|
      string == word[0...string.length] if word.length >= string.length
    end
  end
end

class Player
  attr_reader :name, :loss_record

  def initialize(name)
    @name = name
    @loss_record = ''
  end

  def guess
    puts "Type a letter #{@name}"
    gets.chomp
  end

  def alert_invalid_guess
    puts "Invalid guess. Try again."
  end

  def increment_letter
    letters = {0 => "G", 1 => "H", 2 => "O", 3 => "S", 4 => "T"}
    @loss_record << letters[@loss_record.length]
  end
end

player1 = Player.new("Amanda")
player2 = Player.new("Luke")
player3 = Player.new("Tim")
game = Game.new(["th","cat","comb"], player1, player2, player3)
game.play_game
