require_relative 'test_helper'

class AnalyzerTest < Minitest::Test
  include TestHelpers

  def setup
    @analyzer = setup_analyzer
  end

  def test_basic_square_calculation
    results = @analyzer.analyze(1, 5, 1)
    expected = [1, 4, 9, 16, 25]
    assert_equal expected, results[:calculations].map { |c| c[:square] }
  end

  def test_difference_calculation
    results = @analyzer.analyze(1, 3, 1)
    differences = results[:calculations].map { |c| c[:difference] }
    assert_equal [0, 3, 5], differences
  end

  def test_pattern_detection
    results = @analyzer.analyze(1, 5, 1)
    assert results[:patterns].any? { |p| p[:type] == 'square' }
  end
end 