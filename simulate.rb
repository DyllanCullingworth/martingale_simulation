require_relative 'lib/roulette'
require_relative 'lib/martingale_strategy'
require_relative 'lib/display'
require_relative 'lib/statistics'
require_relative 'lib/martingale_simulator'


initial_bet   = 50
max_levels    = 6
show_messages = false

simulator = MartingaleSimulator.new(initial_bet, max_levels, show_messages)
simulator.run
