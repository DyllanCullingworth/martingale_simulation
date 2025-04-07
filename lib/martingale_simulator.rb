class MartingaleSimulator

  def initialize(initial_bet, max_levels, show_messages)
    @display     = Display.new(show_messages)
    @roulette    = Roulette.new
    @initial_bet = initial_bet
    @max_levels  = max_levels
    @capital     = calculate_capital(initial_bet, max_levels)
  end

  def run
    @display.show_welcome_message(@initial_bet, @max_levels, @capital, max_bet)

    loop do
      profit_goal = @display.get_profit_goal_input

      if profit_goal % @initial_bet != 0
        @display.show_error("Your profit goal must be in increments of R#{@initial_bet}")
        next
      end

      if profit_goal <= 0
        profit_goal = @capital
      end

      simulate_strategy(profit_goal)

      break unless @display.continue?
    end

    @display.show_goodbye_message
  end

  private

  def calculate_capital(initial_bet, max_levels)
    capital = 0

    max_levels.times do |i|
      capital += initial_bet * (2**i)
    end

    capital
  end

  def max_bet
    (2**@max_levels) * @initial_bet
  end

  def simulate_strategy(profit_goal)
    strategy = MartingaleStrategy.new(
      initial_bet: @initial_bet,
      max_levels:  @max_levels,
      capital:     @capital
    )

    @iteration = 1
    @display.show_simulation_start(profit_goal, @capital)

    while !strategy.capital_lost? && (strategy.statistics.total_amount_won < profit_goal)
      bet_amount     = strategy.current_bet
      current_profit = strategy.statistics.total_amount_won

      @display.show_bet_info(@iteration, bet_amount, current_profit)
      @iteration += 1

      win = @roulette.spin

      if win
        strategy.handle_win
        @display.show_win_result
      else
        strategy.handle_loss
        @display.show_loss_result
      end
    end

    @display.show_simulation_result(
      profit_goal,
      @iteration,
      strategy.statistics
    )
  end
end
