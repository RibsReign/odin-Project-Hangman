# frozen_string_literal: true

require_relative 'display'

# Class that handles getting and handling player inputs
class Player
  attr_accessor :guesses

  def initialize
    @serialize = Serialize.new
    @display = Display.new
    @guesses = 7
  end

  def invalid_guess?(guess)
    return false unless guess.nil? || guess.strip.empty?

    @display.enter_letter_message
    true
  end

  def valid_letter?(guess, secret_word)
    secret_word.include?(guess.downcase[0])
  end

  def handler_correct_letter(guess, secret_word, current_guess)
    secret_word.each_with_index do |char, index|
      current_guess[index] = guess.downcase[0] if char == guess.downcase[0]
    end
  end

  def handler_incorrect_letter(guess)
    @guesses -= 1
    @display.incorrect_guess_message(guess.downcase[0])
  end

  def reset_guesses
    @guesses = 7
  end
end
