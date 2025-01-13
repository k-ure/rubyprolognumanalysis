module PatternExtension
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def register_pattern(name, &block)
      pattern_registry[name] = block
    end

    def pattern_registry
      @pattern_registry ||= {}
    end
  end

  def add_custom_pattern(name, &block)
    self.class.register_pattern(name, &block)
  end
end

# Example custom pattern:
# NumberPatternAnalyzer.register_pattern(:triangular) do |n|
#   (n * (n + 1)) / 2
# end 