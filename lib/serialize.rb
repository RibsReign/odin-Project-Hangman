# frozen_string_literal: true

# Class that handles save state of the game
class Serialize
  def load_game
    return nil unless File.exist?('gamestate.txt')

    saved_data = File.read('gamestate.txt')
    YAML.safe_load(saved_data, permitted_classes: [Symbol])
  end

  def save_game(game_state)
    File.new('gamestate.txt', 'w')
    File.write('gamestate.txt', YAML.dump(game_state))
  end
end
