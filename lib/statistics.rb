class Statistics

  attr_reader \
    :wins,
    :losses,
    :total_amount_won,
    :capital

  attr_accessor \
    :capital_lost

  def initialize(capital:)
    @wins              = 0
    @losses            = 0
    @total_amount_won  = 0
    @capital_lost      = false
    @capital           = capital
  end

  def record_win(initial_bet)
    @wins             += 1
    @total_amount_won += initial_bet
  end

  def record_loss
    @losses += 1
  end

  def total_spins
    @wins + @losses
  end

  def win_percentage
    return 0 if total_spins == 0
    (@wins.to_f / total_spins) * 100
  end

  def loss_percentage
    return 0 if total_spins == 0
    (@losses.to_f / total_spins) * 100
  end

  def win_loss_ratio
    return 0 if @losses == 0
    @wins.to_f / @losses
  end

  def net_profit
    if @capital_lost
      @total_amount_won - @capital
    else
      @total_amount_won
    end
  end

  def summary
    {
      capital:          @capital,
      capital_lost:     @capital_lost,
      loss_percentage:  loss_percentage,
      losses:           @losses,
      net_profit:       net_profit,
      total_amount_won: @total_amount_won,
      total_spins:      total_spins,
      win_loss_ratio:   win_loss_ratio,
      win_percentage:   win_percentage,
      wins:             @wins
    }
  end
end
