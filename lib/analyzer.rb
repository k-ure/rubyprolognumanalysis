require_relative 'pattern_engine'
require_relative 'exporters/csv_exporter'
require_relative 'exporters/json_exporter'
require_relative '../config/config_manager'

class NumberPatternAnalyzer
  attr_reader :results, :computed

  def initialize(options = {})
    @debug = options[:debug]
    @config = ConfigManager.load
    @options = @config.merge(options)
    @results = []
    @computed = false
    @pattern_engine = PatternEngine.new(debug: @debug)
  end

  def compute(start_num, end_num, step = 1)
    debug_log "Starting computation with: start=#{start_num}, end=#{end_num}, step=#{step}"
    
    @results = calculate_sequence(start_num, end_num, step)
    @computed = true
    
    debug_log "Computation complete. #{@results.length} results stored."
    @results
  end

  def analyze_patterns
    unless @computed
      raise "No computed results available. Run compute() first."
    end

    debug_log "Starting pattern analysis..."
    @pattern_engine.analyze_results(@results)
    debug_log "Pattern analysis complete."
    
    @results
  end

  private

  def calculate_sequence(start_num, end_num, step)
    sequence = []
    current = start_num
    previous_square = nil

    debug_log "Calculating sequence..."
    
    while current <= end_num
      square = current * current
      difference = previous_square ? square - previous_square : 0
      
      sequence << {
        num: current,
        square: square,
        difference: difference,
        half_difference: difference / 2.0
      }
      
      previous_square = square
      current += step
    end

    debug_log "Generated #{sequence.length} results"
    sequence
  end

  def debug_log(message)
    puts "[DEBUG] #{message}" if @debug
  end
end
