require 'json'
require_relative 'base_exporter'

class JSONExporter < BaseExporter
  def export(filename)
    ensure_directory(filename)
    File.write(filename, JSON.pretty_generate(@results))
  end
end 