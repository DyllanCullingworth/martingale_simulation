# lib/roulette.rb
# This class simulates a European roulette wheel.
# In European roulette, there are 37 pockets:
# - 18 red numbers
# - 18 black numbers
# - 1 green number (zero)

class Roulette
  RED_NUMBERS = [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36].freeze

  # Returns true if the bet on red wins, false otherwise
  def spin
    RED_NUMBERS.include?(rand(0..36))
  end
end
