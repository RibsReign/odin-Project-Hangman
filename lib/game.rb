# frozen_string_literal: true

require_relative 'display'
require_relative 'wordloader'
require_relative 'player'
require_relative 'serialize'

require 'yaml'

# Game class is dealing with the main runtime and delegating tasks to classes
class Game
  def initialize
    @display = Display.new
    @word_loader = WordLoader.new
    @player = Player.new
    @serialize = Serialize.new
    @secret_word = ''
    @current_guess = ''
  end

  def save_game?(input)
    return false unless input == 'save'

    game_state = {
      guesses_left: @player.guesses,
      current_guess: @current_guess,
      secret_word: @secret_word
    }

    @serialize.save_game(game_state)
    @display.game_saved
    true
  end

  def load_game?(input)
    return false unless input == 'load'

    game_state = @serialize.load_game
    if game_state.nil?
      @display.save_not_found
    else
      @player.guesses = game_state[:guesses_left]
      @current_guess = game_state[:current_guess]
      @secret_word = game_state[:secret_word]
    end
    true
  end

  def start
    secret_words = @word_loader.load_secret_words
    loop do
      @secret_word = secret_words.sample.chars

      @player.reset_guesses
      @current_guess = play_round
      if @current_guess == @secret_word
        @display.win_message(@secret_word)
      else
        @display.lose_message(@secret_word)
      end
      break unless @display.play_again?
    end
  end

  def play_round
    @current_guess = @word_loader.get_new_word(@secret_word)
    until @current_guess == @secret_word || @player.guesses <= 0
      @display.show_current_status(@current_guess, @player.guesses)
      guess = gets.chomp
      next if @player.invalid_guess?(guess) || save_game?(guess) || load_game?(guess)

      if @player.valid_letter?(guess, @secret_word)
        @player.handler_correct_letter(guess, @secret_word, @current_guess)
      else
        @player.handler_incorrect_letter(guess)
      end
    end
  end
end
