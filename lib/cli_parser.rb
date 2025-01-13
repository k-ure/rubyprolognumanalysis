require 'optparse'

class CLIParser
  def self.parse(args)
    options = {
      start: 1,
      end: 100,
      step: 1,
      patterns: true,
      export: nil,
      format: 'csv'
    }

    parser = OptionParser.new do |opts|
      opts.banner = "Usage: run.rb [options]"

      opts.on("-s", "--start N", Float, "Start number") do |n|
        options[:start] = n
      end

      opts.on("-e", "--end N", Float, "End number") do |n|
        options[:end] = n
      end

      opts.on("-t", "--step N", Float, "Step size") do |n|
        options[:step] = n
      end

      opts.on("-p", "--[no-]patterns", "Enable/disable pattern analysis") do |v|
        options[:patterns] = v
      end

      opts.on("-o", "--output FILE", "Export results to file") do |f|
        options[:export] = f
      end

      opts.on("-f", "--format FORMAT", %w[csv json], "Export format (csv/json)") do |f|
        options[:format] = f
      end

      opts.on("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end

    parser.parse!(args)
    options
  end
end 