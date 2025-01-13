require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/analyzer'
require_relative '../lib/pattern_engine'
require_relative '../lib/prolog_interface'

# Helper methods for tests
module TestHelpers
  def setup_analyzer(options = {})
    NumberPatternAnalyzer.new(options)
  end

  def sample_sequence
    (1..5).map { |n| n * n }
  end
end 