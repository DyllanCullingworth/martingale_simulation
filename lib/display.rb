# lib/display.rb
# This class handles all user interaction and display formatting.

class Display

  def initialize(show_messages)
    @show_messages = show_messages
  end

  def show_welcome_message(initial_bet, max_levels, capital, max_bet)
    clear_screen
    puts "=" * 80
    puts "MARTINGALE ROULETTE BETTING STRATEGY SIMULATOR"
    puts "=" * 80
    puts "\nThis simulator demonstrates the Martingale betting strategy in roulette."
    puts "Starting capital: #{capital}"
    puts "Initial bet: #{initial_bet}"
    puts "Maximum bet level: #{max_bet} (after #{max_levels-1} consecutive losses)"
    puts "Game: European Roulette (18/37 chance of winning on red)"
    puts "\n"
  end

  def get_profit_goal_input
    print "Enter your target profit goal, leave blank to match capital:"
    gets.chomp.to_i
  end

  def show_error(message)
    puts "\nERROR: #{message}"
    puts "Press Enter to continue..."
    gets
  end

  def show_simulation_start(profit_goal, initial_capital)
    clear_screen
    puts "=" * 80
    puts "STARTING SIMULATION"
    puts "=" * 80
    puts "Target profit goal: R#{profit_goal}"
    puts "Initial capital: R#{initial_capital}"
    puts "Let's begin betting..."
    puts "-" * 80
    sleep(1)
  end

  def show_bet_info(iteration, bet_amount, current_profit)
    return unless @show_messages

    puts "\nIteration ##{iteration}"
    puts "Current bet: R#{bet_amount}"
    puts "Current profit: R#{current_profit}"
    print "Spinning the wheel... "
    sleep(0.3) # Small delay for better user experience
  end

  def show_win_result
    return unless @show_messages

    puts "WIN! 🎉"
  end

  def show_loss_result
    return unless @show_messages

    puts "LOSS! 😢"
  end

  def show_simulation_result(profit_goal, iterations, statistics)
    summary = statistics.summary

    puts "\n" + "=" * 80
    puts "SIMULATION COMPLETE"
    puts "=" * 80

    if statistics.capital_lost
      puts "You've lost your capital after #{iterations} iterations! 💸"
    elsif summary[:total_amount_won] >= profit_goal
      puts "Congratulations! You've reached your profit goal of R#{profit_goal} after #{iterations} iterations! 🎉"
    else
      puts "Simulation ended after #{iterations} iterations."
    end

    puts "\nSTATISTICS:"
    puts "-" * 80
    puts "Total spins: #{summary[:total_spins]}"
    puts "Wins: #{summary[:wins]} (#{summary[:win_percentage].round(2)}%)"
    puts "Losses: #{summary[:losses]} (#{summary[:loss_percentage].round(2)}%)"
    puts "Win/Loss ratio: #{summary[:win_loss_ratio].round(2)}"
    puts "Total amount won: R#{summary[:total_amount_won]}"
    puts "Initial capital: R#{summary[:capital]}"
    puts "Capital lost: #{summary[:capital_lost]}"
    puts "Net profit: R#{summary[:net_profit]}"
    puts "=" * 80
  end

  def continue?
    puts "\nWould you like to run another simulation? (y/n): "
    response = gets.chomp.downcase
    response == 'y'
  end

  def show_goodbye_message
    puts "\nThank you for using the Martingale Betting Simulator!"
    puts "Remember: In real life, no betting system can overcome the house edge."
    puts "Gambling should be for entertainment only, never as a way to make money."
    puts "Goodbye! 👋"
  end

  private

  def clear_screen
    system('clear') || system('cls')
  end
end
