require 'csv'
require_relative 'base_exporter'

class CSVExporter < BaseExporter
  def export(filename)
    ensure_directory(filename)
    CSV.open(filename, 'w') do |csv|
      csv << headers
      @results[:calculations].each do |calc|
        csv << row_from_calculation(calc)
      end
      
      if @results[:patterns]
        csv << []
        csv << ['Pattern Analysis']
        @results[:patterns].each do |pattern|
          csv << pattern_to_row(pattern)
        end
      end
    end
  end

  private

  def headers
    ['Number', 'Square', 'Difference', 'Half Difference', 'Patterns Found']
  end

  def row_from_calculation(calc)
    [
      calc[:num],
      calc[:square],
      calc[:difference],
      calc[:half_difference],
      calc[:patterns]&.join(', ')
    ]
  end

  def pattern_to_row(pattern)
    [pattern[:type], pattern[:description], pattern[:properties].join(', ')]
  end
end 