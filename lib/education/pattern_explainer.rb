class PatternExplainer
  EXPLANATIONS = {
    square: {
      basic: "Square numbers are the product of a number with itself.",
      advanced: "They represent the area of a square and form a quadratic sequence.",
      examples: [
        "1×1 = 1 (area of 1×1 square)",
        "2×2 = 4 (area of 2×2 square)",
        "3×3 = 9 (area of 3×3 square)"
      ],
      formula: "n² where n is the base number"
    },
    fibonacci: {
      basic: "Each number is the sum of the previous two numbers.",
      advanced: "This sequence appears in nature and has connections to the golden ratio.",
      examples: [
        "1, 1, 2, 3, 5, 8, 13, 21, ...",
        "8 = 3 + 5",
        "13 = 5 + 8"
      ],
      formula: "F(n) = F(n-1) + F(n-2)"
    }
  }

  def self.explain(pattern_type, level: :basic)
    return unless EXPLANATIONS[pattern_type]
    
    puts "\nUnderstanding #{pattern_type.to_s.capitalize} Numbers:"
    puts "-" * 40
    puts EXPLANATIONS[pattern_type][:basic]
    
    if level == :advanced
      puts "\nAdvanced Explanation:"
      puts EXPLANATIONS[pattern_type][:advanced]
    end
    
    puts "\nExamples:"
    EXPLANATIONS[pattern_type][:examples].each do |example|
      puts "- #{example}"
    end
    
    puts "\nFormula:"
    puts EXPLANATIONS[pattern_type][:formula]
  end
end 