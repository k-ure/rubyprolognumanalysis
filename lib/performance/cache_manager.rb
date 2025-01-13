require 'singleton'

class CacheManager
  include Singleton
  
  def initialize
    @cache = {}
    @pattern_cache = {}
  end

  def cached_calculation(key)
    @cache[key] ||= yield
  end

  def cached_pattern(sequence)
    key = sequence.hash
    @pattern_cache[key] ||= yield
  end

  def clear
    @cache.clear
    @pattern_cache.clear
  end
end 