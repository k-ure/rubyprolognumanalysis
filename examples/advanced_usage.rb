#!/usr/bin/env ruby
require_relative '../lib/analyzer'
require_relative '../lib/visualization/ascii_plotter'
require_relative '../lib/education/pattern_explainer'

# Create analyzer with advanced features
analyzer = NumberPatternAnalyzer.new(
  patterns_enabled: true,
  visualization: true,
  educational: true
)

# Analyze sequence
results = analyzer.analyze(1, 10, 1)

# Visualize results
ASCIIPlotter.plot_sequence(results)

# Educational explanation
PatternExplainer.explain(:square, level: :advanced)

# Add custom pattern
analyzer.add_custom_pattern(:custom) do |n|
  {
    value: n * n * n,
    description: "Cube numbers",
    properties: ["Three-dimensional growth", "Volume calculation"]
  }
end

# Export with additional information
analyzer.export_results('advanced_analysis.json', include_explanations: true) 