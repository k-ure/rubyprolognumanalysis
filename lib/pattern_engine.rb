require_relative 'prolog_interface'

class PatternEngine
  def initialize(debug: false)
    @debug = debug
    @prolog = PrologInterface.new(debug: debug)
  end

  def analyze_results(results)
    debug_log "Preparing results for Prolog analysis..."
    
    # Format data for Prolog
    sequence = format_for_prolog(results)
    
    # Single Prolog query with all data
    debug_log "Sending data to Prolog..."
    patterns = @prolog.query("analyze_sequence(#{sequence}, Patterns)")
    
    # Update results with patterns
    debug_log "Processing Prolog results..."
    attach_patterns_to_results(results, patterns)
  end

  private

  def format_for_prolog(results)
    # Convert Ruby data structure to Prolog list format
    numbers = results.map { |r| r[:num] }
    "[#{numbers.join(',')}]"
  end

  def attach_patterns_to_results(results, patterns)
    patterns.each do |pattern|
      results.each do |result|
        if pattern_applies?(pattern, result)
          result[:patterns] ||= []
          result[:patterns] << pattern
        end
      end
    end
  end

  def debug_log(message)
    puts "[DEBUG] #{message}" if @debug
  end
end 