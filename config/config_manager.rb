class OptionManager
    AVAILABLE_OPTIONS = {
      patterns_enabled: {
        description: 'Enable pattern analysis',
        type: :boolean,
        default: true
      },
      display_differences: {
        description: 'Show differences between squares',
        type: :boolean,
        default: true
      },
      display_fractions: {
        description: 'Show fractional representations',
        type: :boolean,
        default: true
      },
      auto_export: {
        description: 'Automatically export results',
        type: :boolean,
        default: false
      },
      export_format: {
        description: 'Export format (csv/json)',
        type: :select,
        options: ['csv', 'json'],
        default: 'csv'
      }
    }
  
    def initialize(config)
      @config = config
    end
  
    def display_options
      puts "\nCurrent Options:"
      puts "---------------"
      AVAILABLE_OPTIONS.each do |key, details|
        current_value = @config[key]
        puts "#{key}: #{current_value} (#{details[:description]})"
      end
    end
  
    def toggle_option(key)
      return unless AVAILABLE_OPTIONS.key?(key)
      
      case AVAILABLE_OPTIONS[key][:type]
      when :boolean
        @config[key] = !@config[key]
      when :select
        display_select_options(key)
        handle_select_option(key)
      end
      
      ConfigManager.save(@config)
    end
  
    private
  
    def display_select_options(key)
      puts "\nAvailable options for #{key}:"
      AVAILABLE_OPTIONS[key][:options].each_with_index do |option, index|
        puts "#{index + 1}. #{option}"
      end
    end
  
    def handle_select_option(key)
      print "Select option (1-#{AVAILABLE_OPTIONS[key][:options].length}): "
      choice = gets.chomp.to_i - 1
      if choice.between?(0, AVAILABLE_OPTIONS[key][:options].length - 1)
        @config[key] = AVAILABLE_OPTIONS[key][:options][choice]
      end
    end
  end 