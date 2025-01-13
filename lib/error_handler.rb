class PatternAnalyzerError < StandardError; end

class ErrorHandler
  def self.handle_errors
    yield
  rescue PatternAnalyzerError => e
    puts "Analysis Error: #{e.message}"
    false
  rescue Errno::ENOENT => e
    puts "File Error: #{e.message}"
    false
  rescue StandardError => e
    puts "Unexpected Error: #{e.message}"
    puts e.backtrace if ENV['DEBUG']
    false
  end
end 