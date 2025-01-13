#!/usr/bin/env ruby

# Core requires
require_relative '../lib/analyzer'
require_relative '../lib/cli_interface'
require_relative '../lib/pattern_engine'
require_relative '../lib/prolog_interface'

# Parse command line arguments
debug_mode = ARGV.include?('--debug')

begin
  # Initialize interface with debug mode
  interface = CLIInterface.new(debug: debug_mode)

  # Start either interactive or command-line mode
  if ARGV.empty?
    interface.start_interactive
  else
    interface.parse_arguments(ARGV)
  end
rescue StandardError => e
  puts "Error: #{e.message}"
  puts "Debug information:" if debug_mode
  puts e.backtrace if debug_mode
  exit 1
end