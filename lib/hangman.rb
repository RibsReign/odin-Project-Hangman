# frozen_string_literal: true

def load_secret_words
  words = File.read('google-10000-english-no-swears.txt')
  words.split.select { |word| (5..12).cover?(word.length) }
end

def get_new_word(secret_word)
  current_guess = Array.new(secret_word.length, '_')
  puts 'Welcome to Hangmnan!'
  puts "The secret word has #{secret_word.length} characters."
  p current_guess
  current_guess
end

secret_words = load_secret_words
p secret_word = secret_words[rand(secret_words.length)].chars
guesses = 7
current_guess = get_new_word(secret_word)
until current_guess == secret_word || guesses <= 0
  # Gives info
  puts "Current word: #{current_guess.join(' ')}"
  puts "You have #{guesses} guesses left."
  print 'Guess a letter: '

  # Ask for a letter
  guess = gets.chomp.downcase[0]
  if guess.nil? || guess.strip.empty?
    puts 'Please enter a letter.'
    next
  end

  if secret_word.include?(guess)
    secret_word.each_with_index do |char, index|
      current_guess[index] = guess if char == guess
    end
  else
    guesses -= 1
  end
end

puts "Good job! You've guessed the word it was: #{secret_word}"
