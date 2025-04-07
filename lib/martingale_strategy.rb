# lib/martingale_strategy.rb
# This class implements the Martingale betting strategy for roulette.
# In this strategy:
# - Start with an initial bet
# - Double the bet after each loss
# - Return to the initial bet after a win
# - Limit the doubling to a maximum number of levels



class MartingaleStrategy
  attr_reader \
    :current_capital,
    :current_bet,
    :iteration,
    :statistics

  def initialize(initial_bet:, max_levels:, capital:)
    @initial_bet        = initial_bet
    @current_bet        = initial_bet
    @max_levels         = max_levels
    @consecutive_losses = 0
    @statistics         = Statistics.new(capital: capital)
  end

  def handle_win
    @consecutive_losses = 0
    @current_bet        = @initial_bet

    @statistics.record_win(@initial_bet)
  end

  def handle_loss
    @consecutive_losses += 1

    if @consecutive_losses >= @max_levels
      @statistics.capital_lost = true
    elsif @consecutive_losses < @max_levels
      # Double the bet for the next round, but only up to the max levels
      @current_bet *= 2
    end

    @statistics.record_loss
  end

  def capital_lost?
    @statistics.capital_lost
  end

end
