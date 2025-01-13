class ASCIIPlotter
  def self.plot_sequence(results, width: 60, height: 20)
    max_value = results.map { |r| r[:square] }.max
    min_value = results.map { |r| r[:square] }.min
    
    puts "\nPattern Visualization:"
    puts "-" * width
    
    results.each_cons(2) do |prev, curr|
      plot_point(prev, curr, max_value, min_value, width)
    end
    
    puts "-" * width
  end

  private

  def self.plot_point(prev, curr, max, min, width)
    prev_y = normalize(prev[:square], min, max, width)
    curr_y = normalize(curr[:square], min, max, width)
    
    line = " " * width
    line[prev_y] = "•"
    line[curr_y] = "•"
    puts line
  end

  def self.normalize(value, min, max, width)
    ((value - min) * (width - 1) / (max - min)).round
  end
end 