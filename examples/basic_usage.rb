#!/usr/bin/env ruby
require_relative '../lib/analyzer'

# Basic usage example
puts "Basic Square Analysis"
puts "-------------------"

analyzer = NumberPatternAnalyzer.new
results = analyzer.analyze(1, 5, 1)

puts "\nResults with pattern analysis:"
puts results.inspect

# Export results
analyzer.export_results('output.csv') 