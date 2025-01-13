class ResultFormatter
  def self.format_results(results, options = {})
    output = []
    
    # Format basic calculations
    results[:calculations].each do |calc|
      line = format_calculation(calc, options)
      output << line
    end

    # Format patterns if enabled
    if options[:patterns_enabled] && results[:patterns]
      output << "\nPattern Analysis:"
      output << "-----------------"
      results[:patterns].each do |pattern|
        output.concat(format_pattern(pattern))
      end
    end

    output.join("\n")
  end

  private

  def self.format_calculation(calc, options)
    parts = []
    parts << sprintf("%g×%g = %g", calc[:num], calc[:num], calc[:square])
    
    if options[:display_differences] && calc[:difference]
      parts << sprintf("Δ: %g", calc[:difference])
      parts << sprintf("Δ/2: %.2f", calc[:half_difference])
    end

    parts.join("  |  ")
  end

  def self.format_pattern(pattern)
    [
      "  #{pattern[:type]}:",
      "    - #{pattern[:description]}",
      "    - #{pattern[:properties].join(', ')}"
    ]
  end
end 