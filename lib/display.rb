# frozen_string_literal: true

# Class that handles all the text outputs in the game
class Display
  def welcome_message(secret_word)
    puts 'Welcome to Hangmnan!'
    puts "The secret word has #{secret_word.length} characters."
  end

  def show_current_status(current_guess, guesses)
    puts '------------------------------------------------------------------'
    puts "Current word: #{current_guess.join(' ')}"
    puts "You have #{guesses} guesses left."
    enter_letter_message
  end

  def enter_letter_message
    puts 'Please enter a letter or type (save)/(load) to save/load the game:'
    puts '------------------------------------------------------------------'
  end

  def incorrect_guess_message(letter)
    puts "Sorry, '#{letter}' is not in the word."
  end

  def win_message(secret_word)
    puts "Congratulations! You guessed the word: #{secret_word.join}."
  end

  def lose_message(secret_word)
    puts "Game over! The word was: #{secret_word.join}."
  end

  def save_not_found
    puts 'Save not found, save your game first!'
  end

  def game_saved
    puts 'Your game was saved!'
  end

  def play_again?
    loop do
      puts 'Would you like to play again? (y/n)'
      input = gets.chomp.downcase
      return true if input == 'y'
      return false if input == 'n'

      puts "Invalid input. Please enter 'y' or 'n'."
    end
  end
end
