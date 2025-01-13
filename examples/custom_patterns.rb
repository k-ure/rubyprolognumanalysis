#!/usr/bin/env ruby
require_relative '../lib/analyzer'

# Example of adding custom patterns
custom_pattern = <<~PROLOG
  pattern(custom_sequence, [2,4,8,16]) :-
      description('Powers of 2'),
      properties([
          growth_rate(2),
          formula('2^n')
      ]).
PROLOG

analyzer = NumberPatternAnalyzer.new
analyzer.add_custom_pattern(custom_pattern)

results = analyzer.analyze(2, 16, 2)
puts results.inspect 