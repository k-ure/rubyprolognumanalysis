#!/usr/bin/env ruby
require_relative '../lib/analyzer'

puts "Interactive Number Pattern Analysis"
puts "--------------------------------"

def get_user_input(prompt)
  print "#{prompt}: "
  gets.chomp
end

analyzer = NumberPatternAnalyzer.new

loop do
  start_num = get_user_input("Enter start number").to_f
  end_num = get_user_input("Enter end number").to_f
  step = get_user_input("Enter step size (default: 1)").to_f
  step = 1 if step == 0

  results = analyzer.analyze(start_num, end_num, step)
  puts "\nResults:"
  puts results

  puts "\nOptions:"
  puts "1. Export results"
  puts "2. Analyze another sequence"
  puts "3. Exit"
  
  choice = get_user_input("Choose an option").to_i
  case choice
  when 1
    format = get_user_input("Export format (csv/json)")
    analyzer.export_results("output.#{format}")
  when 2
    next
  when 3
    break
  end
end 