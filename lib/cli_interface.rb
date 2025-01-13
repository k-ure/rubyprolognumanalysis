require_relative 'analyzer'
require 'yaml'
require 'open3'

class CLIInterface
  MENU_OPTIONS = {
    '1' => { name: 'Calculate Numbers', method: :calculate_numbers },
    '2' => { name: 'Analyze Patterns', method: :analyze_patterns },
    '3' => { name: 'Display Results', method: :display_results },
    '4' => { name: 'Export Results', method: :export_results },
    '5' => { name: 'Exit', method: :exit_program }
  }

  def initialize(debug: false)
    @debug = debug
    @analyzer = NumberPatternAnalyzer.new(debug: debug)
    @config = ConfigManager.load
  end

  def start_interactive
    loop do
      display_menu
      handle_choice(gets.chomp)
    end
  end

  def parse_arguments(args)
    options = parse_command_line_args(args)
    
    # Set defaults if not provided
    options[:start] ||= 1
    options[:end] ||= 100
    options[:step] ||= 1

    debug_log "Parsed arguments: #{options.inspect}"
    
    @analyzer.compute(options[:start], options[:end], options[:step])
  rescue ArgumentError => e
    puts "Error: #{e.message}"
    puts "Usage: run.rb [--debug] [--start N] [--end N] [--step N]"
    exit 1
  end

  def parse_command_line_args(args)
    options = {}
    args.each_with_index do |arg, index|
      case arg
      when '--start'
        options[:start] = args[index + 1].to_f
      when '--end'
        options[:end] = args[index + 1].to_f
      when '--step'
        options[:step] = args[index + 1].to_f
      end
    end
    options
  end

  def display_results
    if @analyzer.computed
      puts "\nResults:"
      puts "-" * 50
      @analyzer.results.each do |result|
        output = []
        output << sprintf("Number: %g", result[:num])
        output << sprintf("Square: %g", result[:square])
        output << sprintf("Difference: %g", result[:difference])
        output << sprintf("Half Difference: %.2f", result[:half_difference])
        
        if result[:patterns]
          output << "Patterns: #{result[:patterns].join(', ')}"
        end
        
        puts output.join(" | ")
      end
      puts "-" * 50
    else
      puts "No results available. Please calculate numbers first (option 1)."
    end
  end

  def exit_program
    puts "Goodbye!"
    exit(0)
  end

  private

  def display_menu
    puts "\nNumber Pattern Analyzer"
    puts "---------------------"
    MENU_OPTIONS.each do |key, option|
      puts "#{key}. #{option[:name]}"
    end
  end

  def calculate_numbers
    print "Start number: "
    start = gets.chomp.to_f
    print "End number: "
    end_num = gets.chomp.to_f
    print "Step size (default 1): "
    step = gets.chomp
    step = step.empty? ? 1 : step.to_f

    @analyzer.compute(start, end_num, step)
    puts "Computation complete. Type '2' to analyze patterns."
  end

  def analyze_patterns
    if @analyzer.computed
      @analyzer.analyze_patterns
      puts "Pattern analysis complete."
    else
      puts "Please calculate numbers first (option 1)."
    end
  end

  def handle_choice(choice)
    if MENU_OPTIONS.key?(choice)
      send(MENU_OPTIONS[choice][:method])
    else
      puts "Invalid option. Please try again."
    end
  end

  def debug_log(message)
    puts "[DEBUG] #{message}" if @debug
  end
end

class ConfigManager
  DEFAULT_CONFIG = {
    patterns_enabled: true,
    auto_export: false,
    export_format: 'csv',
    display_fractions: true,
    display_differences: true,
    pattern_categories: ['sequences', 'properties', 'relationships']
  }

  class << self
    def load
      config_file = File.join(__dir__, '../config/settings.yml')
      if File.exist?(config_file)
        DEFAULT_CONFIG.merge(YAML.load_file(config_file))
      else
        save(DEFAULT_CONFIG)
        DEFAULT_CONFIG
      end
    end

    def save(config)
      File.write(
        File.join(__dir__, '../config/settings.yml'),
        config.to_yaml
      )
    end
  end
end