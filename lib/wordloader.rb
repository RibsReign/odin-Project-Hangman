# frozen_string_literal: true

require_relative 'display'

# Class that handles loading in the words
class WordLoader
  def initialize
    @display = Display.new
  end

  def load_secret_words
    words = File.read('google-10000-english-no-swears.txt')
    words.split.select { |word| (5..12).cover?(word.length) }
  end

  def get_new_word(secret_word)
    current_guess = Array.new(secret_word.length, '_')
    @display.welcome_message(secret_word)
    current_guess
  end
end
